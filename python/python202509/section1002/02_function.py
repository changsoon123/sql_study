# 02_function.py

# 참조 https://www.w3schools.com/python/python_functions.asp

# 1. Arguments와 Keyword Arguments
# -> Argument 전달값, 보내는 값
# -> Parameter 매개변수, 받는값
# -> 함수 선언시 파라미터의 수를 특정할 수 없을 경우 사용
# -> keyword arguments의 경우 아규먼트로 함수 호출 시 키워드를 작성하여 호출
# -> arguments는 튜플 타입
# -> keyword arguments는 딕셔너리 타입


## 1) Arguments, *args
def test1(fname, lname):
    print(fname + " " + lname)

test1("손", "흥민")
#test1("김") 에러


def test2(*names):
    print(names)
    print(type(names))         # 튜플
    print(len(names))          #3
    print(names[len(names)-1]) #맨 마지막 요소값 출력
    
test2("개나리", "진달래", "무궁화", "라일락", "코리아")


## 2) Keyword Arguments, **kwargs
def test3(**phones):
    print(phones)
    print(type(phones))
    print(phones["phone3"])

test3(phone1="123", phone2="456", phone3="789")


## 3) *args와 **kwargs
def hap(*args, **kwargs):
    print(type(args), args)      #<class 'tuple'> (1, 2, 3, 4)
    print(type(kwargs), kwargs)  #<class 'dict'> {'num1': 5, 'num2': 6}
    return sum(args) + sum(list(kwargs.values()))

print(hap(1, 2, 3, 4, num1=5, num2=6)) #21


## 4) list타입 데이터를 args로 호출하는 방법
def gop(n1, n2, n3):
    return n1 * n2 * n3

ls = [2, 3, 4]
print(gop(ls[0], ls[1], ls[2])) #24
print(gop(*ls))                 #24

# 주의사항 : list요소의 갯수와 파라미터의 갯수가 일치해야 함
ls2 = [2, 3, 4, 5]
#gop(*ls2) 에러



def hap2(*args):
    return sum(args)

ls3 = [3, 4, 5, 6]
print(hap2(*ls3)) #18
#hap2(ls3) 에러
