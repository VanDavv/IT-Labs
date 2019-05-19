import math

# x ** i = 2 ** (i * log(x, 2))

# a * x

tbl = [3] * 10
for i in range(10):
    pw = math.log(tbl[i], 2)
    pw2 = pw * i
    res = math.pow(2, pw2)
    print(i, res)

