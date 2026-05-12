# Домашнее задание 4: de novo сборка генома

**Студент:** Анна Мавричева  
**Дата выполнения:** 12 мая 2026

---

## Часть 1 — Сборка с Velvet

### Выбор k-mer

На сервере Velvet собран с максимальным k = 31. Использованы три значения k-mer с шагом ~10:

| k-mer | Обоснование |
|-------|-------------|
| 13 | Минимальное значение |
| 23 | Промежуточное |
| 31 | Максимально доступное |

### SLURM-скрипт

Скрипт запуска: `slurm/velvet_assembly.slurm`

```bash
#!/bin/bash
#SBATCH --job-name=velvet_assembly
#SBATCH --output=velvet_%j.out
#SBATCH --error=velvet_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --partition=short
#SBATCH --constraint=compute

set -euo pipefail

VELVET_HOME=/home/STUDY/FBMF/bioinformatics/soft/velvet
VELVETH="$VELVET_HOME/velveth"
VELVETG="$VELVET_HOME/velvetg"

DATA_DIR=/home/STUDY/FBMF/bioinformatics/genome_de_novo
R1="$DATA_DIR/7_S4_L001_R1_001.fastq"
R2="$DATA_DIR/7_S4_L001_R2_001.fastq"

OUT_BASE=/home/studfbmf02_07/bioinf_hw4/velvet_results
READ_INSERT=300

for K in 13 23 31; do
    OUT_DIR="${OUT_BASE}/k${K}"
    mkdir -p "$OUT_DIR"
    echo "=== Velvet k=${K} ==="
    $VELVETH "$OUT_DIR" "$K" -fastq -shortPaired "$R1" "$R2"
    $VELVETG "$OUT_DIR" -ins_length "$READ_INSERT"
done

echo "Готово. Каталоги:"
ls -la --time=ctime "${OUT_BASE}"

## Часть 2 — Сравнение сборок Velvet и SPAdes (QUAST)

### Запуск QUAST

Для сравнения использованы сборки Velvet (k=13, 23, 31) и SPAdes (сборка по умолчанию).

**Параметр QUAST -m 200:** при стандартном пороге 500 bp контиги Velvet почти целиком отфильтровываются, поэтому использован порог 200 bp.

**SLURM-скрипт:** `slurm/03_quast_part2.slurm`

### Результаты QUAST (контиги ≥ 200 bp)

| Метрика | Velvet k=13 | Velvet k=23 | Velvet k=31 | SPAdes_default |
|---------|-------------|-------------|-------------|----------------|
| # contigs | 26430 | 7816 | 2746 | 27 |
| Total length | 169904 | 116840 | 52494 | 12128 |
| N50 | 17 | 37 | 61 | 517 |
| Largest contig | 212 | 231 | 384 | 1069 |

![Скриншот таблицы QUAST](images/quast_part2_table.png)
### Выводы

**Сравнение сборок Velvet между собой:**
- С ростом k-mer (13 → 23 → 31) количество контигов резко сокращается
- N50 растёт, но общая длина сборки падает

**Сравнение Velvet и SPAdes:**
- SPAdes даёт **более длинные контиги** (N50 = 517 против 61 у Velvet)
- **Количество контигов** у SPAdes (27) на порядок меньше, чем у Velvet (2746)
- **Суммарная длина** SPAdes (12128 bp) меньше, но это связано с тем, что Velvet генерирует множество коротких ошибочных фрагментов

**Почему SPAdes лучше?**
1. **Мульти-k-mer подход** - SPAdes строит графы с несколькими значениями k и объединяет их
2. **Коррекция ридов** - уменьшает количество ошибок в чтениях
3. **Автоматическая оценка длины инсерта** — Velvet использует жёстко заданное значение `-ins_length 300`


## Часть 3 — Улучшение сборки

### Как можно улучшить сборку?

**Для Velvet:**
- Уточнить длину инсерта (`-ins_length`) на основе оценки из логов SPAdes
- Использовать `-exp_cov auto` для автоматической оценки покрытия
- Использовать `-cov_cutoff auto` для отсечения контигов с аномальным покрытием
- Добавить `-scaffolding yes` для построения скаффолдов

**Для SPAdes:**
- Добавить флаг `--careful` для постобработки и уменьшения ошибок
- Расширить диапазон k-mer

### SLURM-скрипт для улучшенной сборки Velvet

Скрипт: `slurm/05_velvet_improved.slurm`

```bash
#!/bin/bash
#SBATCH -J hw4_velvet_tuned
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/env.sh"
cd "${HERE}"

K="${IMPROVE_K:-31}"
READ_INSERT="${IMPROVE_INSERT:-110}"
EXP_COV="${EXP_COV:-90}"
COV_CUTOFF="${COV_CUTOFF:-5}"

OUT="${OUTDIR}/velvet/k${K}_tuned"
mkdir -p "$OUT"
rm -rf "${OUT}"/*

"$VELVETH" "$OUT" "$K" -fastq -shortPaired "$R1" "$R2"
"$VELVETG" "$OUT" \
  -ins_length "$READ_INSERT" \
  -exp_cov "$EXP_COV" \
  -cov_cutoff "$COV_CUTOFF" \
  -scaffolding yes

echo "Готово: ${OUT}/contigs.fa"

### Результаты QUAST (сравнение 4 сборок)

| Сборка | # contigs | Total length (bp) | N50 (bp) |
|--------|-----------|-------------------|----------|
| Velvet k=31 (базовая) | 2746 | 52494 | 61 |
| Velvet k=31_tuned | 13 | 4183 | 332 |
| SPAdes_default | 27 | 12128 | 517 |
| SPAdes_careful | 27 | 12128 | 517 |

### Выводы по части 3

**Velvet улучшенный (tuned):**
- N50 вырос с 61 до 332 (почти в 5 раз)
- Количество контигов сократилось с 2746 до 13
- Настройка параметров значительно улучшила качество сборки

**SPAdes careful:**
- На этом наборе данных флаг `--careful` не дал заметных улучшений
- Метрики совпали с базовой сборкой

**Общий вывод:** настройка Velvet имеет смысл. Однако по основным метрикам лучшей остаётся SPAdes.
