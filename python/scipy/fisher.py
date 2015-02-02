from scipy import stats

oddsratio, pvalue = stats.fisher_exact([[167, 133], [185, 115]])
print(oddsratio, pvalue)
