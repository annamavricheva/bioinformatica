#!/bin/bash
#SBATCH -J hw6_fqc_raw
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G

set -euo pipefail

export TASK6="/home/STUDY/FBMF/studfbmf02_07/task_6"
export SLURM_DIR="${TASK6}/slurm"

source "${SLURM_DIR}/env.sh"

mkdir -p "$OUT_FQC_RAW"

fastqc_one "$OUT_FQC_RAW" "$READS1"
fastqc_one "$OUT_FQC_RAW" "$READS2"

echo "FastQC finished. Results in $OUT_FQC_RAW"
