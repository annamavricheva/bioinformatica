#!/bin/bash
#SBATCH --partition=E5-2630-TITAN_X
#SBATCH -J fastqc_anna
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G

export PATH=/usr/bin:$PATH

source /home/STUDY/FBMF/studfbmf02_07/bioinf_hw5/slurm/env.sh
mkdir -p "$OUT_FQC_RAW"

for F in "$FQ1" "$FQ2" "$FQ3" "$FQ4"; do
    fastqc_one "$OUT_FQC_RAW" "$F"
done
