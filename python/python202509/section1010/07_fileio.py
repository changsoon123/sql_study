

# 파일 입출력
# -> r : 읽기
# -> w : 쓰기 
# -> a : 추가


# # 1 ) 파일 쓰기
# # -> 대상 파일이 없으면 생성된다 (create)
# f = open("helloworld.txt", "w", encoding="utf-8")
# f.write("Hello Python!!\n\n")
# f.write("안녕하세요\n\n")
# f.close()
# # f.write("") 에러

# print("helloworld.txt 완성!!")

# 2) 파일읽기
# -> 대상 파일이 존재하지 않으면 에러 발생
# f = open("hellowor.txt", "r", encoding="utf-8") 파일명 다를경우 에러
# f = open("helloworld.txt", "r", encoding="utf-8")
# data = f.read()
# print(data)
# f.close()

# 3) 추가 모드로 파일 객체 생성하기
# -> f.close()는 자동으로 수행함. 생략가능
# with open("helloworld.txt", "a", encoding="utf-8") as f:
#     for i in range(1,10):
#         f.write("%d >> " % i)
#         f.write("good")    
#         f.write("bad\n")    

with open("helloworld.txt", "r", encoding="utf-8") as f:
    # data = f.read() # 파일의 끝(End Of File)을 만날때 까지 한글자씩 가져오기
    # print(data)
    lines = f.readline() # 엔터를 기준으로 가져오기
    print(lines)

# print("행의 개수 : %d "  % len(data))
print("행의 개수 : %d "  % len(lines))

for item in lines:
    print("#" + item.strip() + "#")