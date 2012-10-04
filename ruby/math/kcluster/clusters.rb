#!/usr/bin/ruby
# -*- coding: utf-8 -*-
$:.unshift File.join(File.dirname(__FILE__))

require 'bicluster.rb'
require 'rubygems'
require 'pp'
require 'RMagick'
include Magick

class Clusters
  def kcluster(rows, distance=:pearson, k=4)
    # それぞれのポイントの最小値と最大値を決める
    ranges = Array.new
    for i in 0...rows[0].length
      cols = Array.new
      for row in rows
        cols.push(row[i])
      end
      ranges.push([cols.min, cols.max])
    end

    # 重心をランダムにk個配置する
    clusters = Array.new
    k.times do
      tmp = Array.new
      for i in 0...rows[0].length
        tmp.push( rand()*(ranges[i].max-ranges[i].min)+ranges[i].min )
      end
      clusters.push(tmp)
    end

    # 重心を再計算しながら100回、もしくは変化が無くなるまで移動させる
    lastmatches = nil
    for t in 0...100
      puts 'Iteration ' + t.to_s
      bestmatches = Array.new # 空の配列作成
      k.times do bestmatches.push(Array.new) end

      # それぞれの行に対して、もっとも近い重心を探し出す
      for j in 0...rows.length
        row = rows[j]
        bestmatch = 0
        for i in 0...k
          d = self.method(distance).call(clusters[i],row) # 距離計算
          bestmatch = i if d < self.method(distance).call(clusters[bestmatch],row)
        end
        bestmatches[bestmatch].push(j)
      end

      # 結果が前回と同じであれば完了
      return bestmatches if bestmatches == lastmatches
      lastmatches = bestmatches

      # 重心をそのメンバーの平均に移動する
      for i in 0...k
        avgs = Array.new(rows[0].length, 0.0) # 初期値0.0の配列をいくつか作る
        if bestmatches[i].length > 0
          for rowid in bestmatches[i]
            for m in 0...rows[rowid].length
              avgs[m] += rows[rowid][m]
            end
          end
          for j in 0...avgs.length
            avgs[j] /= bestmatches[j].length if bestmatches[j] != nil
          end
          clusters[i] = avgs
        end
        #return bestmatches
      end
    end
  end

  # 行列の入れ替え
  def rotatematrix(data)
    newdata = Array.new
    # 単語数が多すぎるので100個に制限する
    for i in 0...[100, data[0].length].min
      newrow = Array.new
      for j in 0...data.length
        newrow.push(data[j][i])
      end
      newdata.push(newrow)
    end
    return newdata
  end

  # グラフを描く
  def drawdendrogram(clust, labels, imgfile='clusters.png')
    # 高さと幅
    h = getheight(clust) * 20
    w = 1200
    depth = getdepth(clust)

    # 幅は固定されているため、適宜縮尺する
    scaling = Float(w-150)/depth

    # 白を背景とする新しい画像を作る
    img = Image.new(w,h)
    draw = Draw.new
    draw.stroke('red')
    draw.stroke_width(1)
    draw.line(0, h/2, 10, h/2)

    # 最初のノードを描く
    drawnode(draw, clust, 10, (h/2), scaling, labels)

    # 描画、保存
    draw.draw(img)
    img.write(imgfile)
  end

  def drawnode(draw, clust, x, y, scaling, labels)
    if clust.id < 0
      h1 = getheight(clust.left) * 20
      h2 = getheight(clust.right) * 20
      top = y-(h1+h2)/2
      bottom = y+(h1+h2)/2
      # 直線の長さ
      ll = clust.distance*scaling
      # クラスタから子への垂直な直線
      draw.stroke('red')
      draw.line(x, top+h1/2, x, bottom-h2/2)

      # 左側のアイテムへの水平な直線
      draw.line(x, top+h1/2, x+ll, top+h1/2)

      # 右側のアイテムへの水平な直線
      draw.line(x, bottom-h2/2, x+ll, bottom-h2/2)

      # 左右のノードたちを描く関数を呼び出す
      drawnode(draw, clust.left, x+ll, top+h1/2, scaling, labels)
      drawnode(draw, clust.right, x+ll, bottom-h2/2, scaling, labels)
    else
      # 終点であればアイテムのラベルを描く
      #draw.font = '/Library/Fonts/Arial.ttf'
      #draw.font = '/Library/Fonts/ヒラギノ角ゴ Pro W3.otf'
      draw.font = '/usr/share/fonts/truetype/vlgothic/VL-Gothic-Regular.ttf'
      draw.stroke('transparent')
      draw.fill('black')
      draw.pointsize = 10 # 文字サイズ
      label = labels[clust.id]
      draw.text(x+3, y+4, label) if label != nil
    end
  end

  def getdepth(clust)
    # 終端への距離は0.0
    return 0 if clust.left == nil && clust.right == nil

    # 枝の距離は二つの方向の大きい方にそれ自身の距離を足したもの
    return [getdepth(clust.left),getdepth(clust.right)].max + clust.distance
  end

  def getheight(clust)
    # 終端であれば高さは1にする
    return 1 if clust.left == nil && clust.right == nil

    #そうでなければ高さはそれぞれの枝の高さの合計
    return getheight(clust.left) + getheight(clust.right)
  end

  # 階層型クラスタを出力する
  def printclust(clust,labels=nil,n=0)
    # 階層型レイアウトにするためにインデントする
    n.times do
      print ' '
    end
    if clust.id < 0
      # 負のidはこれが枝である事を示している
      puts '-'
    else
      # 正のidはこれが終端だということを示している
      if labels == nil
        puts clust.id
      else
        puts labels[clust.id]
      end
    end

    # 右と左の枝を表示する
    printclust(clust.left, labels, n+1) if clust.left != nil
    printclust(clust.right, labels, n+1) if clust.right != nil
  end

  # 階層的クラスタを作る
  def hcluster(rows, distance=:pearson)
    distances = Hash.new
    currentclustid = -1

    # クラスタは最初は行たち
    clust = Array.new
    for i in 0...rows.length
      c = Bicluster.new(rows[i])
      c.id = i
      clust.push(c)
    end

    while clust.length > 1
      lowestpair = [0,1]
      closest = self.method(distance).call(clust[0].vec, clust[1].vec)
      # すべての組をループし、もっとも距離の近い組を探す
      for i in 0...clust.length
        for j in i+1...clust.length
          # 距離をキャッシュしてない時、新しく計算する
          if !distances.key?([clust[i].id, clust[j].id]) # hashのkeyとして配列を使う
            distances[[clust[i].id, clust[j].id]] = self.method(distance).call(clust[i].vec, clust[j].vec)
          end
          d = distances[[clust[i].id, clust[j].id]]
          if d < closest
            closest = d
            lowestpair = [i,j]
          end
        end
      end

      # 2つのクラスタの平均を計算する
      mergevec = Array.new
      for i in 0...clust[0].vec.length
        m = (clust[lowestpair[0]].vec[i] + clust[lowestpair[1]].vec[i])/2.0
        mergevec.push(m)
      end

      # 新たなクラスタを作る
      newcluster = Bicluster.new(mergevec, clust[lowestpair[0]], clust[lowestpair[1]], closest, currentclustid)

      # 元のセットではないクラスタのIDは負にする
      currentclustid -= 1
      clust.delete_at(lowestpair[1])
      clust.delete_at(lowestpair[0])
      clust.push(newcluster)
    end
    return clust[0]
  end

  # ピアソン相関距離を計算
  def pearson(v1,v2)
    v1 = [v1] if v1.class != Array
    v2 = [v2] if v2.class != Array
    # 単純な合計
    sum1 = 0
    v1.each{ |n|
      sum1 += n
    }
    sum2 = 0
    v2.each{ |n|
      sum2 += n
    }

    # 平方の合計
    sum1Sq = 0
    v1.each{ |n|
      sum1Sq += n*n
    }
    sum2Sq = 0
    v2.each{ |n|
      sum2Sq += n*n
    }

    # 積の合計
    pSum = 0
    for i in 0...v1.length
      pSum += v1[i]*v2[i]
    end

    # ピアソンによるスコアを算出
    num = pSum - (sum1*sum2/v1.length)
    den = Math::sqrt( (sum1Sq-sum1*sum1/v1.length)*(sum2Sq-sum2*sum2/v1.length) )
    return 0 if den == 0

    # 今回は特別に、アイテム同士が似ているほど小さい値を返す様にする
    return 1.0-num/den

  end

  def readline(filename)
    lines = Array.new
    open(filename).each{ |line|
      lines.push(line)
    }

    # 最初の行は列のタイトル（単語名）
    colnames = lines[0].strip().split("\t")
    colnames.shift # 最初の1つを捨てる

    # blog名と単語数
    rownames = Array.new
    data = Array.new
    lines[1...lines.length].each{ |line|
      tmp = line.strip().split("\t")
      # それぞれの行の最初の列は行の名前（blog名）
      rownames.push(tmp.shift)
      # 行の残りの部分がその行のデータ
      wordcount = Array.new
      tmp.each{ |c|
        wordcount.push(c.to_i)
      }
      data.push(wordcount)
    }

    return rownames,colnames,data
  end

end
