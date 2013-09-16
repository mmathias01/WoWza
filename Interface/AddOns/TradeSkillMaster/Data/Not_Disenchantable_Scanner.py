# Simple python script for getting all weapons/armor that can't be disenchanted and are not BoP from Wowhead

import re
import urllib2

urls = [
	'http://www.wowhead.com/items=2?filter=qu=2%3A3%3A4%3Bcr=8%3A2%3Bcrs=2%3A2%3Bcrv=0%3A0',
	'http://www.wowhead.com/items=4?filter=qu=2%3A3%3A4%3Bcr=8%3A2%3Bcrs=2%3A2%3Bcrv=0%3A0'
]

output = open('output.txt', 'w')
for url in urls:
	pageLines = urllib2.urlopen(urllib2.Request(url, None)).read().split('\n')
	for line in pageLines:
		if line[:12] == "new Listview":
			for m in re.findall(r'"id":([0-9]+)', line):
				print>>output, '\t["item:'+m+':0:0:0:0:0:0"] = true,'
output.close()