
# 1)
# import my_module
# print(my_module.mycalc.plus(3 , 5))
# print(my_module.mycalc.minus(2 , 4))

# # 2) 모듈 자체에 별칭 부여

# import my_module as hello
# print(hello.mycalc.plus(3 , 5))
# print(hello.mycalc.minus(2 , 4))

# 3) 모듈에 정의된 특정 객체만 가져오기

from my_module import mycalc
print(mycalc.plus(3,5))
print(mycalc.minus(2,4))
