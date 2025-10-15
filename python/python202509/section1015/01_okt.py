# 01_okt.py
# 한글 기반 형태소 분석
# -> Okt클래스를 사용해 한글 명사 단어 빈도 계산


from konlpy.tag import Okt
import numpy as np
from collections import Counter   #빈도수 계산 (파이선 기본 내장 클래스)


data = ""
with open ("대한민국헌법.txt", "r", encoding="utf-8") as f:
    # data = f.readlines() 엔터(\n)를 기준으로 리스트형 반환
    data = f.read() # 파일 전체를 하나의 문자열형으로 반환

#print(data)
#print(type(data))


# data변수가 가지고 있는 내용을 기반으로 형태소 분석
nlp = Okt() #형태소 분석 클래스 객체 생성

# morphs()  : 형태소 단위 구문 분석
# nouns()   : 명사만 추출
# phrases() : 어절만 추출
# pos()     : 형태소 단위로 쪼갠 후 각 품사들을 태깅해서 리스트형태로 반환 

 
# 명사들만 추출 -> 리스트형식으로 반환
nouns = nlp.nouns(data)
#print(nouns)
#print(type(nouns))


# 명사형태의 단어들만 뽑아서 리스트를 만들고 한글자로 된 단어는 잘라냄
# -> 개인이 판단
words = []
for n in nouns:
    if len(n) > 1:
        words.append(n)

#print(words)
 

# 단어 빈도수 계산
# Counter객체를 통해 리스트 요소들의 빈도수 계산해서 딕셔너리값으로 반환
count = Counter(words)
#print(count)
#print(type(count))


# 가장 많이 등장한 상위 100개 추출 -> 리스트형 반환
most = count.most_common(100)
#print(most)
#print(type(most))


# WordCloud 객체가 요구하는 형식으로 딕셔너리를 구성
tags = {}
for n, c in most:
    #print(n)
    #print(c)
    tags[n] = c

print(tags) #최종값


# 수집결과(tags)를 활용해서 워드클라우드 생성
from matplotlib import pyplot     
from wordcloud  import WordCloud  
from wordcloud  import STOPWORDS

wc = WordCloud(
                font_path='gulim'
               ,width=1200
               ,height=800
               ,scale=2.0
               ,max_font_size=250
              )

gen = wc.generate_from_frequencies(tags)
pyplot.figure()
pyplot.imshow(gen, interpolation="bilinear")
pyplot.show()
pyplot.close()