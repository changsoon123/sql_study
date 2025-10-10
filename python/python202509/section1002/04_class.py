# 04_class.py

# 참조
# https://www.w3schools.com/python/python_oop.asp
# https://www.w3schools.com/python/python_classes.asp

# 객체 지향 프로그램 (Object Oriented Progarm)
# 클래스(class, 사용자 정의 자료형)와 객체(Object)
# 클래스명의 첫글자 대부분 대문자로 한다
"""
    class 클래스명:
        멤버변수     
        멤버함수()
"""

# 1) 클래스 선언
class Member:
    userid = "python"
    email  = "webmaster@itwill.com"
    phone  = "0269017010"

a = 3 # a는 변수

# Member() 생성자 함수(Constructor)
# -> 클래스명과 동일한 함수
mem1 = Member() # mem1 -> 객체(Object) 선언

# . 연산자를 이용해서 멤버에 접근한다
# 객체명.멤버
print(mem1.userid)
print(mem1.email)
print(mem1.phone)

mem2 = Member() #객체선언
print(mem2.userid)
print(mem2.email)
print(mem2.phone)


# 2) 멤버함수를 포함하는 클래스 정의
# ->클래스내에 선언된 함수(멤버함수)들은
# ->반드시 첫번째 파라미터 self를 정의해야 한다
class Calc:
    def plus(self, x, y):
        return x + y
    
    def minus(self, x, y):
        return x - y
    
    def all(self, x, y):
        a = self.plus(x, y)  #자신의 클래스안에서 자신의 멤버함수를 호출하는 경우 self.멤버함수()
        b = self.minus(x, y)
        return a, b  #튜플로 묶어서 여러개의 값을 한번에 리턴
    

calc = Calc() #객체 선언
print(calc.plus(2, 4))  #6
print(calc.minus(3, 5)) #-2
print(calc.all(6, 8))   #(14, -2) 튜플형 반환

x = calc.all(6, 8)
print(x)
print(x[0])
print(x[1])

i, j = calc.all(6, 8)
print(i) #14
print(j) #-2


# 3) 멤버변수(field, column)와 멤버함수(method)를 모두 내장하는 클래스 정의
class User:
    # 멤버변수의 유효범위(Scope)는 클래스내부에서는 모두 접근가능하다
    username = ""
    email = ""

    def join(self, username, email): #매개변수(parameter)와 멤버변수는 이름이 동일해도 된다
        self.username = username     #self.멤버변수=매개변수
        self.email    = email

    def disp(self):
        print(self.username)
        print(self.email)


# 객체선언
user1 = User()
user1.join("Python", "user1@itwill.com")
user1.disp()

user2 = User()
user2.join("Oracle", "user2@itwill.com")
user2.disp()
#################################################


# 4) 성적 클래스
class Sungjuk:
    # 멤버변수
    uname = ""
    kor  = 0
    eng  = 0
    mat  = 0
    aver = 0

    # 멤버함수
    def init(self, u, k, e, m): #이름, 국, 영, 수 값를 전달받는 함수
        self.uname = u
        self.kor = k
        self.eng = e
        self.mat = m
        self.aver = (k+e+m)/3

    def disp(self): #출력함수
        print("%s %d %d %d %.2f" % (self.uname, self.kor, self.eng, self.mat, self.aver)) 


stu1 = Sungjuk()
stu1.init("손흥민", 90, 85, 90)
stu1.disp()

stu2 = Sungjuk()
stu2.init("김연아", 50, 40, 60)
stu2.disp()

stu3 = Sungjuk()
stu3.init("박지성", 75, 85, 95)
stu3.disp()