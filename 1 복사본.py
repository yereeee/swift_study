a = int(input())
b = int(input())
c = int(input())

A = str(a*b*c)
ans = []
for i in range(len(A)):
    ans.append(A[i])

"""
ans = list(str(a*b*c))로 쓰면 for문을 안써도 배열을 만들 수 있음
"""

for i in range(0, 10):
    print(ans.count(str(i)), sep='')