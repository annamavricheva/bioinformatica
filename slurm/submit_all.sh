#!/bin/bash
set -euo pipefail
D="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$D"
source "${D}/env.sh"

J1=$(sbatch --parsable 01_fastqc_raw.slurm)
J2=$(sbatch --parsable --dependency=afterok:"$J1" 02_multiqc_before.slurm)

echo "Jobs: 01=$J1 02=$J2"
echo "MultiQC отчёт: ${OUT_MQC_BEFORE}/multiqc_report.html"
