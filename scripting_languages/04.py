import re
from collections import Counter

with open('04.txt') as f:
    text = re.sub(r'[^a-zA-Z]', '', f.read())

cnt = Counter(list(text))

for letter, count in cnt.most_common(len(cnt)):
    print("{}: {:.2%}".format(letter, count / len(text)))
