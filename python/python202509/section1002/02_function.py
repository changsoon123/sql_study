
# 1. Arguments와 Keyword Arguments
# -> Argument 전달값, 보내는 값
# -> Parameter 받는값
# -> 함수 선언시 파라미터의 수를 특정할 수 없을 경우 사용
# -> keyword arguments의 경우 아규먼트로 함수 호출 시 키워드를 작성하여 호출
# -> arguments는 튜플 타입
# -> keyword arguments는 딕셔너리 타입

## 1) Arguments, *args

def test1(fname, lname):
    print(fname + " " + lname)

test1("손", "흥민")

def test2(ggg,gggg,gasdfggg):
    print("ㄻㅇㄴㅁㄴㄹㅇㅁㄹㄴㅇ")

def test2(*names):
    print(names)

def test2(ggg,gggg,gasdfggg):
    print("dddd")


test2("개나리", "진달래", "무궁화")
# test2("개나리", "진달래") 결국 오버로딩이 안됨.

## 2) Keyword Arguments, **kwargs

def test3(**kwargs):
    print(kwargs)
    print(type(kwargs))


test3(phone="", phone2="", phone3="")

## 3) *args, **kwargs
import numpy as np

def hap(*args, **kwargs):
    print(args, kwargs) # (1, 2, 3, 4, 5, 6) {'num1': 5, 'num2': 6}
    print(sum(args) + sum(list(kwargs.values())))

hap(1, 2, 3, 4, 5, 6, num1=5, num2=6)

## 4) list타입 데이터를 args로 호출하는 방법

def gop(n1, n2, n3):
    return n1 * n2 * n3

ls = [2,3,4]
print(gop(ls[0], ls[1], ls[2]))
print(gop(*ls))

ls2 = [2, 3, 4, 5]
# gop(*ls2) 에러, 개수가 맞지 않음

def hap2(*args):
    return sum(args)

ls3 = [3,4,5,6]
print(hap2(*ls3))
#hap2(ls3) 에러