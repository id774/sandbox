# glm.R: Logistic regression with glm
#
# Description:
# Fit a logistic regression of con on group, sat, talk, and per from
# sample_data2.csv and print the odds ratios.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript glm.R
#
# Requirements:
# - R
# - sample_data2.csv in the current directory
#

data <- read.csv("sample_data2.csv", header=TRUE)
result = glm(con ~ group + sat + talk + per, data=data, family=binomial(link="logit"))
summary(result)
names(result)
exp(result[[1]])
