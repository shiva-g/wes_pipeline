cwlVersion: v1.0
class: CommandLineTool
id: gatkv4_VariantFiltration
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 8000
baseCommand: []
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >-
      $(inputs.java) -Xmx4000m -jar $(inputs.gatk) VariantFiltration
      -V $(inputs.raw_indel_vcf.path)
      --filter-expression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0"
      --filter-name "my_indel_filter"
      -O filtered_indels.vcf

inputs:
#  reference:
#    type: File
#    secondaryFiles: [^.dict, .fai]
  raw_indel_vcf:
    type: File
  java:
    type: string
  gatk:
    type: string
outputs:
  output:
    type: File
    outputBinding:
      glob: filtered_indels.vcf
