import filecmp
import os
import sys
from os.path import isfile, join, getsize, isdir

if len(sys.argv) < 2:
    raise RuntimeError('Need to pass path as parameter')

path = sys.argv[1]

if not isdir(path):
    raise ValueError('Passed path is not a directory: {}'.format(path))

onlyfiles = [f for f in os.listdir(path) if isfile(join(path, f))]

duplicates = [
    (source, target)
    for i, source in enumerate(onlyfiles)
    for target in onlyfiles[i + 1:]
    if filecmp.cmp(join(path, source), join(path, target))
]

print('Duplicated:')
for source, target in duplicates:
    print("=====")
    print(source, '(', getsize(join(path, source)), ')')
    print(target, ' (', getsize(join(path, target)), ')')
    print("=====")
