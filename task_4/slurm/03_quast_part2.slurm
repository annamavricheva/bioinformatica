#!/bin/bash
#SBATCH -J hw4_quast2
#SBATCH -o quast2_%j.out
#SBATCH -e quast2_%j.err
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G

set -euo pipefail

OUTDIR=/home/studfbmf02_07/bioinf_hw4

VCONT13="${OUTDIR}/velvet/k13/contigs.fa"
VCONT23="${OUTDIR}/velvet/k23/contigs.fa"
VCONT31="${OUTDIR}/velvet/k31/contigs.fa"
SCONT="${OUTDIR}/spades_default/contigs.fasta"
QOUT="${OUTDIR}/quast_part2"

mkdir -p "$QOUT"

quast.py -t 8 -m 200 -o "$QOUT" \
  -l "Velvet_k13,Velvet_k23,Velvet_k31,SPAdes_default" \
  "$VCONT13" "$VCONT23" "$VCONT31" "$SCONT"

echo "Результаты: ${QOUT}/report.html"
