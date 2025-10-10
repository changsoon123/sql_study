# 05_constructor.py
# 생성자와 소멸자

# 1. 생성자 함수 Constructor 
# -> 생성자 함수는 클래스를 이용해서 객체를 생성할 때 사용한다
# -> 클래스명과 동일한 함수이름으로 호출한다

## 1) 매개변수가 없는 생성자 함수
class Member:
    uname = None
    email = None
    
    #생성자 함수. init 앞뒤로 언더라인 2개
    #객체 생성할 때 Member()라는 이름으로 호출된다
    #기본 생성자 함수 default constructor
    def __init__(self):
        #pass 함수안에 내용이 아무것도 없을때
        print("Member() 생성자 함수 호출됨...")
        self.uname = "손흥민"
        self.email = "son@itwill.com"

    def disp(self):
        style="이름:{0} / 이메일:{1}"
        print(style.format(self.uname, self.email)) 

# Member() : 객체가 생성되면서 생성자 함수(__init__)가 호출된다
mem1 = Member()
mem1.disp()

mem2 = Member()
mem2.disp()


## 2) 매개변수가 있는 생성자 함수
class User:
    uname = None
    email = None
    
    def __init__(self, uname, email):
        print("매개변수가 있는 User() 생성자 함수 호출됨...")
        self.uname = uname
        self.email = email

    def disp(self):
        style="이름:{0} / 이메일:{1}"
        print(style.format(self.uname, self.email)) 


user1 = User("개나리", "nari@itwill.com") #객체 초기값 설정
user1.disp()

user2 = User("진달래", "jin@itwill.com")
user2.disp()
#################################################


# 2. 소멸자 함수 Destructor
# -> 메모리에서 객체가 소멸될때 자동으로 호출되는 함수
class Student:
    uname = None
    email = None
    
    def __init__(self, uname, email):
        print("매개변수가 있는 Student() 생성자 함수 호출됨...")
        self.uname = uname
        self.email = email

    def disp(self):
        style="이름:{0} / 이메일:{1}"
        print(style.format(self.uname, self.email)) 

    def __del__(self):
        print("소멸자 함수 호출됨...")

stu1 = Student("라일락", "ra@itwill.com")
stu1.disp()

stu2 = Student("무궁화", "mu@itwill.com")
del stu2 #stu2 객체 강제 삭제
#stu2.disp() 에러

