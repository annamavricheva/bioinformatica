Отчёт по заданию 6 — RNA-seq пайплайн (Часть 1 и 2)

Студент: studfbmf02_07
Дата: 2026-05-19
Риды: Eg_Treg_S71_R1_001.fastq.gz и Eg_Treg_S71_R2_001.fastq.gz
Путь к данным: /home/STUDY/FBMF/bioinformatics/rnaseq_map_star/raw_data/


Часть 1 — FastQC + MultiQC (сырые данные)


Результаты FastQC (по данным MultiQC)

Модуль                          R1 (сырой)    R2 (сырой)    Комментарий
Per base sequence quality       PASS          PASS          Качество по позициям хорошее
Per tile sequence quality       PASS          WARN          R2 — предупреждение по плитке
Per base sequence content       FAIL          FAIL          Типично для RNA-seq
Per sequence GC content         FAIL          WARN          Нетипичное распределение
Sequence Duplication Levels     PASS          PASS          В MultiQC высокий % дубликатов
Overrepresented sequences       FAIL          FAIL          Типично для RNA-seq
Adapter Content                 PASS          PASS          Адаптеры не доминируют

Числа ридов (MultiQC)

R1: ~19.78 M ридов
R2: ~19.78 M ридов
Всего парных ридов: 39,558,686


Часть 2 — fastp (тримминг) + FastQC + MultiQC после

1. Есть ли адаптеры?

Да, на уровне последовательностей они проявляются сильнее, чем показывает модуль Adapter Content в FastQC.

fastp с параметром --detect_adapter_for_pe нашёл типичные хвосты Illumina адаптеров.
Согласно отчёту fastp (Eg_Treg_S71.fastp.json), было обрезано ~2.1 M ридов по адаптеру, ~39 Mb оснований (adapter_trimmed_reads / adapter_trimmed_bases).

2. Есть ли участки с Q < 20 в конце ридов?

Да. В сырых данных профиль качества по циклам показывает снижение к 3'-концу (особенно R2).
После тримминга качество улучшилось:
- Q20 rate вырос с 95.6% до 98.5%
- Q30 rate вырос с 90.2% до 95.1%

3. Что сделал fastp и что изменилось?

Параметры fastp:
- Скользящее окно 5:20 на 3'-конце (--cut_right_window_size 5 --cut_right_mean_quality 20)
- Минимальная длина рида 36 (-l 36)
- Автоматическое детектирование адаптеров для парных ридов (--detect_adapter_for_pe)

Итоги по trimmed/Eg_Treg_S71.fastp.json:

Метрика                      До             После
Всего reads (сумма пар)     39,558,686     33,920,724
Q20 rate                    0.956          0.985
Q30 rate                    0.902          0.951
Mean length R1 / R2         76 / 76        74 / 73

Отфильтровано:
- too short: ~5.35 M ридов
- low quality: ~272k ридов
- адаптеры и димеры

FastQC после тримминга:
- Per tile sequence quality: остаётся WARN (не критично)
- Sequence Length Distribution: появляется WARN (ожидаемо, длины стали вариабельнее)
- Per base sequence content / GC content: остаются FAIL — для RNA-seq это нормально (биология библиотеки, не дефект)

4. Выбор данных для STAR (выравнивание)

Для выравнивания выбраны триммированные риды.

Причины:
- Убраны адаптеры, которые могли бы привести к ложным выравниваниям
- Удалены слабые 3'-хвосты с низким качеством (Q<20)
- Выросли показатели Q20/Q30 (95.1% после против 90.2% до)
- Меньше шума для детекции инделов и сплайсов

Сырые риды при том же индексе STAR дали бы больше "мусорных" несовпадений на концах, что ухудшило бы точность выравнивания и подсчёта генов.


Файлы, созданные в ходе выполнения частей 1 и 2

