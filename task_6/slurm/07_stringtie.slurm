#!/bin/bash
#SBATCH -J hw6_stringtie
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=04:00:00

set -euo pipefail

HERE="/home/STUDY/FBMF/studfbmf02_07/task_6/slurm"
source "${HERE}/env.sh"

BAM="${STAR_OUT}/RNA_Aligned.sortedByCoord.out.bam"
mkdir -p "$STRINGTIE_OUT"

stringtie "$BAM" -o "${STRINGTIE_OUT}/transcripts.gtf" -p "${SLURM_CPUS_PER_TASK}"

echo "StringTie done"
