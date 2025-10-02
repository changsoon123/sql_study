
# numpy 모듈 기반 배열 연산

import numpy as np

ls1 = [82,76,91,65]

# 문제) ls 각 요소에 2씩 더하기
# -> [84,78,93,67]

ls2 = [0,0,0,0]
for idx in range(4):
    ls2[idx] = ls1[idx] + 2

print(ls2)

# 문제) ls3과 ls4의 인덱스가 동일한 각 요소끼리 더해서 ls5에 저장하기
ls3 = [10, 15, 20, 25, 30]
ls4 = [2, 3, 4, 5, 6]
ls5 = [0, 0, 0, 0, 0]

# 방법 1: + 연산자 사용
arr3 = np.array(ls3)
arr4 = np.array(ls4)
ls5 = arr3 + arr4
print(ls5)  # [12 18 24 30 36]

# 방법 2: np.add() 함수 사용
ls5 = np.add(ls3, ls4)
print(ls5)  # [12 18 24 30 36]

# 방법 3: 기존 ls5 배열에 직접 할당
arr5 = np.array(ls5)
arr5[:] = np.array(ls3) + np.array(ls4)
print(arr5)

# numpy 모듈을 활용한 정형화된 배경 만들기

b = np.arange(100, 115)
print(b)
print(len(b))

# 모든 요소가 실수형 0인 1행 3열 배열 생성
c = np.zeros([3])
print(c)

c = np.zeros([3], dtype='int')

print(c)

e = np.ones([3])
print(e)

f = np.ones([4], dtype='int')
print(f)

g = np.full([5], 7)
print(g)

h = np.full([4],7, dtype='float')
print(h)