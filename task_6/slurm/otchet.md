
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

Зачем нужен transcripts.gtf: это собственная модель транскриптов из данных (isoformы, novel splice forms). Полез[A[A[B[A[200~cd /home/STUDY/FBMF/studfbmf02_07/task_6

cat >> otchet.md << 'EOF'

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

