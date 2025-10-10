 

"""
    클래스 상속 inheritance
    - 재활용
	- 부모와 자식, 조상과 후손(파생), super와 sub
    - 클래스가 가지고 있는 멤버나 메소드를 상속받는 클래스가 모두 사용
    - 형식) class 자식클래스(부모클래스)
"""

class AA:
    def one(self):
        print("AA.one()...")
    def two(self):
        print("BB.two()...")

class BB(AA):
    pass #함수내에 내용이 없을때

aa = AA()
aa.one()
aa.one()

bb = BB()
bb.one()
bb.two()

class CC(AA):
    def three(self):
        print("CC.three()...")

class DD(CC):
    def four(self):
        print("DD.four()...")

cc = CC()
cc.one()
cc.one()
cc.three()

dd = DD()
dd.one()
dd.two()
dd.three()
dd.four()

# 2. 다중 상속
# -> 형식) class 자식클래스(부모클래스, 부모클래스)

class Plus:
    def hap(self, a, b):
        return a + b
    
class Subs:
    def minus(self, a, b):
        return a - b
    
class Calc(Plus, Subs):
    pass

calc = Calc()
print(calc.hap(3,4))
print(calc.minus(3,4))

#####################################################

# 3. 오버라이딩(overriding)

"""
- 상속받은 부모 클래스의 메서드를 자식 클래스에서 재정의해서 사용하는 것
    - 부모 클래스에 이미 정의된 메서드가 있음
    - 자식 클래스에서 같은 이름의 메서드를 다시 정의하면 부모의 메서드 대신 자식 클래스의 메서드가 실행됨

"""

class Korea:
    name = "코리아"

    def view(self):
        print("Korea.view()...")

    def disp(self):
        print("Korea.disp()..." + self.name)

class Seoul(Korea):
    name = "서울 특별시"

    def disp(self):
        print("Seoul.disp()..." + self.name)


se = Seoul()
se.view()
se.disp()

# 4.super()
# -> 부모클래스에서 사용된 함수의 코드를 받아서, 자식클래스에서 재사용시 사용

class Phone:
    name = None
    # 생성자 함수 Constructor
    def __init__(self, function=None):
        self.name = function
        print("{} phone {}개통".format(self.name,123))

    def calling(self):
        print("---", self.name)
        print("phone dial selected")

ph = Phone()
ph.calling()

class CameraPhone(Phone):
    def __init__(self, nm=None):
        super().__init__(nm)

    def camera(self):
        print("---", self.name)
        print("camera selected")

cam = CameraPhone("카메라")
cam.calling()
cam.camera()

################################################

# 5. overloading
# -> 같은 이름의 메소드(함수) 를 매개변수의 개수나 타입에 따라 다르게 동작하도록 정의하는 것.
# -> 기본적으로 메소드 오버로딩을 지원하지 않습니다.

class Compute:
    def hap(self, a):
        return a
    
    def hap(self, a, b):
        return a+ b
    
    def hap(self, a, b, c):
        return a + b + c
    
compute = Compute()
print(compute.hap(1))

