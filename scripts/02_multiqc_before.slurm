#!/bin/bash
#SBATCH --job-name=multiqc_anna
#SBATCH --output=multiqc_%j.out
#SBATCH --error=multiqc_%j.err
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --partition=short

set -euo pipefail

INPUT_DIR=~/bioinf_hw5/results/fastqc_raw
OUT_DIR=~/bioinf_hw5/results/multiqc_before
mkdir -p "$OUT_DIR"

multiqc "$INPUT_DIR" -o "$OUT_DIR"

echo "MultiQC завершён"
