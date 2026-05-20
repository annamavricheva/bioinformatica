#!/bin/bash
#SBATCH -J hw6_plot_counts
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=00:20:00

set -euo pipefail

HERE="/home/STUDY/FBMF/studfbmf02_07/task_6/slurm"
source "${HERE}/env.sh"

mkdir -p "$PLOT_DIR"

python3 "${HERE}/plot_star_vs_htseq.py" \
  --star "${STAR_OUT}/RNA_ReadsPerGene.out.tab" \
  --htseq "$HTSEQ_OUT" \
  --out-png "${PLOT_DIR}/star_vs_htseq_col3.png" \
  --out-csv "${PLOT_DIR}/star_vs_htseq_merged.csv"

echo "Plot done"
