
from matplotlib import pyplot
from wordcloud import WordCloud

import requests
from bs4 import BeautifulSoup

map_svg=None

with open("Korea.svg" ,"r", encoding='utf-8') as f:
    map_svg = f.read()

colors = ['#FFD9FA','#FFB2F5','#F361DC','#D941C5','#990085','#660058']   

soup = BeautifulSoup(map_svg, 'lxml')

## Korea.svg 이미지에서 <g id='값'> <path id='값'> 태그 추출
glist = soup.select('svg > g[id], svg > path[id]')
print(glist)
