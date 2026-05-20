#!/bin/bash
#SBATCH -J hw6_mqc_before
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G

set -euo pipefail

export TASK6="/home/STUDY/FBMF/studfbmf02_07/task_6"
export SLURM_DIR="${TASK6}/slurm"

source "${SLURM_DIR}/env.sh"

mkdir -p "$OUT_MQC_BEFORE"

/home/STUDY/FBMF/studfbmf02_07/.local/bin/multiqc "$OUT_FQC_RAW" -o "$OUT_MQC_BEFORE" -f -n multiqc_report.html

echo "MultiQC finished. Report in $OUT_MQC_BEFORE/multiqc_report.html"
