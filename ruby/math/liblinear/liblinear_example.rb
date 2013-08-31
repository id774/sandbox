# -*- coding: utf-8 -*-
require "linear"

# types = [ 'L2R_LR', 'L2R_L2LOSS_SVC_DUAL', 'L2R_L2LOSS_SVC', 'L2R_L1LOSS_SVC_DUAL', 'MCSVM_CS', 'L1R_L2LOSS_SVC', 'L1R_LR' ] SVMの種類
# 0:L2_LR , 1:L2LOSS_SVM_DUAL , 2:L2LOSS_SVM , 3: L1L1LOSS_SVM_DUAL, 4: MCSVM_CS, ... 定義されている変数名

pa = LParameter.new
pa.solver_type = MCSVM_CS
pa.eps = 0.1
bias = 1
labels, samples = read_file("training_file")
sp = LProblem.new(labels,samples,bias)
model = LModel.new(sp,pa)

x = {1=>1,2=>0.1,3=>0.2,4=>0,5=>0} # テストしてみるデータ
model.predict(x)
puts x # どのラベルに分類されているかが出力される

model.save("sample01.model") # Modelファイルの保存

