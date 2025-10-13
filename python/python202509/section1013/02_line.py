
import numpy as np
from matplotlib import pyplot

from sample import newborn
from sample import year

# 문제) sample.py의 newborn리스트값에서 최대값, 최소값을 각각 출력하시오
print("최대값 : %d" % np.max(newborn))
print("최소값 : %d" % np.min(newborn))

pyplot.figure()
pyplot.plot(newborn)
pyplot.show()
pyplot.close()

#2) 축제목, 선 종류, 선 색
pyplot.figure()
pyplot.plot(newborn, label="Baby Count", linestyle="--", marker=".", color="#ff2900")
pyplot.legend() #label 속성 적용
pyplot.grid()   #배경에 그리드 표시
pyplot.savefig("line1.png")
pyplot.show()
pyplot.close()

from sample import seoul
from sample import busan
from sample import daegu
from sample import inchun
from sample import label

#시스템 글꼴폴더(C:\Windows\Fonts)에서 확인
#굴림보통 gulim, 바탕batang
#한글폰트(.ttf) 설정
pyplot.rcParams["font.family"] = "batang"
pyplot.rcParams["font.size"] = 12

pyplot.figure()
pyplot.grid()

#그래프 제목, x, y축 라벨 설정
pyplot.title('2017년 주요도시 교통사고')
pyplot.xlabel('월')
pyplot.ylabel('교통사고')

pyplot.plot(seoul, label = '서울')
pyplot.plot(busan, label = '부산')
pyplot.plot(daegu, label = '대구')
pyplot.plot(inchun, label = '인천')

pyplot.legend(title='도시', loc='upper right', shadow=True) #범례 적용

#pyplot.savefig('traffic1.png', dpi=200) #해상도 dpi=100 기본값

#x,y축의 범위 설정
pyplot.xlim(0,11)
pyplot.ylim(0,4000)

#x축의 각 지점에 적용될 라벨 설정
#-> 0부터 1씩 증가하는 label리스트 만큼의 크기를 갖는 리스트
x = list(range(0, len(label))) #0~11

#-> x 리스트의 각 좌표에 지정될 라벨 설정
pyplot.xticks(x, label)

pyplot.show()
pyplot.close()

# 막대그래프
# -> 범주, 빈도 데이터를 요약해서 보여주는 그래프
# 모듈참조 (sample.py)
from matplotlib import pyplot
from sample import newborn
from sample import year

pyplot.rcParams["font.family"] = 'gulim'
pyplot.rcParams["font.size"]   = 12

#생성될 결과물의 가로,세로 크기 (inch단위)
pyplot.rcParams["figure.figsize"] = (12, 8)

pyplot.figure() 
#세로 막대 그래프
#-> bar() 함수의 기준축은 x방향임
pyplot.bar(year, newborn, label="신생아 수")
pyplot.legend()
pyplot.xlabel("년도") 
pyplot.ylabel("신생아 수") 
pyplot.ylim(350000, 450000)
pyplot.title("년도별 신생아수")
pyplot.grid() 

#pyplot.savefig('box.png')
pyplot.show()

pyplot.figure()

# 막대그래프 기준축에 대한 좌표를 표현한 배열 생성 (0~11)
x = np.arange(len(label)) #0~11

#기준축(x축)의 좌표와 굵기를 설정한 막대그래프
pyplot.bar(x, seoul, label="서울", width=0.4, color="#ff6600")
pyplot.bar(x, busan, label="부산", width=0.4, color="#0066ff")

pyplot.xticks(x, label)
pyplot.legend() 
pyplot.xlabel('월')  
pyplot.ylabel('교통사고 수') 
pyplot.ylim(0,4000) 
pyplot.title('2017년 서울,부산 교통사고 현황')

pyplot.show()
pyplot.close()

y = np.arange(len(label))

#기준축(y축)의 좌표와 굵기를 설정한 막대그래프
pyplot.barh(y-0.1, seoul, label="서울", height=0.4, color="#ff6600")
pyplot.barh(y+0.1, busan, label="부산", height=0.4, color="#0066ff")
pyplot.yticks(y, label)
pyplot.legend() 
pyplot.ylabel('월')  
pyplot.xlabel('교통사고 수') 
pyplot.xlim(0,4000) 
pyplot.title('2017년 서울,부산 교통사고 현황')

pyplot.show()
pyplot.close()