#!/bin/bash
#SBATCH -J hw6_fqc_trim
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G

set -euo pipefail

HERE="/home/STUDY/FBMF/studfbmf02_07/task_6/slurm"
source "${HERE}/env.sh"

mkdir -p "$OUT_FQC_TRIM"

R1T="${OUT_TRIM}/Eg_Treg_S71_R1_trimmed.fastq.gz"
R2T="${OUT_TRIM}/Eg_Treg_S71_R2_trimmed.fastq.gz"

fastqc_one "$OUT_FQC_TRIM" "$R1T"
fastqc_one "$OUT_FQC_TRIM" "$R2T"

echo "FastQC on trimmed reads finished. Results in $OUT_FQC_TRIM"
