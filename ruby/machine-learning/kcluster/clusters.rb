#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# Cluster blog word vectors by k-means and by hierarchy, and draw the dendrogram.
$:.unshift File.join(File.dirname(__FILE__))

require 'bicluster.rb'
require 'rubygems'
require 'pp'
require 'RMagick'
include Magick

class Clusters
  def kcluster(rows, distance=:pearson, k=4)
    # Find the minimum and maximum of each point
    ranges = Array.new
    for i in 0...rows[0].length
      cols = Array.new
      for row in rows
        cols.push(row[i])
      end
      ranges.push([cols.min, cols.max])
    end

    # Place k centroids at random
    clusters = Array.new
    k.times do
      tmp = Array.new
      for i in 0...rows[0].length
        tmp.push( rand()*(ranges[i].max-ranges[i].min)+ranges[i].min )
      end
      clusters.push(tmp)
    end

    # Recompute and move the centroids 100 times, or until nothing changes
    lastmatches = nil
    for t in 0...100
      puts 'Iteration ' + t.to_s
      bestmatches = Array.new # create an empty array
      k.times do bestmatches.push(Array.new) end

      # Find the nearest centroid for each row
      for j in 0...rows.length
        row = rows[j]
        bestmatch = 0
        for i in 0...k
          d = self.method(distance).call(clusters[i],row) # compute the distance
          bestmatch = i if d < self.method(distance).call(clusters[bestmatch],row)
        end
        bestmatches[bestmatch].push(j)
      end

      # Stop once the result matches the previous round
      return bestmatches if bestmatches == lastmatches
      lastmatches = bestmatches

      # Move each centroid to the average of its members
      for i in 0...k
        avgs = Array.new(rows[0].length, 0.0) # build arrays initialized to 0.0
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

