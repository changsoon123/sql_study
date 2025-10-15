

print("상수와 변수")

"""
    데이터 타입 Data Type
    - 숫자형 : 정수(Integer), 실수(Float)
    - 문자형 : ''또는 ""로 감싼다
    - 날짜형 : 년월일시분초
    - 논리형 : boolean, 참(True) 또는 거짓(False)
    - 연속형 데이터 :  리스트, 딕셔너리, 튜플, 데이터프레임, 시리즈
"""

# 1. 숫자형
print(123) # 양의 정수

print(-456) # 음의 정수

print(1.3) # 실수

print(-2.4)  

print(5.) # 실수

print(6.0) # 실수

# 2. 문자형
print('Korea')
print("Seoul")
print('1004')

# 3. 논리형
print(True)
print(False)
print("True") #문자형
print("False") #문자형
###########################################################

# 1) 상수 Constant
# -> 절대 변하지 않는 고정 불변의 값
print(3)
print(1.2)
print('A')
print("가")
print(True)

# 2) 변수 Variable
# -> 변하는 값
# -> 대입(저장)연산자 = 

"""
    식별자 : 변수명, 함수명, 클래스명, 모듈명
    식별자 작성규칙 : 
    ->의미를 부여해서 영문자, 숫자등을 조합해서 작성한다
    ->한글변수명, 첫글자로 숫자, 예약어는 사용불가

"""

a = 3
b = 1.2

print(a)

print(b)

print(a + b)

print(a - b)

print("a") # 문자형

print("b") # 문자형

a = 5
b = 3.4
print(a)
print(b)
##################################################

print("-" * 30)

# 성적 프로그램
name = "손흥민"
kor = 80
eng = 85
mat = 100

print(name) 
print(kor)
print(eng)
print(mat)

# 총점 구하기
total = kor + eng + mat

# 평균 구하기
aver = total / 3

print(total)
print(aver)