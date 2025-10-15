#05_crawling_naver.py
# 네이버 뉴스중에서 [세계] 카테고리의 링크문서들의 본문 내용 크롤링하고, 워드크라우드 및 엑셀 파일 생성하기

from Crawler      import crawler            #Crawler.py모듈의 crawler객체
from bs4          import BeautifulSoup


# 1. 네이버 세계 뉴스 크롤링하기

## 1) URL 설정하기
URL = "https://news.naver.com/section/104"


## 2) 수집할 뉴스기사의 URL 조사
## <div class="sa_text">
##     <a href=""></a>
## </div>
link_list = crawler.select(URL, encoding="utf-8", selector=".sa_text > a")

# 46건
#<a class="sa_text_title _NLOG_IMPRESSION" data-clk="airscont" data-extra='{"airs":{"model_version":"news_sec_v2.0","session_id":"kj1lSxAKDcwkSxt3"}}' data-gdid="8800006B_000000000000000003402119" data-imp-url="https://n.news.naver.com/mnews/article/032/0003402119" data-rank="35" href="https://n.news.naver.com/mnews/article/032/0003402119">
#    <strong class="sa_text_strong">중국 ‘한화오션 때리기’에 일본 언론 “우리도 위험”</strong>
#</a>
#<a class="sa_text_title _NLOG_IMPRESSION" data-clk="airscont" data-extra='{"airs":{"model_version":"news_sec_v2.0","session_id":"kj1lSxAKDcwkSxt3"}}' data-gdid="88127058_000000000000000001114539" data-imp-url="https://n.news.naver.com/mnews/article/366/0001114539" data-rank="36" href="https://n.news.naver.com/mnews/article/366/0001114539">
#    <strong class="sa_text_strong">中 9월 물가, 예상보다 더 내려… “1970년대 이후 최장기 하락”</strong>
#</a>
for item in link_list:
    print(item)

#print(type(link_list))
#print(len(link_list)) 46건
print("/" * 50)


## 3) 2)의 item에서 <a> 태그가 가지고 있는 속성들 중에서 href속성 값만 추출하기
url_list = [] #헤드라인 뉴스 기사의 본문 URL를 저장
for item in link_list:
    # print(type(item.attrs)) #속성 타입 확인 (딕셔너리 속성)
    # 각 <a>링크의 속성들(attrs)중에 href속성이 있다면, 그 속성값을 url_list변수에 추가
    if 'href' in item.attrs:
        #print(item['href'])
        url_list.append(item['href'])

#https://n.news.naver.com/mnews/article/021/0002742677
#https://n.news.naver.com/mnews/article/448/0000563640    
print("/" * 50)    

# 집계된 리스트의 링크주소값 확인하기
for u in url_list:
    print(u)

print("네이버 세계 헤드라인 뉴스기사 크롤링 시작 >> 총 %d개의 기사를 수집합니다." % len(url_list))
print("*" * 50)     


## 4) 네이버 뉴스기사(세계)에 접속해서 본문 크롤링하기
## <article id="dic_area"> ..... </a>
news_content = '' #뉴스기사의 본문을 누적해서 저장할 문자열 변수
for i, url_world in enumerate(url_list): #url_world : 크롤링할 페이지의 URL주소
    print("%d번째 뉴스기사 수집중...>> %s" % (i+1, url_world))
    # URL에 접근해서 뉴스기사 가져오기
    news_html = crawler.select(url_world, encoding='utf-8', selector='#dic_area')

    if not news_html:
        print("%d번째 네이버 세계 헤드라인 뉴스기사 크롤링 실패" % (i+1))
    else:
        print("%d번째 네이버 세계 헤드라인 뉴스기사 크롤링 성공" % (i+1))
        #print(news_html)
        for item in news_html:
            crawler.remove(item, 'br')
            crawler.remove(item, 'div')
            crawler.remove(item, 'img')
            crawler.remove(item, 'em')
            crawler.remove(item, 'strong')
            crawler.remove(item, 'span')
            crawler.remove(item, 'script')
            news_content += item.text.strip()


print(news_content) # 본문내용만 크롤링한 최종값



# 2. 수집결과(news_content)를 기반으로 텍스트 마이닝
from collections  import Counter
from konlpy.tag   import Okt

nlp = Okt()
nouns = nlp.nouns(news_content)  #명사만 추출
count = Counter(nouns)           #명사들에 대한 빈도수 검사
most = count.most_common(100)    #가장 많이 사용된 단어 100개 추출

#{"단어": 빈도수, "단어": 빈도수 ...} 변환
tags = {}
for n, c in most:
	if(len(n)>1):
		tags[n]=c

print(tags) #워드클라우드에 사용할 값



# 3. 2번에서 작성한 tags값을 이용해서 워드크라우드 생성
from wordcloud    import WordCloud
from matplotlib   import pyplot

wc = WordCloud(font_path="gulim"
	            ,max_font_size=200
	            ,width=1200
	            ,height=800
	            ,scale=2.0
	            ,background_color='#ffffff')

gen = wc.generate_from_frequencies(tags)

pyplot.figure()
pyplot.imshow(gen, interpolation='bilinear')
pyplot.axis("off")
wc.to_file("naver_worldnews_20251015.png")
pyplot.show()
pyplot.close()



# 4. 정제한 데이터를 엑셀로 저장
from pandas import DataFrame
from pandas import ExcelFile

lists = []
for n, c in most:
	if(len(n)>1):
		lists.append([n, c])

df = DataFrame(lists, columns=['단어','빈도수'])
df.to_excel("네이버세계뉴스_20251015.xlsx"
	        , sheet_name='단어빈도수'
	        , index=False)
            
print(df)