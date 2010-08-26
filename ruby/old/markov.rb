#-*- coding: UTF-8 -*-
def morphAnalyzer(str)
  s = str.gsub(/([一-龠々〆ヵヶ]+|[ぁ-ん]+|[ァ-ヴー]+|[a-zA-Z0-9]+|[ａ-ｚＡ-Ｚ０-９]+|[,.、。！!？?()（）「」『』]+|[ 　]+)/,"\\1|")
  ary = s.split("|")
  result = [];
  ary.each_index {|i|
    token = ary[i].match(/(でなければ|について|ならば|までを|までの|くらい|なのか|として|とは|なら|から|まで|して|だけ|より|ほど|など|って|では|は|で|を|の|が|に|へ|と|て)/).to_a
    if token
      token.each{|n|
        result.push(n)
      }
    end
  }
end
def markovChainSentence(str)
  dic = {}
  if str
  s = str.split("。")
    
    s.each_index {|i|
      if s[i]
        makeMarkovToken(s[i]+"。",dic)
      end
    }
    return markovChain(dic)
  end
end
def makeMarkovToken(str,dic)
  token = morphAnalyzer(str)
  token.unshift('_START_')
  token.push('_END_')
  while token[1]
    if dic[token[0]]
      dic[token[0]].push(token[1])
    else
      dic[token[0]] = [token[1]]
    end
    token.shift()
  end
end
def markovChain(dic)
  w1 = dic['_START_'][(rand()*dic['_START_'].length).floor]#
  
  w2 = ''
  sentence = w1
  100.times do
    w2 = dic[w1][(rand()*dic[w1].length).floor]
    if w2 == '_END_'
      break
    end
    sentence += w2
    w3 = w1
    w1 = w2
    w2 = w3
  end
  return sentence
end
