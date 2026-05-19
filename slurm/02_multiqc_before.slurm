#!/bin/bash
#SBATCH -J multiqc_anna
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G

set -euo pipefail
source /home/STUDY/FBMF/studfbmf02_07/bioinf_hw5/slurm/env.sh
mkdir -p "$OUT_MQC_BEFORE"

/home/STUDY/FBMF/bioinformatics/anaconda3/bin/python3 -m multiqc "$OUT_FQC_RAW" -o "$OUT_MQC_BEFORE"
