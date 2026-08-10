#!/usr/bin/python
# -*- coding: utf-8 -*-
# Extract links and elements from a web page with BeautifulSoup; written for Python 2.

import re
import urllib2
from BeautifulSoup import BeautifulSoup

def main():
    html = urllib2.urlopen('http://id774.net/beautifulsoup_sample.html')
    #html = open('beautifulsoup_sample.html').read()
    soup = BeautifulSoup(html)

    # Normally use find or findAll with a tag name to get elements
    links = soup.findAll('a')
    for link in links:
        print link.name                 # tag name
        print link.string               # text inside the tag
        print dict(link.attrs)['href']  # attrs is a list of tuples, so a dict is the easier way in

    blogdiv = soup.find('div', attrs={'id': 'blog'})  # attrs adds an attribute condition on top of the tag name
    # find and findAll also work on an element, searching its children
    bloglinks = blogdiv.findAll('a')
    for link in bloglinks:
        print link  # printing an element gives back that part of the HTML

    # Search by the text inside a tag
    firstlinks = soup.findAll(text="one")
    for link in firstlinks:
        print link.parent  # a text search yields a text object, so reach the tag through parent

    # findAll takes a list to match several tag names
    li_or_a = soup.findAll(['a', 'li'])
    for tag in li_or_a:
        print tag

    # a text search can also take several patterns
    one_or_two = soup.findAll(text=['one', 'two'])
    for tag in one_or_two:
        print tag

    # Turning recursive off searches only the direct children
    only_children = soup.find('body').findAll('div', recursive=False)
    for div in only_children:
        print div

    # An attribute condition can be given as a regular expression object
    dot_com_links = soup.findAll('a', attrs={'href': re.compile(r'.*?\.com')})
    for link in dot_com_links:
        print dict(link.attrs)['href']

    # Giving both a tag name and text content does not return the tag
    firstlinks = soup.findAll('a', text="one")
    for link in firstlinks:
        print link.parent  # again, parent is needed to reach the tag

if __name__ == '__main__':
    main()
