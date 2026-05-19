#!/bin/bash
cd "$(dirname "$0")"
sbatch --partition=short 01_fastqc_raw.slurm
sleep 10
sbatch --partition=short 02_multiqc_before.slurm
