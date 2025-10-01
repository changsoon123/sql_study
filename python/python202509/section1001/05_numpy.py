
# -> 리스트의 기능 강화판. 과학 계산을 위한 라이브러리
# -> 다차원 배열을 처리하는데 필요한 여러 기능을 제공하고 있다.
# -> 배열 Array : 데이터를 모아놓은 자료 구조
# -> 리스트, 튜플, 딕셔너리 등등



# 설치 모듈 확인
#    >pip list

#    numpy 모듈 설치 
#    >pip install numpy

#    numpy 모듈 삭제 
#    >pip uninstall -y numpy

import numpy as np

arr = [1,2,3]
print(arr)
print(len(arr))

# 리스트 값을 1차원 배열
a = np.array(arr)
print(a)
print(len(a))

b = np.array([1,2.3,4,5.6]) # 실수가 범위가 더 크므로 모든 요소가 실수형으로 변환
print(b)

#모든 타입이 문자열로 변환
c = np.array([1.2, 3, '4'])
print(c)

d = np.array([1,2.3,4,5.6], dtype='int')
print(d)

e = np.array([1,2.3,4,5.6], dtype='float')
print(e)
print(e[0])
print(e[1])
print(e[2])

# enumerate() : # 반복문에서 인덱스와 벨류값을 동시에 가져올 떄
for idx, v in enumerate(e):
    print("%d번 째 요소 : %f" % (idx, v))

