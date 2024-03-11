#!/usr/bin/env python3
from html.parser import HTMLParser

path = "/home/spy/dotfiles2/opener/bookmarks.html"

class MyHTMLParser(HTMLParser):
    addr = ""
    def handle_starttag(self, tag, attrs):
        if(tag == "a" and attrs[0][1] != ""):
            #print(attrs)
            self.addr = attrs[0][1]
            #print(attrs[0][1],end='')

    def handle_endtag(self, tag):
        pass

    def handle_data(self, data):
        if(self.addr != ""):
            print(data+" | "+self.addr)
        self.addr = ""

r = open(path,"r")
parser = MyHTMLParser()
parser.feed(r.read())
