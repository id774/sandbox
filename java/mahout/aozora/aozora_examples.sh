#!/bin/sh

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
