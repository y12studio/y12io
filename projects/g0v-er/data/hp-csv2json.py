#!/usr/bin/env python
#coding:UTF-8
import urllib2,json,csv

url = "https://gist.githubusercontent.com/mcdlee/a3a7d55767e6f26fec44/raw/gistfile1.txt"
response = urllib2.urlopen(url)
cr = csv.reader(response)
l=[]
for row in cr:
    #print row[1]
	if len(row[0])==0:
		continue
	r={}
	r['name']=row[1]
	r['addr']=row[3]
	r['lon']=row[4]
	r['lat']=row[5]
	l.append(r)
print(json.dumps(l, indent=4,ensure_ascii=False))