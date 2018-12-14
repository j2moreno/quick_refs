# bashrc template

#------------------------------------------------------------------------
# Helper functions
#------------------------------------------------------------------------

is_interactive_shell() {
  [[ "$-" =~ "i" ]]
}

#------------------------------------------------------------------------
# Color/Terminal Escape Codes
#------------------------------------------------------------------------

# ps_ variables use special \[ and \] to tell bash PS1 not to count these characters
# and prevents line-wrapping issue

ps_blue="\[\033[0;34m\]"
ps_cyan="\[\033[1;96m\]"
ps_green="\[\033[0;32m\]"
ps_white="\[\033[1;97m\]"
ps_yellow="\[\033[1;33m\]"
ps_reset="\[\033[0m\]"

blue='\033[0;34m'
cyan='\033[1;96m'
green='\033[0;32m'
white='\033[1;97m'
yellow='\033[1;33m'
reset='\033[0m'

#------------------------------------------------------------------------
# Function aliases
#------------------------------------------------------------------------

run_cmd() {
  echo 1>&2
  echo "cmd> $*" 1>&2
  "$@"
}

cdf() {
  # alias: cdf [pattern] - cd into directory with fuzzy finder

  local dir=$(find . -type d | egrep -v '\.git|\.snakemake' | fzf +m -q "$1") && cd "$dir"
}

cdp() {
  # alias: cdp [query] - cd into $PROJECTS_DIR project using fzf

  local repo fzf_options
  local projects_dir=${PROJECTS_DIR:-~/projects}

  [[ -n $1 ]] && fzf_options="--select-1 --query=$1"

  cd ${projects_dir}/$(for project in $(ls ${projects_dir}); do echo ${project}; done | fzf ${fzf_options})

  clear

  if [[ -d .git ]]; then
    printf '> git fetch --quiet (%s)\n' "$(git config --get remote.origin.url)"
    git fetch --quiet
    git branch --verbose
    git status --short
  fi
}

clone-hpc() {
   # alias: clone-hpc - Copies/updates from https://github.com/usf-hii/template-hpc to current directory

   local found_dir='false'
   local dirname

   for dirname in ~/dev/usf-hii ~/projects ~/src; do
     if [[ -d ${dirname} ]]; then
         found='true'
         break
     fi
   done

   [[ $found = 'true' ]] || dirname=~/projects

   if [[ ! -d ${dirname}/template-hpc ]]; then
     git clone --quiet git@github.com:usf-hii/template-hpc $dirname/template-hpc
   fi

   git -C ${dirname}/template-hpc pull --quiet

   ${dirname}/template-hpc/Clone.sh $(pwd) | bash -x
}

cls() {
  # alias: cls - clear screen

  clear
}

getnode() {
  srun \
    --pty \
    --mem=60G \
    --partition=hii-interactive \
    --exclusive \
    --nodes=1 \
    --ntasks-per-node=1 \
    --time=7-0 \
    "$@" \
    /bin/bash
}

helpbio() {
  # alias: helpbio - print out help for bioinformatcs bash environment

  local IFS=$'\n'

  echo "-----------------------------------------------------------------------------"
  echo "Help for bioinfo aliases and tools (https://github.com/usf-hii/bioinfo-home/)"
  echo "-----------------------------------------------------------------------------"
  echo

  echo "Aliases"

  for line in $(grep '# alias: ' ${BASH_SOURCE[0]} | grep -v "grep  '# alias:'" | sed -r -e 's/# alias://' -e 's/^\s+//'); do
    printf "${green}%-32s${reset} %s\n" \
      $(echo ${line} | sed -r 's/^(.*)\s+-\s+.*/\1/') \
      $(echo ${line} | sed -r 's/^.*\s+-\s+(.*)/\1/')
  done

  echo
  echo "Commands"

  printf "${green}%-32s${reset} %s\n" "github-repos" "List all repos for USF-HII"
  printf "${green}%-32s${reset} %s\n" "gpfs-quota" "List all total,free,used quotas on HPC for HII GPFS"
  printf "${green}%-32s${reset} %s\n" "<command> <path>/**<TAB>" "Path completion using FZF"
  printf "${green}%-32s${reset} %s\n" "<command> <CTRL-T>" "Use FZF to select target file for <command>"
  printf "${green}%-32s${reset} %s\n" "<CTRL-R>" "Find command line history using FZF"
}

sa() {
  # alias: sa [hours] [sacct_opts...] - detailed slurm sacct info for user (default past 48 hours)

  if [[ $1 != -* ]]; then
     local hours=${1:-48}; shift
  else
     local hours=48
  fi

  local start_time=$(date -d "${hours} hours ago" '+%FT%T')

  run_cmd \
  /usr/bin/sacct \
    --format=user,node%-20,jobid%-16,jobname%-72,start,elapsed,ncpus,reqm,ntasks,avecpu,maxrss,state \
    --user=${USER} \
    -S ${start_time} \
    "$@"
}

