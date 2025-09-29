
# 성적 프로그램
name = "손흥민"
kor = 100
eng = 100
mat = 100
aver=(kor+eng+mat)//3

print("이름 : %s" % name)
print("국어 : %d" % kor)
print("영어 : %d" % eng)
print("수학 : %d" % mat)
print("평균 : %d" % aver)

#문제1) 평균이 95점 이상이면 장학생 출력

if aver>=95:
    print("장학생 %s 님" % name)

#문제2) 국어점수가 70점 이상이면 국어:합격 아니면:불합격

if kor>=70:
    print("합격 %s 님" % name)
else:
    print("불합격 %s" % name)

#문제3) 수학점수 90점 이상이면 수학:A학점
#              80점 이상이면 수학:B학점
#              70점 이상이면 수학:C학점
#              60점 이상이면 수학:D학점
#              아니면 수학:F학점

if mat>=90:
    print("수학 A학점")
elif mat>=80:
    print("수학 B학점")
elif mat>=70:
    print("수학 C학점")
elif mat>=60:
    print("수학 D학점")
else:
    print("수학 F학점")


#문제4) 과락
#       평균이 70점이상이면 결과:합격
#       (단, 국영수 세과목 중에서 한과목이라도 40점미만이면 결과:재시험)
#       평균이 70점미만이면 결과:불합격

if aver>=70:
    if kor < 40 or mat < 40 or eng < 40:
        print("재시험")
    else:
        print("합격")
else:
    print("불합격")


## 2) and 조건

if aver>=70:
    if kor >= 40 and mat >= 40 and eng >=40:
        print("합격")
    else:
        print("재시험")
else:
    print("불합격")