task_6/
├── results/
│   ├── fastqc_raw/                      (4 файла: R1 и R2 до тримминга)
│   ├── multiqc_before/                  (отчёт до тримминга)
│   ├── trimmed/                         (триммированные риды + fastp отчёты)
│   ├── fastqc_trim/                     (4 файла: R1 и R2 после тримминга)
│   ├── multiqc_after/                   (отчёт после тримминга)
│   └── multiqc_both/                    (сравнение до и после)
└── slurm/
    ├── 01_fastqc_raw.slurm
    ├── 02_multiqc_before.slurm
    ├── 03_fastp_trim.slurm
    ├── 04_fastqc_trim.slurm
    ├── 05_multiqc_after.slurm
    └── env.sh


Вывод

Части 1 и 2 выполнены полностью. FastQC и MultiQC показали типичные для RNA-seq предупреждения. fastp успешно удалил адаптеры и обрезал низкокачественные хвосты, улучшив общее качество ридов. Триммированные данные выбраны для дальнейшего выравнивания STAR.


Часть 3 — STAR + StringTie

STAR

Индекс: task_6/results/ref/STAR_index_GRCh38/
Риды: триммированные Eg_Treg_S71_R{1,2}_trimmed.fastq.gz

Итог (RNA_Log.final.out): 16,972,983 парных чтений, 85.40% uniquely mapped; 6.08% multi-mapping; 7.86% unmapped too short.

StringTie (de novo)

Файл: results/stringtie_out/transcripts.gtf.

Первые 10 строк файла (включая 2 строки-комментария StringTie — это тоже часть выхода):

# stringtie /home/STUDY/FBMF/studfbmf02_07/task_6/results/star_alignment/RNA_Aligned.sortedByCoord.out.bam -o /home/STUDY/FBMF/studfbmf02_07/task_6/results/stringtie_out/transcripts.gtf -p 8
# StringTie version 2.2.3
1	StringTie	transcript	75900	77171	1000	.	.	gene_id "STRG.1"; transcript_id "STRG.1.1"; cov "4.996384"; FPKM "2.201654"; TPM "5.034880";
1	StringTie	exon	75900	77171	1000	.	.	gene_id "STRG.1"; transcript_id "STRG.1.1"; exon_number "1"; cov "4.996384";
1	StringTie	transcript	91658	92659	1000	.	.	gene_id "STRG.2"; transcript_id "STRG.2.1"; cov "7.886688"; FPKM "3.475265"; TPM "7.947453";
1	StringTie	exon	91658	92659	1000	.	.	gene_id "STRG.2"; transcript_id "STRG.2.1"; exon_number "1"; cov "7.886688";
1	StringTie	transcript	99122	101672	1000	.	.	gene_id "STRG.3"; transcript_id "STRG.3.1"; cov "4.973078"; FPKM "2.191384"; TPM "5.011394";

Поля GTF (9 колонок): seqname, source, feature, start, end, score, strand, frame, attributes. Для транскриптов в attributes у StringTie: gene_id, transcript_id, оценки cov / FPKM / TPM; у exon — ещё exon_number.

Число строк с feature = transcript: 77,202 (команда: grep -c $'\ttranscript\t' transcripts.gtf).

Зачем нужен transcripts.gtf: это собственная модель транскриптов из данных (isoformы, novel splice forms). Полезен для аннотации новых RNAs, проверки аннотации Ensembl, визуализации в IGV, при необходимости как основа для quantification с -G в других пайплайнах.


Часть 4 — HTSeq (подсчёт генов)

Референсный геном: /home/STUDY/FBMF/bioinformatics/GRCh38/
GTF аннотация: task_6/results/ref/Homo_sapiens.GRCh38.110.gtf
BAM файл: results/star_alignment/RNA_Aligned.sortedByCoord.out.bam

Команда htseq-count:
- stranded = no (RNA-seq библиотека не strand-specific)
- type = exon (используем exon как feature)
- idattr = gene_id (группировка по gene_id)

Результаты:

Всего генов в аннотации: 62,754
Генов с ненулевым счётчиком: 38,938
Генов с нулевым счётчиком: 23,816

Статистика HTSeq:
- __no_feature: 11,106,930 ридов (не попали в аннотацию)
- __ambiguous: 561,235 ридов (попали в несколько генов)
- __alignment_not_unique: 1,032,315 ридов (multimapping)

