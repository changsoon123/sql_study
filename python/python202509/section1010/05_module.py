
# import my_module

# 1)
# mem = my_module.Member("손흥민", "SON@ITWILL.COM")
# mem.disp()

# 2) 클래스가 정의된 모듈에 별칭 적용하기

# import my_module as user

# mem = user.Member("손흥민", "SON@ITWILL.COM")
# mem.disp()

from my_module import Member
mem = Member("손흥민", "SON@ITWILL.COM")
mem.disp()

