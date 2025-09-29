
# -> math함수 : 수학관련
# 모듈 : 파이썬 코드를 논리적으로 묶어서 관리하고 사용할 수 있도록 하는 것
# 패키지 : 모듈들을 모은 컬렉션


## 1) import 하지 않고 사용할 수 있는 내장함수

x = min(1,2,3,4,5)
y = max(1,2,3,4,5)

print(x)
print(y)

x = abs(3)
y = abs(-3)
print(x)
print(y)

x = pow(2, 4)
print(x)

print(round(123.456, 2))
print(round(123.453, 2))

import math #모듈 선언

print(math.pi)

# 소수점을 올림
x = math.ceil(2.2)
y = math.ceil(3.5)
print(x)
print(y)

# 소수점을 내림
x = math.floor(2.2)
y = math.floor(3.5)
print(x)
print(y)

from math import ceil, floor  ##이렇게도 가능
print(ceil(5.5))
print(floor(5.5))


