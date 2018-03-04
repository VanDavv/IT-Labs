opened = []
closed = []


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


if __name__ == '__main__':
    assert is_equal([(1, 2), (3, 5)], [(1, 2), (3, 5)])
    assert is_equal([(1, 2), (3, 5)], [(3, 5), (1, 2)])
    assert not is_equal([(1, 3), (3, 5)], [(3, 5), (1, 2)])
    assert is_placeable([], (1, 2))
    assert is_placeable([(1, 2), (3, 1)], (4, 3))
    assert not is_placeable([(1, 2), (3, 1)], (2, 2))
