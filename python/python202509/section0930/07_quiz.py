
# 문제1) 1부터 출력하다가 5가 되면 출력을 멈추시오
a = 1
while True:
    print(a)
    a += 1
    if a==5: break

#문제2) 경로명, 파일명, 확장명을 각각 분리하여 변수에 저장하고 출력하시오
"""
    c:\myphoto
    helloworld
    jpg
"""

path = "c:\myphoto\helloworld.jpg"
pathName = ""
fileName = ""
extentionName = ""

pathResult = path.rfind("\\")
pathName = path[0:pathResult]
print(pathName)
fileResult = path.index(".")
fileName = path[pathResult+1:fileResult]
print(fileName)
extentionName = path[fileResult+1:]
print(extentionName)
          

#문제3) 다음식의 결과를 구하시오    
#->   1 - 2 + 3 - 4 + 5 ... + 100 =
sum = 0

for i in range(101):
    if i % 2 == 0:
        sum -= i
    else:
        sum += i


#문제4) x값이 10으로부터 x를 여러 번 뺀후
#      결과가 음수가 되면 x를 몇번 뺐는가를 구하시오

"""
    10 - 3 = 7
    7 - 3 = 4
    4 - 3 = 1
"""
y = 10
x = 3 
count = 0

while True:
    if y < 0: break
    y -= x
    count += 1 

print(count)

#문제5) 3의 배수의 누적 합이 100이 넘어가려면
#      3부터 어디까지 더해야 하는지 구하시오
# 

count = 0
x = 3

while True:
    if x > 100: break
    x += x
    count += 1

print(count)