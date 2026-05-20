#!/bin/bash
#SBATCH -J hw6_htseq
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=08:00:00

set -euo pipefail

HERE="/home/STUDY/FBMF/studfbmf02_07/task_6/slurm"
source "${HERE}/env.sh"

BAM="${STAR_OUT}/RNA_Aligned.sortedByCoord.out.bam"
GTF="${TASK6}/results/ref/Homo_sapiens.GRCh38.110.gtf"

if [[ ! -s "$GTF" ]]; then
  echo "ERROR: нет GTF: $GTF" >&2
  exit 1
fi

htseq-count --format bam \
  --order pos \
  --stranded no \
  --type exon \
  --idattr gene_id \
  "$BAM" "$GTF" > "$HTSEQ_OUT"

echo "HTSeq done -> $HTSEQ_OUT"
