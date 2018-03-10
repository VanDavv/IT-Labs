import sys


def is_equal(left, right):
    if len(left) != len(right):
        return False

    for left_elem in left:
        if left_elem not in right:
            return False

    return True


def is_placeable(current, new):
    for elem in current:
        # check X and Y axis
        if elem[0] == new[0] or elem[1] == new[1]:
            return False
        # check cross
        if abs(elem[0] - new[0]) == abs(elem[1] - new[1]):
            return False

    return True


def is_result(current, size):
    if len(current) != size:
        return False

    for key, item in enumerate(current):
        if not is_placeable(current[key+1:], item):
            return False

    return True

def contains(array, elem):
    return True in map(lambda x: is_equal(x, elem), array)


def get_children(current, size, closed):
    children = []
    for row in range(size):
        for col in range(size):
            if is_placeable(current, (row, col)) and not contains(closed, (row, col)):
                children.append(current + [(row, col)])
    return children


if __name__ == '__main__':
    assert is_equal([(1, 2), (3, 5)], [(1, 2), (3, 5)])
    assert is_equal([(1, 2), (3, 5)], [(3, 5), (1, 2)])
    assert not is_equal([(1, 3), (3, 5)], [(3, 5), (1, 2)])
    assert is_placeable([], (1, 2))
    assert is_placeable([(1, 2), (3, 1)], (4, 3))
    assert not is_placeable([(1, 2), (3, 1)], (2, 2))
    assert is_result([(1, 2), (3, 1), (4, 3), (2, 4)], 4)
    assert is_result([(2, 1), (4, 2), (1, 3), (3, 4)], 4)
    assert not is_result([(2, 1), (4, 2), (1, 3), (3, 3)], 4)

    size = int(sys.argv[1])
    n = int(sys.argv[2])
    opened = get_children([], size, [])
    closed = []
    results = []
    while len(opened) > 0:
        open = opened.pop(0)
        if len(open) == n:
            if is_result(open, n):
                if contains(results, open):
                    continue
                else:
                    print('Found at {} closed'.format(len(closed)))
                    results.append(open)
            else:
                continue

        for child in get_children(open, size, closed):
            opened.append(child)
        closed.append(open)
    print(results)
