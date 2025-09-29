
# Data Type (자료형) 조회
print(type(123))
print(type(4.5))
print(type('Hello'))
print(type(True))

print(type([1,2,3]))
print(type((2,4,5)))
print(type({"name", "ITWILL"}))

###################################################

# Datatype Conversion 형변환
# -> 형식 : (자료형) 값
x = 3
y = 4.5
z = (float)(x)
w = (int)(y)

print(x)
print(y)
print(z)
print(w)

print(type(x))
print(type(y))
print(type(z))
print(type(w))

####################################################

# == 과 is 연산의 차이
i = 100     #정수형
j = 100.    #실수형

print( i == j )
print( i is j )


