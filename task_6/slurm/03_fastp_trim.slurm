#!/bin/bash
#SBATCH -J hw6_fastp
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G

set -euo pipefail

HERE="/home/STUDY/FBMF/studfbmf02_07/task_6/slurm"
source "${HERE}/env.sh"

mkdir -p "$OUT_TRIM"

B="Eg_Treg_S71"
OUT1="${OUT_TRIM}/${B}_R1_trimmed.fastq.gz"
OUT2="${OUT_TRIM}/${B}_R2_trimmed.fastq.gz"
J="${OUT_TRIM}/${B}.fastp.json"
H="${OUT_TRIM}/${B}.fastp.html"

"$FASTP" \
  -i "$READS1" -I "$READS2" -o "$OUT1" -O "$OUT2" \
  -w "$THREADS" -z 6 \
  --detect_adapter_for_pe \
  -r --cut_right_window_size 5 --cut_right_mean_quality 20 \
  -l 36 -j "$J" -h "$H"

echo "fastp finished. Trimmed reads in $OUT_TRIM"
ls -la "$OUT_TRIM"