sb() {
  # alias: sb - source your ~/.bashrc
  source ~/.bashrc
}

si() {
  # alias: si [sinfo_opts...] - detailed slurm sinfo command

  sinfo --partition=hii02,hii-test,hii-interactive --format="%20P %8D %8c %12m %12a %12T %10l %8t %12A" "$@";
}

sq() {
  # alias: sq [squeue_opts...] - squeue with fancing formatting for current user

  squeue \
    --user=$USER \
    --partition=hii02,hii-test,hii-interactive \
    --format='%24i %8P %10T %42j %12a %12u %20V %8M %8l %8c %10m %N %E' \
    "$@";
}

sq-grep() {
  # alias: sq-grep [-q] <regex> - print slurm job ids and job names matching <regex>, '-q' prints just job id

  if [[ "${1:-''}" == '-q' ]]; then
    shift
    squeue --user $USER --noheader --format='%A %j %T %M' | grep --perl-regex "^\\d+\\s+.*$1" | awk '{print $1}'
  else
    squeue --user $USER --noheader --format='%A %j %T %M' | grep --perl-regex "^\\d+\\s+.*$1"
  fi
}

termbin() {
  # alias: termbin - pastes STDIN to https://termbin.com and returns URL

  nc termbin.com 9999
}

tmux() {
  /shares/hii/sw/tmux/latest/bin/tmux -2 "$@"
}

vb() {
  # alias: vb - edit ~/.bashrc and source it after exiting

  ${EDITOR:-vim} ~/.bashrc
  source ~/.bashrc
}

#------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------

main_bashrc() {

  MYDIR=$(readlink -f $(dirname "${BASH_SOURCE[0]}")/..)

  [[ $PATH =~ :?${MYDIR}/bin:? ]] || PATH=${MYDIR}/bin:${PATH}
  [[ $PATH =~ :?/shares/hii/sw/git/latest/bin:? ]] || PATH=/shares/hii/sw/git/latest/bin:$PATH
  [[ $PATH =~ :?/shares/hii/sw/tmux/latest/bin:? ]] || PATH=/shares/hii/sw/tmux/latest/bin:$PATH

  if [[ $(uname -n) == 'hii.rc.usf.edu' ]]; then
    git() {
      /usr/bin/git "$@";
    }
  fi

  [[ -f ${MYDIR}/etc/bashrc.fzf.bindings ]] && source ${MYDIR}/etc/bashrc.fzf.bindings
  [[ -f ${MYDIR}/etc/bashrc.fzf.completion ]] && source ${MYDIR}/etc/bashrc.fzf.completion
  [[ -f ${MYDIR}/etc/bashrc.git.prompt ]] && source ${MYDIR}/etc/bashrc.git.prompt

  export EDITOR="vim"

  export LESS="--hilite-search --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS --no-init --tabs=2"

  shopt -s cmdhist       # store multiline commands as single entries
  shopt -s histappend    # append to history rather than overwrite
  shopt -s histreedit    # puts failed hist sub back on cli
  shopt -s cdable_vars

  shopt -s direxpand 2>/dev/null

  bind 'set bell-style              none' &>/dev/null
  bind 'set show-all-if-ambiguous   on' &>/dev/null
  bind 'set completion-query-items  100' &>/dev/null
  bind 'set mark-directories        on' &>/dev/null # append slash to completed dir name
  bind 'set mark-modified-lines     off' &>/dev/null # show * for modified history lines

  #------------------------------------------------------------------------
  # Directory variables
  #------------------------------------------------------------------------

  bio=/shares/hii/bioinfo
  fpdata=/shares/hii/fac/parikhh/data

  #------------------------------------------------------------------------
  # Bash Prompt
  #------------------------------------------------------------------------
  PS1="${ps_yellow}\u${ps_reset}"
  PS1="${PS1}${ps_white}@${ps_reset}"
  PS1="${PS1}${hostname:-$(uname -n)}"
  PS1="${PS1}${ps_yellow}:${ps_reset}"
  PS1="${PS1}${ps_cyan}\w${ps_reset}"

  if type -t __git_ps1 &>/dev/null; then
    GIT_PS1_SHOWDIRTYSTATE=yes
    GIT_PS1_SHOWUPSTREAM=verbose
    GIT_PS1_SHOWCOLORHINTS=true
    PS1="${PS1} ${ps_green}\$(__git_ps1 \(%s\))${ps_reset}"
  fi

  if [[ -n ${SINGULARITY_NAME} ]]; then
    PS1="${PS1}\n[${ps_white}SINGULARITY${ps_reset}]\$ "
  else
    PS1="${PS1}\n\$ "
  fi

  export PROMPT_COMMAND='history -a; echo -ne "\033]0;$USER@$(hostname -s):$PWD\007"; printf "\n";'
  export PS1
}

if is_interactive_shell; then
  main_bashrc
fi
