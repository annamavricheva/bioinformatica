#!/bin/bash
#SBATCH -J hw6_star_map
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --cpus-per-task=32
#SBATCH --mem=128G
#SBATCH --time=06:00:00

set -euo pipefail

HERE="/home/STUDY/FBMF/studfbmf02_07/task_6/slurm"
source "${HERE}/env.sh"

mkdir -p "$STAR_OUT"

R1T="${OUT_TRIM}/Eg_Treg_S71_R1_trimmed.fastq.gz"
R2T="${OUT_TRIM}/Eg_Treg_S71_R2_trimmed.fastq.gz"

# Очищаем старые файлы
rm -rf "${STAR_OUT}/RNA__STARtmp"
rm -f "${STAR_OUT}/RNA_Aligned.out.bam"

STAR \
  --runThreadN 32 \
  --runMode alignReads \
  --genomeDir "${STAR_GENOME_DIR}" \
  --readFilesIn "$R1T" "$R2T" \
  --readFilesCommand zcat \
  --outFileNamePrefix "${STAR_OUT}/RNA_" \
  --outSAMtype BAM Unsorted \
  --quantMode GeneCounts

echo "STAR alignment done"
