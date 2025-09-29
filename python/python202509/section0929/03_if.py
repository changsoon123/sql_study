
# 제어문 : 프로그램의 흐름을 제어
# -> 조건문과 반복문

"""
파이선의 코딩블럭
      코딩블럭을 표시하기 위해 들여쓰기(Identation)를 사용한다
      일반적으로 들여쓰기에는 4개의 공백을 사용할 것을 권장하는데,
      동일한 블럭의 들여쓰기는 모두 동일한 수의 공백을 사용해야 한다
      주의할 점은 공백과 탭을 혼용해서 사용하지 말아야 한다
"""

"""
 if 조건문의 형식

      if 조건: 조건이 True일때 처리명령어


      if 조건:
                조건이 True일때 처리명령어
      else:
                조건이 False일때 처리명령어


      if 조건1:
                     조건1이 True일때 처리명령어
      elif 조건2:
                     조건2가 True일때 처리명령어
      elif 조건3:
                     조건3이 True일때 처리명령어
      else:
                     조건이 False일때 처리명령어

"""

#문제1) 절대값을 구하시오 (무조건 양수)
abs = -3

if abs<0:
    print("%d 절대값 : %d" % (abs, abs*-1))
else:
    print("%d 절대값 : %d" % (abs,abs))

#문제2) 임의의 값이 양수, 음수, 제로를 출력하시오
num = 0
if num>0:
    print("%d 는 양수입니다." % num)
elif num<0:
    print("%d 는 음수입니다." % num)
else:
    print("%d는 제로입니다." % num)


#문제3) 세개의 수중에서 최대값을 출력하시오
num1 = 11
num2 = 22
num3 = 33

if num1 > num2 :
    if num1 > num3 :
        print("num1 이 최대값입니다.")
    else:
        print("num3 이 최대값입니다.")
else:
    if num2 > num3 :
        print("num2 이 최대값입니다.")
    else:
        print("num3 이 최대값입니다.")


#문제4) 성별코드에 따라 나이와 성별을 출력하시오

myYear = 10
mycode = 3

## 나이 구하기
## -> 올해년도 - 태어난 년도

if mycode==1 or mycode==2:
    myYear = myYear + 1900
elif mycode==3 or mycode==4:
    myYear = myYear + 2000

myAge = 2025 - myYear

print("태어난 년도 : %d " % myYear)
print("나이 : %d " % myAge)

if mycode==1 or mycode==3:
    print('남자')
elif mycode==2 or mycode==4:
    print('여자')

if mycode%2==1:
    print('남자')
else:
    print('여자')

