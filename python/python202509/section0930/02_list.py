
# [컬렉션]
# - 연속형 자료형
# - 하나의 변수에 여러개의 값을 저장하는 형태
# - List, Tuple, Dictionary, Set, DataFrame, Series
# - Element, 요소, 원소
# - Index, 색인, 순서 (대부분 0부터 시작해서 1씩 증가한다)
# - DataFrame + Series 은 pandas 모듈 설치해야 함
#   명령프롬프트 >pip install pandas


# 1. List
## 1) 1차원 리스트
grade = [90,85,73,64,100]

print(grade)
print(type(grade))

print(grade[0])
print(grade[1])
print(grade[2])
print(grade[3])
print(grade[4])


print(len(grade))

for idx in range(len(grade)):
    print(grade[idx])

names = ["홍길동", "무궁화", "개나리", "진달래", "라일락"]

for idx in range(len(names)):
    print(names[idx])

num = [5,8,-1,9,-6]
size = len(num)

#문제1) 음수의 갯수를 구하시오 
result = []

for idx in range(len(num)):
    if num[idx] < 0:
        result.append(num[idx])

print(len(result))

#문제2) 양수중에서 홀수의 합을 구하시오
result1 = []
sum = 0
for idx in range(len(num)):
    if num[idx] > 0:
        result1.append(num[idx])

for idx2 in range(len(result1)):
    if result1[idx2] % 2 == 1:   
        sum += result1[idx2]

print(sum)

#문제3) num[4]의 등수를 구하시오
check = len(num)
for idx in range(len(num)):
    if num[idx] < num[4]:
        check -= 1

print(check)

########################################

# 2) 2차원 리스트
## -> 행(row)과 열(Colume)로 구성
students = [
    ["홍길동", 20],
    ["호호호", 30],
    ["기기기", 4]
] #3행 2열

students2 = [
    ["afsdfsd", 13],
    ["afdsasfd", 14]
],[ 
    ["asdfasdafsdf", 15],
    ["asdfasdafasfdafsdfsad", 16],
    ]

print(students)

print(students[0])
print(students[1])
print(students[2])
# print(students[3])

print(students[0][0])

print(students2)
print(students2[0])
print(students2[1])
print(students2[1][0])
print(students2[0][0])

print(len(students))
print(len(students[0]))

row = len(students)
for r in range(row):
    col = len(students[r])
    for c in range(col):
        print(students[r][c])

# 에러 IndexError: list index out of range
# print(students[3][3]) 3행 3열은 존재하지 않음

## 3) 리스트 관련 함수
## -> 리스트의 인덱싱, 슬라이싱

mylist = [10,20,30,40,50]

for m in mylist:
    print(m)

print(mylist[1:3])
print(mylist[1:-2])

mylist.append(60)    #맨뒤 요소 추가    
mylist.insert(1, 30) #1번째 요소로 30 삽입
print(mylist)
print(mylist.count(30))  #30값의 갯수
mylist.pop()             #마지막 요소 삭제

x = mylist.index(30) # 처음으로 찾은 30의 인덱스
print(x) 
mylist.remove(30) # 처음으로 찾은 30 인덱스 삭제
print(mylist)

score = [9,3,5,1,7]

score.sort() # 정렬 아스키 코드 순 1->9 A->Z , a -> z
print(score)
score.sort(reverse=True) #DESC
print(score)

str = "Gone,With,The,Wind"
word = str.split(",") #[] 리스트 형태로 word 변수에 할당
print(type(word))

for w in word:
    print(w)

