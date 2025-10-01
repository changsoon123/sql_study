
# 시스템의 현재 날짜 정보 조회하기

import datetime as DT

# 현재 날짜 정보 가져오기

today = DT.datetime.now()
print(today.year)
print(today.month)
print(today.day)
print(today.hour)
print(today.minute)
print(today.second)
print(today.microsecond)
print(today)

# 요일 반환
print(today.weekday())

# 요일 이름 출력
days = ("월","화","수","목","금","토","일")

print(days[today.weekday()])

# 출력 형식 만들기
print(today.strftime("%y/%m/%d %H:%M:%S"))
print(today.strftime("%Y/%m/%d %H:%M:%S %a %A %p"))



