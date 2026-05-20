#!/bin/bash
#SBATCH -J hw6_mqc_after
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G

set -euo pipefail

HERE="/home/STUDY/FBMF/studfbmf02_07/task_6/slurm"
source "${HERE}/env.sh"

mkdir -p "$OUT_MQC_AFTER"
mkdir -p "$OUT_MQC_BOTH"

# MultiQC только после тримминга
/home/STUDY/FBMF/studfbmf02_07/.local/bin/multiqc "$OUT_FQC_TRIM" -o "$OUT_MQC_AFTER" -f -n multiqc_report.html

# MultiQC сравнение до и после
/home/STUDY/FBMF/studfbmf02_07/.local/bin/multiqc "$OUT_FQC_RAW" "$OUT_FQC_TRIM" -o "$OUT_MQC_BOTH" -f -n multiqc_report.html

echo "MultiQC finished. Reports in $OUT_MQC_AFTER and $OUT_MQC_BOTH"
