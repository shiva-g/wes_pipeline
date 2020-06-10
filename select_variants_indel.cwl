cwlVersion: v1.0
class: CommandLineTool
id: gatkv4_SelectVariants
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 8000
baseCommand: []
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >-
      $(inputs.java) -Xmx4000m -jar $(inputs.gatk) SelectVariants
      -V $(inputs.vcf.path)
      -select-type INDEL
      -O raw_indels.vcf

inputs:
#  reference:
#    type: File
#    secondaryFiles: [^.dict, .fai]
  vcf:
    type: File
  java:
    type: string
  gatk:
    type: string
outputs:
  output:
    type: File
    outputBinding:
      glob: '*.vcf'
