#!/bin/bash
#SBATCH -p AMD9554-common
#SBATCH -J hw5_fastp
#SBATCH -o ../logs/fastp_%j.out
#SBATCH -e ../logs/fastp_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G

set -euo pipefail

# Прямые пути (без env.sh)
export PROJECT_DIR="/home/STUDY/FBMF/studfbmf02_07/bioinf_hw5"
export DATA_DIR="$PROJECT_DIR/data"
export RESULTS_DIR="$PROJECT_DIR/results"

mkdir -p "$RESULTS_DIR/trimmed"

FASTP="/home/STUDY/FBMF/bioinformatics/anaconda3/bin/fastp"

# Обрабатываем ТОЛЬКО хорошие файлы (исключаем маленький повреждённый)
for FILE in "$DATA_DIR"/ERR14230537.fastq.gz "$DATA_DIR"/ERR14230552.fastq.gz "$DATA_DIR"/ERR14230595.fastq.gz; do
  if [ -f "$FILE" ]; then
    B=$(basename "$FILE" .fastq.gz)
    OUT="$RESULTS_DIR/trimmed/${B}_trimmed.fastq.gz"
    JSON="$RESULTS_DIR/trimmed/${B}.fastp.json"
    HTML="$RESULTS_DIR/trimmed/${B}.fastp.html"
    
    $FASTP -i "$FILE" -o "$OUT" \
      -w 4 -z 6 \
      --cut_right_window_size 5 --cut_right_mean_quality 20 \
      -l 36 \
      -j "$JSON" -h "$HTML"
  fi
done

ls -la "$RESULTS_DIR/trimmed"
