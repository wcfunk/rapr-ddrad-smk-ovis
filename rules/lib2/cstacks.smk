# Build the catalog of loci available in the metapopulation from the samples contained
# in the population map.

rule cstacks:
    input:
        expand("results/stacks_denovo/ustacks/{s}.tags.tsv.gz", s=SAMPLES),	
        expand("results/stacks_denovo/ustacks/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/stacks_denovo/ustacks/{s}.alleles.tsv.gz", s=SAMPLES)
    output:
        "results/stacks_denovo/cstacks/catalog.tags.tsv.gz",
        "results/stacks_denovo/cstacks/catalog.snps.tsv.gz",
        "results/stacks_denovo/cstacks/catalog.alleles.tsv.gz",
        "results/stacks_denovo/cstacks/catalog.sample_list.tsv.gz",
        "results/stacks_denovo/cstacks/cstacks.out",
        "results/stacks_denovo/cstacks/cstacks.err"
    params:
        popmap=config["popmap"],
    conda:
        "../envs/stacks.yaml"
    resources:
        cpus=24,
        mem_mb=187200,
        time="24:00:00"
    log:
        "results/logs/stacks_denovo/cstacks/cstacks.log"
    benchmark:
        "results/benchmarks/stacks_denovo/cstacks/cstacks.bmk"
    shell:
        " (cstacks				"
        " -P results/stacks_denovo/ustacks/	"
        " -o results/stacks_denovo/cstacks/	"
        " -M {params.popmap}			"
        " -n 3 -p 24) 2> {log}			"
