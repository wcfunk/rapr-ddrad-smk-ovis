# Remove extra 1s and 2s from end of fastq files

rule rename_fastqs:
    input:
        R1extraones="results/process_radtags/{sample}_1.1.1.fq.gz",
        R2extratwos="results/process_radtags/{sample}_2.2.2.fq.gz"
    output:
        R1="results/process_radtags/{sample}.1.fq.gz",
        R2="results/process_radtags/{sample}.2.fq.gz"
    resources:
        cpus=1,
        mem_mb=7800,
        time="00:30:00"
    log:
        "results/logs/rename_fastqs/{sample}.log"
    benchmark:
        "results/benchmarks/rename_fastqs/{sample}.bmk"
    shell:
        """
        mv {input.R1extraones} {output.R1} &&
        mv {input.R2extratwos} {output.R2}
        """
