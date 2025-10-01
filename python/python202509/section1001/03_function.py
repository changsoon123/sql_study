
# 함수, function, method
# test -> 변수
# test() -> 함수

# 함수선언형식) def 함수이름():

data = [1,4,5,7,2]
print(data)

k = sorted(data)
print(k)

# -> 자주 사용하는 명령어들을 그룹화하여 코드를 재사용하는 기법
#   -> 함수를 정의하는 것 만으로는 아무런 동작도 하지 않는다

# 1) 매개변수가 없는 경우
def say_hello():
    print("Hello Python")
    print("안녕 파이썬")

say_hello()

# 함수 호출 -> 정의한 함수는 호출되어야만 실행된다.

# parameter(매개변수)를 갖는 함수 정의
# -> 함수가 실행되는데 필요한 조건값
# -> 필요한 조건값을 함수이름 옆의 괄호안에 명시

def test1(x): # x는 매개변수
    # print(x)
    y = x + 1
    style = "test1({0}) => {0} + 1 = {1}"
    print(style.format(x,y))
    
test1(3) # 3 -> 전달값(argument value)
test1(5)
test1(7)

## 매개변수가 2개 이상인 경우
## -> 여러개의 파라미터를 갖는 함수 정의
## -> 파라미터는 필요한 만큼 콤마로 구분하여 정의할 수 있다.
## -> 다른 함수와 이름이 중복되지 않도록 주의

def test2(x,y):
    z = x + y
    style = "test2({0} , {1}) => {0} + {1} = {2}"
    print(style.format(x,y,z))


test2(1,3)
test2(2,4)
test2(5,6)

## 매개변수에 초기값 설정하기

#def test3(x,y=0, z): <-에러. 뒤에서부터 설정 가능함. 이게 오버로딩
def test3(x,y,z=0):
    style = "test3({0} , {1} , {2}) => {0} + {1} + {2} = {3}"
    print(style.format(x,y,z, x+y+z))

test3(2,4,6) # 전달값이 세개 있는 경우
test3(7,8)

test3(y=100, x=300)

# 3) 리턴값 있는 경우
# -> 형식) return

def plus(x,y):
    z = x + y
    return z # z값을 호출한 시점으로 되돌려준다.


res = plus(1,3)
print(res)

res = plus(2,4)
print(res)

# 값, value -> 상수값, 변수값, 함수의 리턴값
# 리턴값을 갖는 함수는 그 결과를 직접 출력하거나 다른 연산에 활용할 수 있다
print(4) #상수값
b = 6
print(b) #변수값
print(plus(5,6))
print(abs(-3) + plus(10,20))


def minus(x):
    print(x)

minus(1)

def minus(*args):
    print("args")

# return문을 중간에 만나는 경우 그 즉시 호출시점으로 되돌아 간다.
def test4(x, y):
    if x < 10 or y < 10: return 0
    z = x + y
    return z

print(test4(100,300))
print(test4(5, 15))

#문제1) ★기호 100번 출력하기

def graph(x,y):
    while y < 101:
        print(x * y)
        y += 1

graph("★", 100)


#문제2) 해당 년도가 윤년 확인하는 함수

def leap(x):
    if x % 4 == 0 and x % 100 != 0 or x % 400 == 0:
        return True
    else:
        return False

if leap(2025):
    print("윤년")
else:
    print("평년")


#문제3) 팩토리얼값 구하기 4*3*2*1

def fact(x):
    i=0
    while x > 0:
        i *= x 
        x -= 1
    return i

res = fact(4)

print(res)


#문제4) 두 수사이의 차이를 구하는 함수 (절대값)

def diff(x,y):
    return abs(x-y)

# def diff(x,y):
#     if x < 0: 
#         if y< 0:
#             return abs(x-y)
#         return abs(x+y)
#     if y < 0:
#         if x < 0:
#             return abs(x-y)
#         return abs(x+y)
#     return abs(x - y)

res = diff(4, 7)

print(res)