
# 1. Scope 유효 범위

def test5():
    c = 1 + 3
    print(c)
    return

def test6():
    a = 1
    print(a)

# print(x) 선언한 위치가 밑

# 2. 전역 변수

x = 100

def exam1():
    print("exam1(): %d" % x)
def exam2():
    x = 200
    print("exam2(): %d" % x)
def exam3():
    global x #함수나 클래스안에서 global로 선언하면
             #밖에서 선언된 변수를 함수나 클래스 안에서 가공이 가능한 형태로 바뀐다
    x = 300
    print("exam3(): %d" % x)

print(x)
exam1()
exam2()
exam3() # 글로벌 선언으로 x 값 300으로 바뀜

print(x)
exam1()
exam2()

# 3. 재귀 함수

def fact(f):
    if f==0:
        return 1
    else:
        return f * fact(f-1)

print(fact(3))

# 4. callback 함수

def hap(a,b):
    return a+b

def gop(a,b):
    return a*b

def calc(함수,a,b):
    return 함수(a,b)

print(calc(hap, 3, 5))
print(calc(gop, 10, 30))

print("-"*30)    

# 5. lambda 함수
# -> 파라미터를 간단한 계산으로 리턴
# -> 메모리를 적게 사용하고 소멸한다
# -> 형식) lambda 파라미터 : return

print(hap(2,4))
sum = lambda a, b : a+b
print(sum(3,5))




