cwlVersion: v1.0
class: Workflow
id: pipeline

inputs:
  reference:
    type: File
    secondaryFiles: [.ann, .bwt, .pac, .sa, .rsa, .rbwt, .bwt, .ann ,.amb, .fai, ^.dict]
  input_vcf1:
    type: File
    secondaryFiles: [.tbi]
  input_vcf2: 
    type: File
    secondaryFiles: [.tbi]
  input_vcf3: 
    type: File
    secondaryFiles: [.tbi]
  sample_name: string
  path_to_annovar: string
  java: string
  gatk: string
  picard: string
  bcftools: string

outputs:
  merge_vcf:
    type: File
    outputSource: bcf_merge/output
  annotation_txt:
    type: File
    outputSource: annovar_final/txt
steps:
  bcf_merge:
    run: bcftools_merge.cwl
    in:
      input_vcf1: input_vcf1
      input_vcf2: input_vcf2
      input_vcf3: input_vcf3
      sample_name: sample_name
      bcftools: bcftools
    out: [output]
  
  gatkv4_SelectVariants:
    run: select_variants_indel.cwl
    in:
  #    reference: reference
      vcf: bcf_merge/output
      java: java
      gatk: gatk
    out: [output]

  gatkv4_SelectVariants_snp:
    run: select_variants_snp.cwl
    in:
  #    reference: reference
      vcf: bcf_merge/output
      java: java
      gatk: gatk
    out: [output]

  gatkv4_VariantFiltration:
    run: variantfiltration_indel.cwl
    in:
   #   reference: reference
      raw_indel_vcf: gatkv4_SelectVariants/output
      java: java
      gatk: gatk
    out: [output]

  gatkv4_VariantFiltration_snp:
    run: variantfiltration_snps.cwl
    in:
    #  reference: reference
      raw_snp_vcf: gatkv4_SelectVariants_snp/output
      java: java
      gatk: gatk
    out: [output]

  picard_MergeVcfs_2:
    run: picard_mergevcfs.cwl
    in:
   #   reference: reference
      filtered_snp_vcf: gatkv4_VariantFiltration_snp/output
      filtered_indel_vcf: gatkv4_VariantFiltration/output
      sample_name: sample_name
      picard: picard
      java: java
    out: [output]

  annovar:
    run: annovar_new.cwl
    in:
      genotyped_filtered_vcf: picard_MergeVcfs_2/output
      path_to_annovar: path_to_annovar
    out: [vcf, txt]
  
  annovar_1:
    run: annovar_1.cwl
    in:
      genotyped_filtered_vcf: annovar/vcf
      path_to_annovar: path_to_annovar
    out: [vcf, txt]

  annovar_final:
    run: annovar_edit.cwl
    in:
      annotated_txt: annovar/txt
      ccr_txt: annovar_1/txt
    out: [txt]
