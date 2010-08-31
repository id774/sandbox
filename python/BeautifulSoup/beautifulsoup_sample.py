#!/usr/bin/python
# -*- coding: utf-8 -*-
 
import re
import urllib2
from BeautifulSoup import BeautifulSoup
 
def main():
  html = urllib2.urlopen('http://id774.net/beautifulsoup_sample.html')
  #html = open('beautifulsoup_sample.html').read()
  soup = BeautifulSoup(html)
 
  # 基本はfindかfindAllでタグ名指定で要素を取得
  links = soup.findAll('a')         
  for link in links:
    print link.name                 # タグ名
    print link.string               # タグの中のテキスト
    print dict(link.attrs)['href']  # attrsはタプルのリストなので辞書経由でアクセスが便利
 
  blogdiv = soup.find('div', attrs={'id':'blog'})  # タグ名に加えてattrsで属性条件を入れる
  bloglinks = blogdiv.findAll('a')                 # 要素に対してもfind/findAll可能。子要素からの検索になる
  for link in bloglinks:
    print link  # 要素をそのまま出力すると、その部分のHTMLになる
 
  # タグ内のテキストで検索
  firstlinks = soup.findAll(text="one")            
  for link in firstlinks:
    print link.parent  # テキストで検索した場合はテキストオブジェクトが取れる。タグにアクセスしたい場合はparent経由
 
  # findAllのタグ条件はリストで複数指定可能
  li_or_a = soup.findAll(['a', 'li'])              
  for tag in li_or_a:
    print tag
 
  # テキスト検索も複数指定可能
  one_or_two = soup.findAll(text=['one', 'two'])   
  for tag in one_or_two:
    print tag
 
  # recursiveを無効にすれば、自身の子要素からのみ検索できる
  only_children = soup.find('body').findAll('div', recursive=False)
  for div in only_children:
    print div
 
  # 各属性の条件指定には正規表現オブジェクトを指定できる
  dot_com_links = soup.findAll('a', attrs={'href':re.compile(r'.*?\.com')})
  for link in dot_com_links:
    print dict(link.attrs)['href']
 
  # タグ名とテキスト内容を同時に指定しても、タグは取れない
  firstlinks = soup.findAll('a', text="one")
  for link in firstlinks:
    print link.parent  # やっぱりparentを経由する必要がある
 
if __name__ == '__main__':
  main()