#  # Transpose the matrix
#  def rotatematrix(data)
#    newdata = Array.new
#    # There are too many words, so limit them to 100
#    for i in 0...[100, data[0].length].min
#      newrow = Array.new
#      for j in 0...data.length
#        newrow.push(data[j][i])
#      end
#      newdata.push(newrow)
#    end
#    return newdata
#  end

  # Draw the graph
  def drawdendrogram(clust, labels, imgfile='clusters.png')
    # Height and width
    h = getheight(clust) * 20
    w = 1200
    depth = getdepth(clust)

    # The width is fixed, so scale to fit
    scaling = Float(w-150)/depth

    # Create a new image on a white background
    img = Image.new(w,h)
    draw = Draw.new
    draw.stroke('red')
    draw.stroke_width(1)
    draw.line(0, h/2, 10, h/2)

    # Draw the first node
    drawnode(draw, clust, 10, (h/2), scaling, labels)

    # Draw and save
    draw.draw(img)
    img.write(imgfile)
  end

  def drawnode(draw, clust, x, y, scaling, labels)
    if clust.id < 0
      h1 = getheight(clust.left) * 20
      h2 = getheight(clust.right) * 20
      top = y-(h1+h2)/2
      bottom = y+(h1+h2)/2
      # Length of the line
      ll = clust.distance*scaling
      # Vertical line from the cluster down to its children
      draw.stroke('red')
      draw.line(x, top+h1/2, x, bottom-h2/2)

      # Horizontal line to the left item
      draw.line(x, top+h1/2, x+ll, top+h1/2)

      # Horizontal line to the right item
      draw.line(x, bottom-h2/2, x+ll, bottom-h2/2)

      # Recurse to draw the left and right nodes
      drawnode(draw, clust.left, x+ll, top+h1/2, scaling, labels)
      drawnode(draw, clust.right, x+ll, bottom-h2/2, scaling, labels)
    else
      # Draw the item label when this is an endpoint
      #draw.font = '/Library/Fonts/Arial.ttf'
      #draw.font = '/Library/Fonts/ヒラギノ角ゴ Pro W3.otf'
      draw.font = '/usr/share/fonts/truetype/vlgothic/VL-Gothic-Regular.ttf'
      draw.stroke('transparent')
      draw.fill('black')
      draw.pointsize = 10 # font size
      label = labels[clust.id]
      draw.text(x+3, y+4, label) if label != nil
    end
  end

  def getdepth(clust)
    # A leaf sits at distance 0.0
    return 0 if clust.left == nil && clust.right == nil

    # A branch adds its own distance to the deeper of its two sides
    return [getdepth(clust.left),getdepth(clust.right)].max + clust.distance
  end

  def getheight(clust)
    # A leaf has height 1
    return 1 if clust.left == nil && clust.right == nil

    # Otherwise the height is the sum of the branch heights
    return getheight(clust.left) + getheight(clust.right)
  end

  # Print the hierarchical clustering
  def printclust(clust,labels=nil,n=0)
    # Indent to produce a hierarchical layout
    n.times do
      print ' '
    end
    if clust.id < 0
      # A negative id marks a branch
      puts '-'
    else
      # A positive id marks a leaf
      if labels == nil
        puts clust.id
      else
        puts labels[clust.id]
      end
    end

    # Print the left and right branches
    printclust(clust.left, labels, n+1) if clust.left != nil
    printclust(clust.right, labels, n+1) if clust.right != nil
  end

  # Build the hierarchical clustering
  def hcluster(rows, distance=:pearson)
    distances = Hash.new
    currentclustid = -1

    # Each row starts out as its own cluster
    clust = Array.new
    for i in 0...rows.length
      c = Bicluster.new(rows[i])
      c.id = i
      clust.push(c)
    end

    while clust.length > 1
      lowestpair = [0,1]
      closest = self.method(distance).call(clust[0].vec, clust[1].vec)
      # Loop over every pair and find the closest one
      for i in 0...clust.length
        for j in i+1...clust.length
          # Compute the distance when it is not cached yet
          if !distances.key?([clust[i].id, clust[j].id]) # use an array as the hash key
            distances[[clust[i].id, clust[j].id]] = self.method(distance).call(clust[i].vec, clust[j].vec)
          end
          d = distances[[clust[i].id, clust[j].id]]
          if d < closest
            closest = d
            lowestpair = [i,j]
          end
        end
      end

      # Average the two clusters
      mergevec = Array.new
      for i in 0...clust[0].vec.length
        m = (clust[lowestpair[0]].vec[i] + clust[lowestpair[1]].vec[i])/2.0
        mergevec.push(m)
      end

      # Create the new cluster
      newcluster = Bicluster.new(mergevec, clust[lowestpair[0]], clust[lowestpair[1]], closest, currentclustid)

      # Give clusters outside the original set a negative id
      currentclustid -= 1
      clust.delete_at(lowestpair[1])
      clust.delete_at(lowestpair[0])
      clust.push(newcluster)
    end
    return clust[0]
  end

  # Compute the Pearson correlation distance
  def pearson(v1,v2)
    v1 = [v1] if v1.class != Array
    v2 = [v2] if v2.class != Array
    # Plain sums
    sum1 = 0
    v1.each{ |n|
      sum1 += n
    }
    sum2 = 0
    v2.each{ |n|
      sum2 += n
    }

    # Sums of squares
    sum1Sq = 0
    v1.each{ |n|
      sum1Sq += n*n
    }
    sum2Sq = 0
    v2.each{ |n|
      sum2Sq += n*n
    }

    # Sum of products
    pSum = 0
    for i in 0...v1.length
      pSum += v1[i]*v2[i]
    end

    # Compute the Pearson score
    num = pSum - (sum1*sum2/v1.length)
    den = Math::sqrt( (sum1Sq-sum1*sum1/v1.length)*(sum2Sq-sum2*sum2/v1.length) )
    return 0 if den == 0

    # Here it deliberately returns a smaller value the more similar the items are
    return 1.0-num/den
  end

  def readline(filename)
    lines = Array.new
    open(filename).each{ |line|
      lines.push(line)
    }

    # The first row holds the column titles, that is the words
    colnames = lines[0].strip().split("\t")
    colnames.shift # drop the first one

    # Blog names and word counts
    rownames = Array.new
    data = Array.new
    lines[1...lines.length].each{ |line|
      tmp = line.strip().split("\t")
      # The first column of each row is the row name, that is the blog name
      rownames.push(tmp.shift)
      # The rest of the row is its data
      wordcount = Array.new
      tmp.each{ |c|
        wordcount.push(c.to_i)
      }
      data.push(wordcount)
    }

    return rownames,colnames,data
  end

end
