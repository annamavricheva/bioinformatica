#!/bin/bash
#SBATCH -J hw6_sort_bam
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=00:30:00

set -euo pipefail

HERE="/home/STUDY/FBMF/studfbmf02_07/task_6/slurm"
source "${HERE}/env.sh"

BAM_IN="${STAR_OUT}/RNA_Aligned.out.bam"
BAM_SORTED="${STAR_OUT}/RNA_Aligned.sortedByCoord.out.bam"

# Сортировка BAM
samtools sort -@ 8 -o "$BAM_SORTED" "$BAM_IN"
samtools index "$BAM_SORTED"

echo "BAM sorted and indexed"
