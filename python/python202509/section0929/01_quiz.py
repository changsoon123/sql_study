#문제1) 임의의 정수가 짝수(2의 배수)인지 확인하시오

test1 = 2
test2 = 3

print("짝수" if test1 % 2 == 0 else "홀수")
print("짝수" if test2 % 2 == 0 else "홀수")

#문제2) 임의의 정수가 3의 배수인지 확인하시오

print("3의 배수" if test1 % 3 == 0 else "3의 배수가 아니다.")
print("3의 배수" if test2 % 3 == 0 else "3의 배수가 아니다.")

#문제3) 해당 년도가 윤년인지 확인하시오

print("윤년" if (test1 % 4 == 0 and test1 % 100 != 0 or test1 % 400 == 0) else "윤년이 아니다.")
print("윤년" if (test2 % 4 == 0 and test2 % 100 != 0 or test2 % 400 == 0) else "윤년이 아니다.")


#문제4) 지폐의 갯수를 구하시오
"""
      만원 5장
      천원 4장
      백원 3장
      십원 2장 
"""
money = 54320
print("만원 %d 장" % (money // 10000))
money = money % 10000
print("천원 %d 장" % (money // 1000))
money = money % 1000
print("백원 %d 장" % (money // 100))
money = money % 100
print("십원 %d 장" % (money // 10))

#문제5) 임의의 정수가 2의 배수이면서 5의 배수인지 확인하시오

print("2의 배수 및 5의 배수" if (test1 % 2 == 0 and test1 % 5 == 0)else "2의 배수와 5의 배수가 아니다.")
print("2의 배수 및 5의 배수" if (test2 % 2 == 0 and test2 % 5 == 0) else "2의 배수와 5의 배수가 아니다.")

#문제6) 임의의 정수가 1이거나 3인지 확인하시오.

print("1 or 3" if (test1 == 1 or test1 == 3)else "1 or 3 이 아니다.")
print("1 or 3" if (test2 == 1 or test2 == 3) else "1 or 3 이 아니다.")

#문제7) 국어 점수가 80 ~ 89점 사이인지 확인하시오.

print("80~89 사이의 값 입니다." if 80 <= test1 < 90  else "80~89 사이의 값이 아니다.")
print("80~89 사이의 값 입니다." if 80 <= test2 < 90 else "80~89 사이의 값이 아니다.")