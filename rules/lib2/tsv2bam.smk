# Transpose the data so it is stored by locus, instead of by sample. We will include
# paired-end reads using tsv2bam.

rule tsv2bam:
    input:
        "results/stacks_denovo/sstacks/{sample}.matches.tsv.gz"
    output:
        "results/stacks_denovo/tsv2bam/{sample}.matches.bam",
        "results/stacks_denovo/tsv2bam/{sample}.out",
        "results/stacks_denovo/tsv2bam/{sample}.err"
    params:
        popmap=config["popmap"],
    conda:
        "../envs/stacks.yaml"
    resources:
        cpus=10,
        mem_mb=78000,
        time="24:00:00"
    log:
        "results/logs/stacks_denovo/tsv2bam/{sample}.log"
    benchmark:
        "results/benchmarks/stacks_denovo/tsv2bam/{sample}.bmk"
    shell:
        " (tsv2bam				"
        " -P results/stacks_denovo/sstacks/	"
        " -o results/stacks_denovo/tsv2bam/	"    
        " -R results/process_radtags/   	"
        " -M {params.popmap} -t 10) 		"
        " 2> {log}				"
