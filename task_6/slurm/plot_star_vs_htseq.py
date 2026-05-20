#!/usr/bin/env python3
import argparse
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--star', required=True)
    parser.add_argument('--htseq', required=True)
    parser.add_argument('--out-png', required=True)
    parser.add_argument('--out-csv', required=True)
    args = parser.parse_args()
    
    # Читаем STAR counts (колонка 3 - counts для stranded reverse)
    star_df = pd.read_csv(args.star, sep='\t', header=None, skiprows=4)
    star_counts = star_df.set_index(0)[3]
    
    # Читаем HTSeq counts
    htseq_df = pd.read_csv(args.htseq, sep='\t', header=None)
    htseq_counts = htseq_df.set_index(0)[1]
    
    # Объединяем
    merged = pd.DataFrame({
        'STAR': star_counts,
        'HTSeq': htseq_counts
    }).dropna()
    
    # Убираем нули и логарифмируем
    merged = merged[(merged['STAR'] > 0) & (merged['HTSeq'] > 0)]
    merged['log2_STAR'] = np.log2(merged['STAR'])
    merged['log2_HTSeq'] = np.log2(merged['HTSeq'])
    
    # Сохраняем CSV
    merged.to_csv(args.out_csv, index_label='gene_id')
    
    # График
    plt.figure(figsize=(8, 8))
    plt.scatter(merged['log2_STAR'], merged['log2_HTSeq'], alpha=0.3, s=5)
    max_val = max(merged['log2_STAR'].max(), merged['log2_HTSeq'].max())
    plt.plot([0, max_val], [0, max_val], 'r--', label='y=x')
    plt.xlabel('STAR counts (log2)')
    plt.ylabel('HTSeq counts (log2)')
    plt.title('Comparison of gene counts: STAR vs HTSeq')
    plt.savefig(args.out_png, dpi=150, bbox_inches='tight')
    print(f"Plot saved to {args.out_png}")

if __name__ == '__main__':
    main()
