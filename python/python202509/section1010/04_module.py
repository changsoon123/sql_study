
# -> 모듈:다른 프로그램에서 활용하기 위한 프로그램 조각, 남이 만들어둔 코드의 집합
# -> 하나의 파이썬 .py 파일이 하나의 모듈이 된다
# -> 모듈 선언 형식) import 파일이름 또는 모듈이름

# my_module.py

"""

import my_module

print(my_module.Name)
print(my_module.plus(1,3))
print(my_module.minus(2,4))

"""

"""
# 2) 모듈에 별칭 적용
# -> import 파일이름 as 별칭
import my_module as kim

print(kim.Name)
print(kim.plus(1,3))
print(kim.minus(2,4))

"""

# 3) 모듈안에 포함된 특정 기능만 골라서 가져오기
# -> from 모듈이름 import 기능명
from my_module import Name
from my_module import plus

print(Name)
print(plus(5,3))
# print(minus(5,3)) 에러

