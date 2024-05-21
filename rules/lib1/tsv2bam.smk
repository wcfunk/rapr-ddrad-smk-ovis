# Transpose the data so it is stored by locus, instead of by sample. We will include
# paired-end reads using tsv2bam.

rule tsv2bam:
    input:
        "results/lib1/stacks_denovo/sstacks/{sample}.matches.tsv.gz"
    output:
        "results/lib1/stacks_denovo/tsv2bam/{sample}.matches.bam"
    params:
        popmap=config["popmap"],
    conda:
        "../../envs/stacks.yaml"
    resources:
        cpus=10,
        mem_mb=78000,
        time="3-00:00:00"
    log:
        "results/lib1/logs/stacks_denovo/tsv2bam/{sample}.log"
    benchmark:
        "results/lib1/benchmarks/stacks_denovo/tsv2bam/{sample}.bmk"
    shell:
        " (tsv2bam				"
        " -P results/lib1/stacks_denovo/sstacks/	"
        " -o results/lib1/stacks_denovo/tsv2bam/	"    
        " -R results/lib1/process_radtags/      "
        " -M {params.popmap} -t 10)             "
        " 2> {log}				"
