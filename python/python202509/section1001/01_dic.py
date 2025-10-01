
# 연속형 자료형
# Dictionary 딕셔너리
# -> 이름(key, name)과 값(value)의 쌍으로 데이터를 정의하는 구조
# -> 순서가 없다
# -> {"key":value, "key":value}

dic = {"name":"무궁화", "phone":"123-4567","birth":"20251001"}

print(dic)

print(dic["name"])
print(dic["phone"])
print(dic["birth"])

# 삭제
del(dic["birth"])
print(dic)

# 키가 중복될 경우 하나를 제외한 나머지는 무시됨
# -> 일반적으로 나중에 정의된 항목이 이전에 정의된 항목을 덮어 씀
data = {"msg":"Hello", "msg":"World", "msg":"Python"}
print(data)

rank = {0:"" , 30:"Java", 10:"Oracle"}
print(rank[0])
print(rank[30])
print(rank[10])

# 딕셔너리의 계층 구조
# -> 딕셔너리는 리스트나 다른 딕셔너리를 포함할 수 있다.
# -> 정보를 계층화해서 표현 가능하다

addr = ["서울","서초구","강남대로"]
grade = {"korean" : 10, "math" : 20, "english" : 30}
member = {
    "userid" : "Python",
    "age" : 20,
    "addr" : addr,
    "grade" : grade
}

print(member)

# 계층화된 값에 접근하기
print(member["addr"][0])
print(member["grade"]["korean"])


mydic = {
            "total" : 2025,
            "city"  : ["서울", "제주", "부산"],
            "population" : [100, 200, 300],
            "date"  : {'yy':2025, 'mm':8, 'dd':25}
        }

print(mydic)
print(mydic["city"][0])
print(mydic["population"][0])
print(mydic["date"]["yy"])

## 3) 리스트의 요소가 딕셔너리가 되는 경우 -> 표 자료형
grade = [ 
          {"name":"홍길동", "kor":10, "eng":40},
          {"name":"무궁화", "kor":20, "eng":60},
          {"name":"라일락", "kor":30, "eng":90}
        ]

style = "{0}의 국어점수:{1}, 영어점수:{2}"
print(style.format(grade[0]["name"],grade[0]["kor"],grade[0]["eng"]))
print(style.format(grade[1]["name"],grade[1]["kor"],grade[1]["eng"]))
print(style.format(grade[2]["name"],grade[2]["kor"],grade[2]["eng"]))

#################################################################

# 딕셔너리 관련 함수

dic = {"name":"무궁화", "phone":"123-4567","birth":"20251001"}
print(dic)

# 특정 key에 대응하는 값 얻기
# -> dic["name"] 과 동일

print(dic["name"])
print(dic.get("name"))

# 존재하지 않는 key에 접근하는 경우
# print(dic["age"])

print(dic.get("age")) #None

dic["addr"] = "Seoul"
print(dic["addr"])
print(dic)

# get 함수는 전달하는 key가 존재하지 않을 경우
# 대신 반환될 값을 함께 설정할 수 있다.
print(dic.get("age",25))

keys = dic.keys()
print(keys)

# keys를 list 변환
key_list = list(keys)
print(key_list)
print(key_list[1])

# value만 모아서 values라는 객체로 변환
values = dic.values()
print(values)

# values를 list로 변환
values_list = list(values)
print(values_list)
print(values_list[1])

# items 를 사용하면 딕셔너리를 리스트 안에 튜플 형태로 반환
items = dic.items()
print(items)

items_list = list(items)
print(items_list)
print(items_list[1])


