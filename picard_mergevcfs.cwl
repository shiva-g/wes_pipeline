cwlVersion: v1.0
class: CommandLineTool
id: picard_MergeVcfs
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 4000
baseCommand: []
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >-
      $(inputs.java) -Xmx4000m -jar $(inputs.picard) MergeVcfs
      I=$(inputs.filtered_snp_vcf.path)
      I=$(inputs.filtered_indel_vcf.path)
      O=genotyped_$(inputs.sample_name)_filtered.vcf

inputs:
#  reference:
#    type: File
#    secondaryFiles: [^.dict, .fai]
  filtered_snp_vcf:
    type: File
  filtered_indel_vcf:
    type: File
  sample_name:
    type: string
  picard:
    type: string
  java:
    type: string
outputs:
  output:
    type: File
    outputBinding:
      glob: '*_filtered.vcf'
