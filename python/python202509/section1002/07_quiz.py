# 07_quiz.py

# 문제) string타입 데이터를 입력 받았을 때 문자열 가운데를 출력하시오

#text = input("Type text : ")
#print(text)
#print(type(text)) #문자열 String


## 1) 글자갯수가 홀수일 때 : 예) korea  -> r
text = "korea"
print(text[2])      # r
print(len(text))    # 5
print(len(text)/2)  # 2.5
print(len(text)//2) # 2

pos = len(text)//2
print(text[pos])


## 2) 글자갯수가 짝수일 때: 예) itwill -> wi   
word = "itwill"
print(word[2:4])    # wi
print(len(word))    # 6
print(len(word)//2) # 3

pos = len(word)//2
print(word[pos-1:pos+1])
#################################################


# 문제풀이)
def center(word) :
    pos = len(word)//2
    if len(word)%2==1 :
        return word[pos]
    else:
        return word[pos-1:pos+1]


text = input("Type text : ")
print(text)
print(center(text)) #center함수 활용


# 삼항 연산자
# 형식) 값1 if 조건식 else 값2
#  -> 조건식이 True면 값1, 조건식이 False면 값2

# lambda 함수 활용
pos = len(text)//2
substr = lambda word : word[pos] if len(word)%2==1 else word[pos-1:pos+1]
print(substr(text))

