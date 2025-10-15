# 03_crawling.py

# 크롤링(Crawling)
# ->웹 페이지를 그대로 가져와서 거기서 데이터를 추출해 내는 행위다.
# ->크롤링하는 소프트웨어는 크롤러(crawler)라고 부른다.
# ->동적으로 웹페이지를 돌아다니면서 수집하는 것을 말한다.
# ->Web Scraping

"""----------------------------------------------
   없으면 모듈설치
   >pip install requests
   >pip install bs4
-------------------------------------------------"""

import requests                #웹 페이지 요청 모듈
from bs4 import BeautifulSoup  #웹 페이지 소스코드 분석 모듈  

# URL
url = "https://www.itwill.co.kr/"

# 특정 웹 페이지 접속
r = requests.get(url)

# 인코딩 형식 지정
r.encoding = "utf-8"

print(r.text)
