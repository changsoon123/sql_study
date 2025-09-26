
# 연산자
# -> 이식성 풍부하다
# -> 산술, 비교, 논리연산자

# 1. 산술연산자
print(5+3)
print(5-3)
print(5*3)
print(5/3) # 몫 (실수값)
print(5//3) # 몫 (정수값)
print(5%3) # 나머지값

print(3/5)
print(3//5)
print(3%5)
print(3**5) # 3의 5승

#####################################################
print("-" * 30)

# 2. 비교연산자 (관계)
# -> 결과값이 논리형(참, 거짓)으로 반환된다.
# -> 논리형(boolean) : True, False
print(3<5) # True
print(3>5) # False
print(3<=5) 
print(3>=5)
print(3==5) # 서로 같다
print(3!=5) # 서로 같지 않다

#####################################################
print("-" * 30)

# 3. 논리연산자
# -> 조건이 2개 이상일때 전체적으로 판단
# -> 결과값이 논리형(참, 거짓)으로 반환된다.
# -> and, or, not

## 1) and 연산자
## -> 그리고, ~이면서
## -> 모든 조건을 만족하면 True

print(True and True)
print(True and False)
print(False and True)
print(False and False)

## 2) or 연산자
## -> 또는, ~이거나
## -> 조건들 중에서 하나라도 True이면 True

print(True or True)
print(True or False)
print(False or True)
print(False or False)

## 3) not 연산자
## -> 부정연산자, ~가 아니라면
flag = not(3<5)
print(flag)

#####################################################
print("-" * 30)

# 4. 할당 연산자
a = 1
a= a + 3 
a += 3
print(a)

b = 3
b = b - 1
b -= 1
print(b)

c = 5
c *= 2
print(c)

d = 7
d /= 3
print(d)





