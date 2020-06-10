cwlVersion: v1.0
class: CommandLineTool
id: annovar
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 8000
baseCommand: []
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >-
     perl $(inputs.path_to_annovar)/table_annovar.pl $(inputs.genotyped_filtered_vcf.path) $(inputs.path_to_annovar)/humandb/ -buildver hg19 -out $(inputs.genotyped_filtered_vcf.nameroot)_ccranno -remove -protocol bed -bed ccrs_v2.bed -arg '-ColsWanted 4' -operation r -nastring . -vcfinput
inputs:
  genotyped_filtered_vcf:
    type: File
  path_to_annovar:
    type: string
outputs:
  vcf:
    type: File
    outputBinding:
      glob: '*.vcf'
  txt:
    type: File
    outputBinding:
      glob: '*.txt'
