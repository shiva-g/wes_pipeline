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
     perl $(inputs.path_to_annovar)/table_annovar.pl $(inputs.genotyped_filtered_vcf.path) $(inputs.path_to_annovar)/humandb/ -buildver hg19 -out $(inputs.genotyped_filtered_vcf.nameroot)_myanno -remove -protocol refGeneWithVer,ensGene,cytoBand,genomicSuperDups,gnomad211_exome,gnomad211_genome,clinvar_20190305,dbnsfp35a,popfreq_all_20150413,avsnp150,gwava,dbscsnv11,intervar_20180118_edit,kaviar_20150923,gme,all.para_zscore,hgmd_2019_3,ddd_denovo,heyne,lindy,epi25_non_gnomad -operation g,g,r,r,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f -nastring . -vcfinput
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
