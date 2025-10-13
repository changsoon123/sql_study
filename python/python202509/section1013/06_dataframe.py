

#DataFrame
#->2차원 자료구조. 행과 열이 있는 테이블 데이터(Table Data) 처리
#->엑셀
"""
    ● pandas 패키지
      - 데이터 분석용 라이브러리
      - 자료형 : Series(1차원), DataFrame(2차원), Panel(3차원)
        
    ● 모듈설치
      >pip list
      >pip install pandas    
"""

from pandas import DataFrame
from sample2 import grade_list

print(grade_list)

df = DataFrame(grade_list)
print(df)
print(type(df))

print(df[0])

i_names = ['무궁화','홍길동','개나리','진달래','봉선화']
c_names = ['국어', '영어', '수학', '과학']
df = DataFrame(grade_list, index=i_names, columns=c_names)

print(df)

print(df['국어'])
print(df['영어'])

print(df.loc['무궁화'])
print(df.loc['홍길동'])

print("무궁화의 국어 점수 : %d" % df['국어']['무궁화'])
print("무궁화의 국어 점수 : %d" % df.loc['무궁화','국어'] )

"""
-----------------------------------------------
    count 각 열별로 유효한 값의 수
    mean  평균
    std   표준편차
    min   최소값
    max   최대값
    사분위수 : 1사분위 수(하위 25%)
              2사분위 수(중앙값 50%)
              3사분위 수(하위 75%)   ->상위 25%     
---------------------
"""

print(df)

print(df.describe())

print(df.count())
print(df['영어'].count())
print(df['영어'].min())
print(df['영어'].max())
print(df['영어'].sum()) 
print(df['영어'].mean()) # 평균 
print(df['영어'].std()) #표준편차
print(df['영어'].median()) #중앙값
print(df.quantile(q=0.25)) # 각 열의 1사분위 수 (상위 25%위치의 값)

#데이터 전처리 Data Preprocessing
#->분석에 적합하게 데이터를 가공하는 작업

#'axis=1' 을 설정하면 각각의 행에 대해 계산함
#NaN은 대상에서 제외
df['평균'] = df.mean(axis=1)
print(df)

import numpy as np
#[결과] -> 평균칼럼의 점수가 70점이상이면 합격, 불합격
df['결과'] = np.where(df['평균'] >= 70, "합격", "불합격")
print(df)

#[학점] -> 평균 점수에 따라 A, B, C, d
conditions = [(df['평균'] >= 90), (df['평균'] >= 80), (df['평균'] >= 70), (df['평균'] < 70) ]
grade = ['A' ,'B', 'C', 'D']
df['학점'] = np.select(conditions, grade, default='F')
print(df)

# 상자그림 (boxplot)
from matplotlib import pyplot

pyplot.rcParams["font.family"] = 'gulim'
pyplot.rcParams["font.size"]   = 12
pyplot.rcParams["figure.figsize"] = (6, 4)

pyplot.figure()
pyplot.grid()
df.boxplot('평균') # 국어는 밑, 평균은 위
pyplot.title("2025년 국어점수 분포도")
pyplot.ylabel("국어점수")
pyplot.show()
pyplot.close()

# 데이터 정제
# -> 결측치 (Missing value) : 누락된 값, 비어 있는 값
# -> 이상치 (Outlier)       : 정상 범주에서 크게 벗어난 값

from sample2 import grade_dic

#데이터 구성하기
df = DataFrame(grade_dic, index=['무궁화', '홍길동', '개나리', '진달래', '봉선화'])
print(df)

# 결측치 여부 확인
# -> isnull(), isna() 함수
empty = df.isna()
print(empty)

empty = df.isnull() # null 값이면 True 반환
print(empty)

# 국어점수에 대한 이상치 필터링
r = df.query("국어>100") #봉선화 120 50.0 NaN 88.0
print(r)

# 봉선화 국어점수(120) 이상치를 결측치로 변경
r_index = list(r.index)
print(r_index)

# 이상치를 갖는 인덱스에 대한 국어 점수를 결측치로 변경
for i in r_index:
    df.loc[i, '국어'] = np.nan

print(df)