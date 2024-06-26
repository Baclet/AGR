# workflow/rules/assembly_nano.smk

# Import der benötigten Module
from snakemake.io import expand, glob_wildcards

# Regeln fürs assembly der Nanopore Reads
rule assembly_flye:
    input:
        "result/{sample}/intermediate/nanopore/{sample}_trimmed.fastq"
    output:
        nano_assembly = "result/{sample}/intermediate/assembly_flye/{sample}_assembly.fasta"
    params:
        outdir = "result/{sample}/intermediate/assembly_flye"
    conda:
        "../../workflow/env/assembly_flye.yml"
    threads: 8
    log:
        "logs/assembly_flye/{sample}.log"
    shell:
        """
        mkdir -p {params.outdir}
        flye --nano-raw "{input}" --out-dir "{params.outdir}" --threads {threads} 2>&1 | tee {log}
        mv "{params.outdir}/assembly.fasta" "{output.nano_assembly}"
        """

