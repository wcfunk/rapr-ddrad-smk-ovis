# Build the catalog of loci available in the metapopulation from the samples contained
# in the population map.

rule cstacks:
    input:
        expand("results/lib1/stacks_denovo/ustacks/{s}.tags.tsv.gz", s=SAMPLES),	
        expand("results/lib1/stacks_denovo/ustacks/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/lib1/stacks_denovo/ustacks/{s}.alleles.tsv.gz", s=SAMPLES)
    output:
        "results/lib1/stacks_denovo/cstacks/catalog.tags.tsv.gz",
        "results/lib1/stacks_denovo/cstacks/catalog.snps.tsv.gz",
        "results/lib1/stacks_denovo/cstacks/catalog.alleles.tsv.gz",
        "results/lib1/stacks_denovo/cstacks/catalog.sample_list.tsv.gz"
    params:
        popmap=config["popmap"],
    conda:
        "../../envs/stacks.yaml"
    resources:
        cpus=24,
        mem_mb=187200,
        time="3-00:00:00"
    log:
        "results/lib1/logs/stacks_denovo/cstacks/cstacks.log"
    benchmark:
        "results/lib1/benchmarks/stacks_denovo/cstacks/cstacks.bmk"
    shell:
        " (cstacks				"
        " -P results/lib1/stacks_denovo/ustacks/	"
        " -o results/lib1/stacks_denovo/cstacks/	"
        " -M {params.popmap}			"
        " -n 3 -p 24) 2> {log}			"
