#!/bin/bash
#SBATCH -J hw6_star_index
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --partition=AMD9554
#SBATCH --cpus-per-task=16
#SBATCH --mem=120G
#SBATCH --time=06:00:00

set -euo pipefail

# Явные пути для вашего пользователя
export TASK6="/home/STUDY/FBMF/studfbmf02_07/task_6"
export REF_DIR="${TASK6}/results/ref"
export STAR_GENOME_DIR="${REF_DIR}/STAR_index_GRCh38"
export GTF_FOR_HTSEQ="${REF_DIR}/Homo_sapiens.GRCh38.110.gtf"
export REF_FA="${REF_DIR}/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
export REF_FA_GZ="${REF_DIR}/downloads/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"
export REF_GTF_GZ="${REF_DIR}/downloads/Homo_sapiens.GRCh38.110.gtf.gz"

mkdir -p "${REF_DIR}/downloads"
cd "${REF_DIR}/downloads"

FA_URL="https://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"
GTF_URL="https://ftp.ensembl.org/pub/release-110/gtf/homo_sapiens/Homo_sapiens.GRCh38.110.gtf.gz"

if [[ ! -s "${REF_FA_GZ}" ]]; then
  curl -fsSL --retry 5 -o "${REF_FA_GZ}" "${FA_URL}"
fi
if [[ ! -s "${REF_GTF_GZ}" ]]; then
  curl -fsSL --retry 5 -o "${REF_GTF_GZ}" "${GTF_URL}"
fi

# STAR genomeGenerate требует несжатый FASTA
if [[ ! -s "${REF_FA}" ]]; then
  echo "Unpacking FASTA (one-time, ~3 GB)..."
  gunzip -c "${REF_FA_GZ}" > "${REF_FA}.tmp"
  mv "${REF_FA}.tmp" "${REF_FA}"
fi

# HTSeq: распакованный GTF
if [[ ! -s "${GTF_FOR_HTSEQ}" ]]; then
  gunzip -c "${REF_GTF_GZ}" > "${GTF_FOR_HTSEQ}.tmp"
  mv "${GTF_FOR_HTSEQ}.tmp" "${GTF_FOR_HTSEQ}"
fi

# Сборка STAR индекса
if [[ ! -f "${STAR_GENOME_DIR}/genomeParameters.txt" ]]; then
  rm -rf "${STAR_GENOME_DIR}"
  mkdir -p "${STAR_GENOME_DIR}"
  
  # Путь к STAR (из вашего окружения)
  STAR_CMD="/home/STUDY/FBMF/studfbmf02_07/.conda_envs/rnaseq/bin/STAR"
  
  $STAR_CMD --runMode genomeGenerate \
    --runThreadN "${SLURM_CPUS_PER_TASK}" \
    --genomeDir "${STAR_GENOME_DIR}" \
    --genomeFastaFiles "${REF_FA}" \
    --sjdbGTFfile "${GTF_FOR_HTSEQ}" \
    --sjdbOverhang 75
fi

echo "REF + STAR index OK: ${STAR_GENOME_DIR}"
