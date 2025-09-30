
str = "Life is too short. You need Python"
print(str)

# 글자 갯수
print(len(str))

print(str.count("i"))
print(str.count("a"))
print(str.count("short"))
print(str.count("nice"))

print(str[3])
print(str[0])
print(str[-1])
print(str[-3])

#특정 글자나 단어가 마지막으로 등장하는 위치 조회
print(str.rfind("i"))
print(str.rfind("a")) # 찾고자 하는 문자열이 없을떄
print(str.rfind("short"))
print(str.rfind("nice"))

#특정 글자나 단어가 처음 등장하는 위치 조회
print(str.index("short"))
# print(str.index("nice"))

#특정 단어나 글자로 시작하는지 여부 검사(True,False)
print(str.startswith("L"))
print(str.startswith("l"))
print(str.startswith("Life"))
print(str.startswith("H"))
print(str.startswith("Hello"))

#특정 단어나 글자로 끝나는지 여부(True,False)
print(str.endswith("N"))
print(str.endswith("n"))
print(str.endswith("Python"))
print(str.endswith("python"))

print(str.upper())      #전부 대문자로 변경       LIFE IS TOO SHORT. YOU NEED PYTHON
print(str.lower())      #전부 소문자로 변경       life is too short. you need python
print(str.swapcase())   #대소문자 서로 바꿔서     lIFE IS TOO SHORT. yOU NEED pYTHON
print(str.capitalize()) #문장의 첫글자만 대문자로  Life is too short. you need python
print(str.title())      #각 단어의 첫글자 대문자   Life Is Too Short. You Need Python

#글자 치환 My height is too short. You need Python
print(str.replace("Life", "My height"))

#공백제거
k = "    py th on  "
print("#" + k.lstrip() + "#")  #py th on  #
print("#" + k.rstrip() + "#")  #    py th on#
print("#" + k.strip() + "#")   #py th on#

#문제) str변수의 문자열값에서 공백을 모두 제거하시오
print(str.replace(" ", ""))

print(len(""))
print(len(" "))

print(type(1))
print(type(0))
print(type(" "))
print(type(""))

#문자열의 인덱싱 - 특정 위치의 글자를 추출
print(str[0])   #0번째문자 인덱스(순서)는 0부터 시작
print(str[3])   #3번째문자
print(str[-3])  #문자열 뒤에서 부터 시작
print(str[-1])  #문자열 맨 마지막 글자

#문자열의 슬라이싱
print("#" + str[0:3] + "#")
print("#" + str[5:7] + "#")
print("#" + str[19:] + "#")
print("#" + str[:17] + "#")

print("#" + str + "#")        #Life is too short. You need Python#
print("#" + str[:] + "#")     #Life is too short. You need Python#
print("#" + str[19:-7] + "#") #You need#

a = ","
print(a.join("PYTHON"))        #P,Y,T,H,O,N

str.split() # list 컬렉션
##################################################

#문제)주민번호에서 문자열 추출
#       출력결과
#       -> 출생년도 : 1989년
#       -> 출생월 : 12월
#       -> 출생일 : 03일
#       -> 성별코드 : 2

jumin= "8912022"

myYear =  jumin[0:2]
myMonth = jumin[2:4]
myDate = jumin[4:6]
myCode = jumin[6:7]

if myCode == "1" or myCode =="2":
    myYear = "19" + myYear
elif myCode=="3" or myCode =="4":
    myYear = "20" + myYear

print("출생년도: %s년" % myYear)
print("출생월: %s년" % myMonth)
print("출생일: %s년" % myDate)
print("성별코드: %s년" % myCode)

if myCode == "1" or myCode =="3":
    print("남자")
elif myCode=="2" or myCode =="4":
    print("여자")

print(1=="1") #False

