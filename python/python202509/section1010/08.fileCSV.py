
# .csv : 데이터가 , 기호를 기준으로 구성된 파일

grade = [
         {"name":"홍길동", "kor":10, "eng":40},
          {"name":"무궁화", "kor":20, "eng":60},
          {"name":"라일락", "kor":30, "eng":90}

]

style = "{0}, {1}, {2}\n"

# 1) CSV 파일 쓰기
# -> CSV 파일 저장을 위한 f객체 생성
# ->Excel : csv는 euc-kr형식

# with open("grade.csv", "w", encoding="utf-8") as f:
#     f.write("이름 국어 영어 수학\n")
#     for item in grade:
#         tmp = style.format(item["name"],item["kor"],item["eng"])
#         f.write(tmp)

# print("grade.csv 파일 생성 완료")

import numpy

with open("grade.csv", "r", encoding="utf-8") as f:
    data = f.readlines() # list 형태로 가져옴
    print(data)

print(type(data)) # list

print("행의 개수 : %d "  % len(data))

for item in data:
    item = item.strip()  # 먼저 줄 끝 공백 제거
    fields = item.split(",")  # 쉼표로 분리

    name = fields[0]
    score1 = int(fields[1])
    score2 = int(fields[2])

    total = score1 + score2
    avg = numpy.average([score1, score2])

    print("%s %d %d %d %.2f" % (name, score1, score2, total, avg))