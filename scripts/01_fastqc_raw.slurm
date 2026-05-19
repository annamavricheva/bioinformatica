#!/bin/bash
#SBATCH --job-name=fastqc_anna
#SBATCH --output=fastqc_%j.out
#SBATCH --error=fastqc_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --partition=short

set -euo pipefail

DATA_DIR=~/bioinf_hw5/data
OUT_DIR=~/bioinf_hw5/results/fastqc_raw
mkdir -p "$OUT_DIR"

FASTQC=/opt/fastqc-0.12.1/fastqc
PERL=/usr/bin/perl

for file in "$DATA_DIR"/*.fastq.gz; do
    echo "Обработка: $file"
    $PERL $FASTQC -o "$OUT_DIR" -t 4 "$file"
done

echo "FastQC завершён"
