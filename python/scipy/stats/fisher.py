# Run Fisher's exact test on a two by two contingency table.

from scipy import stats

oddsratio, pvalue = stats.fisher_exact([[167, 133], [185, 115]])
print(oddsratio, pvalue)
