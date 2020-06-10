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
     sed '2d' $(inputs.ccr_txt.path) | cut -f 6 > test.txt ; paste --delimiters="	" $(inputs.annotated_txt.path) test.txt > $(inputs.annotated_txt.nameroot)_final_anno.txt
inputs:
  annotated_txt:
    type: File
  ccr_txt:
    type: File
outputs:
  txt:
    type: File
    outputBinding:
      glob: '*final_anno.txt'
