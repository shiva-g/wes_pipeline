cwlVersion: v1.0
class: CommandLineTool
id: bcftools_merge
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 8000
baseCommand: []
arguments:
  - position: 0
    shellQuote: false
    valueFrom: >-
      $(inputs.bcftools) merge --merge all $(inputs.input_vcf1.path) $(inputs.input_vcf2.path) $(inputs.input_vcf3.path) > $(inputs.sample_name).vcf

inputs:
  bcftools:
    type: string
  sample_name:
    type: string
  input_vcf1:
    type: File
    secondaryFiles: [.tbi]
  input_vcf2:
    type: File
    secondaryFiles: [.tbi]
  input_vcf3:
    type: File
    secondaryFiles: [.tbi]
outputs:
  output:
    type: File
    outputBinding:
      glob: '*.vcf'
