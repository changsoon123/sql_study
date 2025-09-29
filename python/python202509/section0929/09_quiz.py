
#문제1) 1~3 사이의 합을 구하시오

i = 1
result = 0
while i<=3:
     result += i
     i += 1

print(result)

#문제2) 4팩토리얼값을 구하시오 (누적의 곱)

i=1
x=1
result = 0
while i < 5:
   x *= i
   i += 1

print(x)


#문제3) 두 수 사이의 수를 전부 더하시오

x = 0
result = 0
for i in range(1,10):
    x += i
    i += 1

print(x)

start = 2
end = 5
sum = 0

# 만일, 앞의 수가 뒤의 수보다 크면 두 변수의 값을 서로 교환(swap)

"""
if start>end:
    tmp = start
    start = end
    end = tmp

if start>end:
    start, end = end, start
    두 수를 교환할 때 파이썬에서만 되는 문법
"""


while start<=end:
    sum = sum + start
    start = start + 1


print("두수사이의 합 : %d" % sum)

#################################################

#문제4) 간단한 계산기 프로그램
""" 
    실행화면   
    3 + 5 = 8   
    3 - 5 = -2
    3 * 5 = 15
    3 / 5 = 0.6   
    3 % 5 = 3   
""" 

a = 3
b = 5
op = "+"

print("%d %s %d = %d" % (a,op,b,a + b))


#문제5) 1~100중에서 짝수의 합, 홀수의 합을 각각 구하시오
even = 0  #짝수의 합
odd = 0   #홀수의 합

for i in range(1,101):
    if i % 2 == 0:
        even += i
    else:
        odd += i

#문제6) 운행거리에 따라 택시 요금을 계산하는 프로그램
#      2000m까지는 기본요금 900원이고
#      2000m초과 운행시 200m단위마다 기본요금에 100원씩 가산하여 요금을 계산한다
"""
    예1) 운행거리 1600 -> 기본 요금 900원

"""
import math

meter = 4500
basic = 900
result = 0

if meter > 2000:
    meter = meter - 2000
    a = math.ceil(meter / 200)
    result= basic + (a * 100)

else:
    result = basic

print(result)