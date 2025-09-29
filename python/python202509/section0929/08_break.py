
a = 1
while a<10:
    if a==5: break
    print(a)
    a += 1

# continue
# ->루프 블럭의 나머지 문장들을 실행하지 않고
# ->다음 루프로 직접 돌아가게 할 수 있다

b = 1
while b<10:
    b += 1
    if b==5: continue
    print(b)

# 이중 반복문
for a in range(3):
    print("KOREA")
    for b in range(2):
        print("SEOUL")

a = 1
while a<=2:
    print("PYTHON")
    a += 1
    b = 1
    while b<=3:
        print("JAVA")
        b += 1
    
for dan in range(2, 10):
    print("=== %d 단===" % dan)
    for i in range(1,10):
        print("%d * %d = %d" % (dan,i,dan*i))

list = ["ONE","TWO","THREE","FOUR","FIVE"] # 연속형 자료형
for word in list:
    print(word)
