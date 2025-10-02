
# 참조
# https://www.w3schools.com/python/python_oop.asp
# https://www.w3schools.com/python/python_classes.asp

# 객체 지향 프로그램 (Object Oriented Progarm)
# 클래스(class, 사용자 정의 자료형)와 객체(Object)
# 클래스명의 첫 글자는 대부분 대문자로 한다.

class Member:
    userid = "python"
    email = "webmaster@itwill.com"
    phone = "029017010"


a = 3 

# Member() 생성자 함수(Constructor)
# -> 클래스명과 동일한 함수
mem1 = Member()

# . 연산자를 이용해서 멤버에 접근한다.
# 객체명.멤버

print(mem1.userid)
print(mem1.email)
print(mem1.phone)

mem2 = Member() # 객체선언
print(mem2.userid)
print(mem2.email)
print(mem2.phone)