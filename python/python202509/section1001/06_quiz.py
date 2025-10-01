
text = input("Type text : ")

if len(text) % 2!=0:
    print( text[len(text)//2] )
else:
    print( text[len(text)//2-1:len(text)//2+1] )


print(type(text))

# string타입 데이터를 입력 받았을 때 문자열 가운데를 출력하시오
# 예) korea -> r




