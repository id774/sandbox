# regression.R: Linear regression of airquality Ozone
#
# Description:
# Write the airquality data set to airquality.csv and regress Ozone on the
# other measurement columns with and without an intercept.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript regression.R
#
# Requirements:
# - R
#

data(airquality)

write.csv(airquality, "airquality.csv",
          quote=TRUE, row.names=TRUE, sep=",")

airq<-airquality[,1:4]
airq.lm<-lm(Ozone~., airq)
summary(airq.lm)

airq.lm<-lm(Ozone~. - 1,airq)
summary(airq.lm)
