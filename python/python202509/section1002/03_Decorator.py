# 03_decorator.py

# 참조 https://www.w3schools.com/python/python_decorators.asp

# 2. Decorators
# -> 함수의 코드를 변경하지 않고도 함수에 추가 동작을 추가할 수 있다
# -> 다른 기능을 입력으로 받아 새로운 기능을 반환하는 기능
# -> 선언) @함수이름


## 1) 함수안에 함수가 선언되는 경우 (inner function)
## -> 함수를 지역영역에 선언
## -> 함수 안에 함수

def outer(a, b):
    def inner(c, d):
        return c + d
    return inner(a, b)

print(outer(1, 2)) #3
#inner(1, 2) 에러


## 외부에서 inner function 접근
def outer2(a, b):
    def inner(c, d):
        return c + d
    return inner

print(outer2(1, 2))        #결과값 안나옴 <function outer2.<locals>.inner at 0x0000026FB79245E0>
print(outer2(1, 2)(3, 4))  #outer2(1, 2) -> outer2함수 호출
                           #(3, 4)       -> inner(3, 4) 호출 
                           #7

print(outer2(100, 200)(-3, -4)) #-7


## 2) @decorator_name
def changecase(func): #함수이름 func=myfunction 전달됨
    def myinner():
        print("start...")
        res = func().upper() # myfunction()호출되면 "Hello Python"리턴되고, 대문자 변환
        print(res) 
        print("end...")
        return res  #HELLO PYTHON
    return myinner


@changecase
def myfunction():
    return "Hello Python"

myfunction() #start...
             #HELLO PYTHON
             #end...


## 예제) password가 일치하면 연산이 가능하고, 그렇지 않으면 로그인실패 출력하는 decorator 함수만들기
def check_pw(func): # func=hap 전달됨
    def wrapper(*args, **kwargs):
        pw = "itwill"
        login = input("비밀번호 입력해 주세요 : ")
        if login == pw: return func(*args, **kwargs)
        return "로그인 실패"
    return wrapper


@check_pw
def hap(a, b):
    return a + b


print(hap(3, 4))