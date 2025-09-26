
# -> 출력서식

print("Seoul")
print("\n") # 줄바꿈
print("Jeju")
print("\n\n\n")
print("@\t@") # 탭 @    @
print("\\")   # 단순기호 \
print("\"\"") # ""
print("\'\'") # '
print("''") # '
print('""') # ""
####################################################

print("-" * 30)

"""
    %d : 정수
    %f : 실수
    %s : 문자

"""

print("나이 :  %d" % 25)
print("키 : %f" % 178.9 )
print("이름 : %s" % "손흥민")

print("%d년 %d월 %d일" % (2025, 9, 26))

#####################################################
print("-" * 30)

print("@%d@" % 123)   #@123@
print("@%5d@" % 123)  #@  123@
print("@%-5d@" % 123) #@123  @
print("@%05d@" % 123) #@00123@
print("@%0.5d@" % 123) #@00123@

print("-" * 30)
money = 123.456789
print("@%f@" % money) #@123.456789@
print("@%10.3f@" % money) #@    123.457@
print("@%-10.3f@" % money) #@123.457    @
print("@%.3f@" % money) #@123.457@

print("-" * 30)
print("@%s@" % "KOREA")
print("@%10s@" % "KOREA")
print("@%-10s@" % "KOREA")

#####################################################
print("-" * 30)

# 성적 프로그램
name = "손흥민"
kor = 80
eng = 85
mat = 100

total = kor + eng + mat
aver = total / 3

print("이름 : %s" % name)
print("국어 : %d" % kor)
print("영어 : %d" % eng)
print("수학 : %d" % mat)
print("총점 : %d" % total)
print("평균 : %.2f" % aver)

#####################################################
print("-" * 30)

#출력서식을 재활용할 수 있다.
str = "%s날짜는 %d년 %d월 %d일 입니다."
msg1 = str % ("정모", 2025, 9, 26)
print(msg1)

msg2 = str % ("번개", 2025, 10, 26)
print(msg2)

#####################################################
print("-" * 30)

# format() 함수

msg1 = "I eat {0} apples" # 0번째
print(msg1.format(3))

msg2 = "{0}는 {1}년 {2}월 {3}일 입니다."
print(msg2.format("크리스마스", 2025, 12, 25))

msg3 = "{}는 {}년 {}월 {}일 입니다."
print(msg3.format("크리스마스", 2025, 12, 25))

msg4 = "{name}는 {yy}년 {mm}월 {dd}일 입니다."
print(msg4.format(name="크리스마스", yy=2025, mm=12, dd=25))

