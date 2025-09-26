

# 문제) 지폐의 갯수를 구하시오
money = 54320
"""
    만원 5 장
    천원 4 장
    백원 3 장
    십원 2 장

"""
print("만원 %d 장" % (money // 10000))
money = money % 10000
print("천원 %d 장" % (money // 1000))
money = money % 1000
print("백원 %d 장" % (money // 100))
money = money % 100
print("십원 %d 장" % (money // 10))



