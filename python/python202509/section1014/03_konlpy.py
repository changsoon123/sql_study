# 03_konlpy.py
# 참조 https://wikidocs.net/21667

# konlpy : 한글 기반의 자연어 처리 파이선 패키지, 한글 형태소 분석기. 5개의 클래스로 구성되어 있음
# -> Hannanum : 카이스트 SWRC에 의해 개발된 자바로 만들어진 형태소 분석기
# -> Kkma     : 서울대학교에서 만든 한글 형태소 분석기. 꼬꼬마
# -> Komoran  : 자바로 만든 오픈소스 한국어 형태소 분석기
# -> Okt      : Open Korean Text (구)트위터 형태소분석기
"""
   ● konlpy 패키지 사용하기 위한 사전 준비 사항
     1. Microsoft C++ Build Tools 설치
        https://visualstudio.microsoft.com/visual-cpp-build-tools/

     2. Java (JDK) 설치
        https://www.oracle.com/java/
"""
#     3. JAVA_HOME 환경변수 설정
#        JAVA_HOME "C:\Program Files\Java\jdk-21"
#        PATH "%JAVA_HOME%\bin"

#     4. KoNLPy 설치
#        >pip install konlpy


text = '아름답지만 다소 복잡하기도한 한국어는 전세계에서 13번째로 많이 사용되는 언어입니다'
print(text)


# 1. 한나눔 형태소 분석기를 이용해 태깅(품사구분)
from konlpy.tag import Hannanum

han = Hannanum()
print(han.analyze(text)) #각 토큰에 대한 다양한 형태소 후보를 반환합니다
print(han.nouns(text))   #명사 추출
print(han.morphs(text))  #형태소 분석 문구 반환

print("-" * 30)



# 2.Kkma : 서울대학교에서 만든 한글 형태소 분석기. 꼬꼬마
from konlpy.tag import Kkma

kkma = Kkma()
print(kkma.morphs(text)) #형태소 분석 문구 반환
print(kkma.nouns(text))  #명사 추출
print(kkma.pos(text))    #품사

print("-" * 30)



# 3. Komoran : 자바로 만든 오픈소스 한국어 형태소 분석기
from konlpy.tag import Komoran
kom = Komoran()
print(kom.morphs(text)) #형태소 분석 문구 반환
print(kom.nouns(text))  #명사 추출
print(kom.pos(text))    #품사

