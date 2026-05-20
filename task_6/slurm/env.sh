export STUD_DIR="/home/STUDY/FBMF/studfbmf02_07"
export TASK6="${STUD_DIR}/task_6"

export READS1="/home/STUDY/FBMF/bioinformatics/rnaseq_map_star/raw_data/Eg_Treg_S71_R1_001.fastq.gz"
export READS2="/home/STUDY/FBMF/bioinformatics/rnaseq_map_star/raw_data/Eg_Treg_S71_R2_001.fastq.gz"

export OUT_FQC_RAW="${TASK6}/results/fastqc_raw"
export OUT_MQC_BEFORE="${TASK6}/results/multiqc_before"

export PERL_BIN="/home/STUDY/FBMF/bioinformatics/anaconda3/bin/perl"
export FASTQC_PL="/home/STUDY/FBMF/bioinformatics/anaconda3/opt/fastqc-0.12.1/fastqc"

export THREADS=4

fastqc_one() { "$PERL_BIN" "$FASTQC_PL" -o "$1" -t "$THREADS" "$2"; }

# Пути для тримминга
export OUT_TRIM="${TASK6}/results/trimmed"
export OUT_FQC_TRIM="${TASK6}/results/fastqc_trim"
export OUT_MQC_AFTER="${TASK6}/results/multiqc_after"
export OUT_MQC_BOTH="${TASK6}/results/multiqc_both"

# fastp (из ДЗ 5)
export FASTP="/home/STUDY/FBMF/studfbmf02_07/.conda_envs/bio_hw5/bin/fastp"

# Пути к программам для части 3
export CONDA_BASE="/home/STUDY/FBMF/bioinformatics/anaconda3"
export CONDA_ENV_RNA="/home/STUDY/FBMF/studfbmf02_07/.conda_envs/rnaseq"
export PATH="${CONDA_ENV_RNA}/bin:$PATH"

# STAR индекс (используем индекс Вадима, если есть доступ)
export STAR_GENOME_DIR="/home/STUDY/FBMF/studfbmf02_07/task_6/results/ref/STAR_index_GRCh38"

# GTF для HTSeq (используем GTF Вадима)
export GTF_FOR_HTSEQ="/home/STUDY/FBMF/studfbmf02_03/task_6/results/ref/Homo_sapiens.GRCh38.110.gtf"

# Выходные папки
export STAR_OUT="${TASK6}/results/star_alignment"
export STRINGTIE_OUT="${TASK6}/results/stringtie_out"
export HTSEQ_OUT="${TASK6}/results/htseq_counts.txt"
export PLOT_DIR="${TASK6}/results/plots"

# Пути для референса и STAR индекса
export REF_DIR="${TASK6}/results/ref"
export STAR_GENOME_DIR="${REF_DIR}/STAR_index_GRCh38"
export GTF_FOR_HTSEQ="${REF_DIR}/Homo_sapiens.GRCh38.110.gtf"
export REF_FA="${REF_DIR}/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
