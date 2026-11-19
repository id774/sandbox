#!/bin/sh
# aozora_examples.sh: Cluster Aozora texts with Mahout canopy and k-means
#
# Description:
# Upload aozora_examples to HDFS, convert it to sequence files and TF-IDF
# vectors, list the most frequent words, run canopy and k-means clustering,
# and dump the clusters to dump. The script first removes its HDFS output
# directories.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh aozora_examples.sh
#
# Requirements:
# - A POSIX shell
# - Hadoop with the hadoop command and Mahout with the mahout command
# - The aozora_examples directory of segmented texts in the current
#   directory
#

hadoop fs -rmr aozora_examples
hadoop fs -rmr aozora_seq
hadoop fs -rmr aozora_sparse
hadoop fs -rmr aozora_canopy
hadoop fs -rmr aozora_kmeans

hadoop fs -put aozora_examples aozora_examples
hadoop fs -lsr aozora_examples
mahout seqdirectory -i aozora_examples -o aozora_seq
hadoop fs -lsr aozora_seq
mahout seq2sparse -i aozora_seq -o aozora_sparse -a org.apache.lucene.analysis.WhitespaceAnalyzer
hadoop fs -lsr aozora_sparse
mahout seqdumper -s aozora_sparse/wordcount/part-r-00000 -o wordcount
sort -nrk4 -t: wordcount | head
mahout canopy -i aozora_sparse/tfidf-vectors -o aozora_canopy -t1 0.4 -t2 0.6 -dm org.apache.mahout.common.distance.CosineDistanceMeasure -ow
hadoop fs -lsr aozora_canopy
mahout kmeans -i aozora_sparse/tfidf-vectors -c aozora_canopy/clusters-0/part-r-00000 -o aozora_kmeans --maxIter 10 -cl -ow
hadoop fs -lsr aozora_kmeans
mahout clusterdump -d aozora_sparse/dictionary.file-0 -dt sequencefile -s aozora_kmeans/clusters-1 -p aozora_kmeans/clusterdPoints -o dump
