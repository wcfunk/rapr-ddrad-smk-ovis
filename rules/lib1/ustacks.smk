# Build loci de novo in each sample

rule ustacks:
    input:
        R1="results/lib1/process_radtags/{sample}.1.fq.gz",
    output:
        tags="results/lib1/stacks_denovo/ustacks/{sample}.tags.tsv.gz",	
        snps="results/lib1/stacks_denovo/ustacks/{sample}.snps.tsv.gz",
        alleles="results/lib1/stacks_denovo/ustacks/{sample}.alleles.tsv.gz"
    conda:
        "../../envs/stacks.yaml"
    resources:
        cpus=10,
        mem_mb=78000,
        time="3-00:00:00"
    log:
        "results/lib1/logs/stacks_denovo/ustacks/{sample}.log"
    benchmark:
        "results/lib1/benchmarks/stacks_denovo/ustacks/{sample}.bmk"
    shell:
        " (ustacks -f {input.R1}			"
        " -o results/lib1/stacks_denovo/ustacks/		"
        " -m 3 -M 2 -d -t gzfastq -p 10			"
        " --model_type bounded --bound_high 0.05)	"
        "  2> {log}					"
