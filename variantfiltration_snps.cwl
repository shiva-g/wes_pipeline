cwlVersion: v1.0
class: CommandLineTool
id: gatkv4_VariantFiltration_snp
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
      -V $(inputs.raw_snp_vcf.path)
      --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0"
      --filter-name "my_snp_filter"
      -O filtered_snps.vcf

inputs:
#  reference:
#    type: File
#    secondaryFiles: [^.dict, .fai]
  raw_snp_vcf:
    type: File
  java:
    type: string
  gatk:
    type: string
outputs:
  output:
    type: File
    outputBinding:
      glob: filtered_snps.vcf
