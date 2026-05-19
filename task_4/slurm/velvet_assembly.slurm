#!/bin/bash
#SBATCH --job-name=velvet_assembly
#SBATCH --output=velvet_%j.out
#SBATCH --error=velvet_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --partition=short
#SBATCH --constraint=compute

set -euo pipefail

VELVET_HOME=/home/STUDY/FBMF/bioinformatics/soft/velvet
VELVETH="$VELVET_HOME/velveth"
VELVETG="$VELVET_HOME/velvetg"

DATA_DIR=/home/STUDY/FBMF/bioinformatics/genome_de_novo
R1="$DATA_DIR/7_S4_L001_R1_001.fastq"
R2="$DATA_DIR/7_S4_L001_R2_001.fastq"

OUT_BASE=/home/studfbmf02_07/bioinf_hw4/velvet_results
READ_INSERT=300

for K in 13 23 31; do
    OUT_DIR="${OUT_BASE}/k${K}"
    mkdir -p "$OUT_DIR"
    echo "=== Velvet k=${K} ==="
    $VELVETH "$OUT_DIR" "$K" -fastq -shortPaired "$R1" "$R2"
    $VELVETG "$OUT_DIR" -ins_length "$READ_INSERT"
done

echo "Готово. Каталоги:"
ls -la --time=ctime "${OUT_BASE}"
