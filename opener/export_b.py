#!/usr/bin/env python3
from html.parser import HTMLParser

path = "/home/spy/dotfiles2/opener/bookmarks.html"

class MyHTMLParser(HTMLParser):
    def handle_starttag(self, tag, attrs):
        if(tag == "a"):
            print(attrs[0][1])

    def handle_endtag(self, tag):
        pass

    def handle_data(self, data):
        pass
        #print("Encountered some data  :", data)

r = open(path,"r")
parser = MyHTMLParser()
parser.feed(r.read())
