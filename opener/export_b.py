#!/usr/bin/env python3
# from html.parser import HTMLParser

# path = "/home/spy/dotfiles2/opener/bookmarks.html"

# class MyHTMLParser(HTMLParser):
#     addr = ""
#     def handle_starttag(self, tag, attrs):
#         if(tag == "a" and attrs[0][1] != ""):
#             #print(attrs)
#             self.addr = attrs[0][1]
#             #print(attrs[0][1],end='')

#     def handle_endtag(self, tag):
#         pass

#     def handle_data(self, data):
#         if(self.addr != ""):
#             print(data+" | "+self.addr)
#         self.addr = ""

# r = open(path,"r")
# parser = MyHTMLParser()
# parser.feed(r.read())

import sqlite3
path = "/home/spy/.mozilla/firefox/vt9mewaq.default-release/weave/bookmarks.sqlite"

con = sqlite3.connect(path)

cur = con.cursor()
res = con.execute("SELECT title,urlId FROM items")

result = []

width = 0
for selected in res.fetchall():
    if selected[1] != None:
        if len(selected[0]) > width:
            width = len(selected[0])
        url = con.execute(f"SELECT url FROM urls WHERE id={selected[1]}")
        result.append([selected[0],url.fetchone()[0]])

for select in result:
    print(select[0],end='')
    for i in range(width - len(select[0])+1): print(" ",end="")
    print("|",select[1])
