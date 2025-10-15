#Crawler.py
#웹 크롤러 만들기 
#->URL, CSS Selector, HTML tag를 입력받아 크롤링하는 크롤러

import sys   #현재 시스템의 정보를 제공
import os    #운영체제 기능에 접근
import requests
from bs4 import BeautifulSoup

#크롤링 클래스
class Crawler:
    #멤버변수
    user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36"

    session=None
    
    #생성자함수
    def __init__(self, referer=''):        #self: 자바의 this와 같은 개념
        self.session = requests.Session()
        self.session.headers.update( {'referer': None, 'User-agent': self.user_agent} )

    #멤버함수
    #HTML 페이지에 접속하여 페이지의 모든 소스코드를 가져온다.
    def get(self, url, encoding='utf-8'):
        r=self.session.get(url)

        if r.status_code != 200:  #에러가 나면 None 값 리턴
            return None

        r.encoding = encoding
        return r.text.strip() 
        
        
    #HTML 페이지에 접속하여 특정 요소에 대하여 파싱한 결과를 List로 반환한다.
    def select(self, url, selector='html', encoding='utf-8'):   
        source = self.get(url, encoding)

        if not source:
            return None

        soup = BeautifulSoup(source, 'html.parser')
        return soup.select(selector)
        
        
    #크롤링한 결과 원본(item)에서 tag와 selector가 일치하는 항목을 삭제
    def remove(self, item, tag, selector=None):
        for target in item.find_all(tag, selector):
            target.extract()
            

###########################################################
 
#Crawler 클래스에 대한 객체 생성
crawler = Crawler()               