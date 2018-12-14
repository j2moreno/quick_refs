# Snakemake

1. Import short names from `os.path`<br/>
`from os.path import abspath, basename, dirname, join, splitext`

1. Add safeguards for shell<br/>
`shell.prefix('set -eux; set -o pipefail')`

1. Establish BASE global variable<br/>
`BASE = os.environ.get('BASE', abspath(basename(__file__)))`

1. Set WORK global variable<br/>
`WORK = os.environ.get('WORK', f'{BASE}/run/test/work') `

1. Add target rules at top as `target_<name>`

1. Any output from a rule goes in its own folder named after rule
`output: bam='{WORK}/align/{sample}.bam'`

1. Use fully qualified paths with global prefix variable<br/>
`input: gene_list='{BASE}/metadata/gene_list.tsv', bam='{WORK}/align/123.bam'`

1. Eliminate paths for a specific user<br/>
Change `/home/m/msmith/dev/usf-hii/project_foo/tmp/data/123.fq` to `{BASE}/tmp/data/123.fq` or even better, relocate to
`/shares/hii/bioinfo/ref/project_foo/test_data/123.fq`

1. Use same name for rule name, log, and job name (e.g. rule `align`)<br/>
`params: job_name='align-{sample}', log='align/{sample}.log', cpus='1', mem='10G', time='0-4', ...`

1. Use `SLURM_CPUS_PER_TASK` with default for setting threads variable<br/>
`shell: "threads=${{SLURM_CPUS_PER_TASK:-1}}; program --threads=$threads arg1 arg2..."`
