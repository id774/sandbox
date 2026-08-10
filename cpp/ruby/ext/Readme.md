## この拡張ライブラリの使用手順
* このサンプルをダウンロードして解凍したディレクトリで以下を実行

```shell
 $ ruby extconf.rb
 $ make
 $ ruby test.rb
```

## ファイルについて
 * extconf.rb
  * 拡張ライブラリのMakefile作成用
 * hello.cpp
  * Helloクラスのコード
 * hello.h
  * Helloクラスのヘッダ
 * hello_wrp.cpp
  * HelloクラスをRubyで利用するためのラッパ
 * test.rb
  * 拡張ライブラリを使用するサンプルスクリプト

## 試してみた環境
* OSX 10.7.5
* ruby 1.9.3p0 (2011-10-30 revision 33570) [x86_64-darwin11.2.0]
* その他Centos6でも動作を確認

## 参照サイト
* [castoro/castoro-gateway/ext/cache/cache.hxx at master · ToshiyukiTerashita/castoro](https://github.com/ToshiyukiTerashita/castoro/blob/master/castoro-gateway/ext/cache/cache.hxx)
* [C++ で Ruby 拡張ライブラリ ( Data_Wrap_Struct とか ) - 飽きっぽいITエンジニアのブログ](http://d.hatena.ne.jp/hamajyotan/20111206/1323170266)
* [（Cではなく）C++でRubyの拡張ライブラリを作るには - tuedaの日記](http://d.hatena.ne.jp/tueda_wolf/20091205/p1)