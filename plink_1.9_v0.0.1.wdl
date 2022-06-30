
version development

task plink {
    input {
        File vcf_
        Float? geno_
        Float? mind_
        Float? hwe_
        Float? maf_
        Float? max_maf_
        String? biallelic_only_
        File? extract_
        File? exclude_
        File? update_ids_
        File? update_name_
        File? update_map_
        Boolean? keep_allele_order_
        String? recode_
        String vcf_out = 'plink_out'
        String? memory_
        Int? cpus_
    }

    command <<<
        set -e -o pipefail

        plink \
        ~{if defined(vcf_) then '--vcf ${vcf_}' else ''} \
        ~{if defined(geno_) then '--geno ${geno_}' else ''} \
        ~{if defined(mind_) then '--mind ${mind_}' else ''} \
        ~{if defined(hwe_) then '--hwe ${hwe_}' else ''} \
        ~{if defined(maf_) then '--maf ${maf_}' else ''} \
        ~{if defined(max_maf_) then '--max-maf ${max_maf_}' else ''} \
        ~{if defined(biallelic_only_) then '--biallelic-only ${biallelic_only_}' else ''} \
        ~{if defined(extract_) then '--extract ${extract_}' else ''} \
        ~{if defined(exclude_) then '--exclude ${exclude_}' else ''} \
        ~{if defined(update_ids_) then '--update_ids ${update_ids_}' else ''} \
        ~{if defined(update_name_) then '--update-name ${update_name_}' else ''} \
        ~{if defined(update_map_) then '--update-map ${update_map_}' else ''} \
        ~{if defined(keep_allele_order_) then '--keep-allele-order' else ''} \
        ~{if defined(recode_) then '--recode ${recode_}' else ''} \
        ~{if defined(vcf_out) then '--out ${vcf_out}' else ''}
    >>>

    runtime {
        docker: 'us.icr.io/gnome/plink@sha256:78e534c13d3f990645b62b4959ff07d4df0d49886e34ae9b2dff17a79dbe0337'
        docker_user: 'root'
        memory: if defined(memory_) then "${memory_}" else ""
        cpu: if defined(cpus_) then "${cpus_}" else ""
    }

    output {
        File vcf_out_ = vcf_out + ".vcf"
    }
}

