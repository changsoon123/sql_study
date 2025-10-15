# 04_crawling.py
# 네이버 뉴스기사(1건)의 상세설명부부 가져오기

import requests               
from bs4 import BeautifulSoup

# 웹 사이트 크롤링에서 사용할 URL 정보
# 웹 브라우저 버전 정보
# F12 -> Network -> Headers 또는 페이지 소스 보기

# 응답받는 사용자의 웹브라우저 정보
user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"

# 네이버 뉴스 기사
naver_news_url = "https://n.news.naver.com/article/422/0000790979?ntype=RANKING"

# 데이터 수집 - 웹 페이지 HTML 소스코드 가져오기
# 접속 세션을 생성
# 세션 -> 클라이언트(브라우저)와 서버(웹사이트)간의 연결단위
#      -> 이 객체에 접속에 필요한 기본 정보를 설정한다.
session = requests.Session()

# 현재 세션의 referer 페이지를 '없음'으로 강제 설정
# -> referer : 이전에 머물렀던 페이지 주소
# -> referer값이 없으면 웹 서버는 브라우저에서 직접 URL을 입력한 것으로 간주한다.
# 현재 세션의 웹 브라우저 정보(User-agent)를 구글 크롬으로 설정
session.headers.update( {'referer': None, 'User-agent': user_agent} )

# 특정 웹 페이지에 접속
r = session.get(naver_news_url)

# 가져온 HTML 코드 확인 
r.encoding = "utf-8"
# print(r.text)


## 1) HTML문서를 분석해서 원하는 영역 추출

# 웹 페이지의 소스코드 HTML 분석 객체로 생성
soup = BeautifulSoup(r.text, 'html.parser')

# CSS 선택자를 활용하여 가져오기를 원하는 부분 지정
# -> <article id="dic_area"> ...... </article>
selector = soup.select("#dic_area")
#print(selector)



## 2) 데이터 전처리
## -> 추출된 영역(selector)안에서 불필요한 태그 제거
for item in selector:
    for target in item.find_all('br'):
        target.extract() # 찾아낸 <br> 태그 삭제
    for target in item.find_all('div'):
        target.extract()
    for target in item.find_all('img'):
        target.extract()
    for target in item.find_all('em'):
        target.extract()
    for target in item.find_all('span'):
        target.extract()

print(item)        


# 최종 결과값 확인
result_str = item.text.strip() # 공백제거
print(result_str)

