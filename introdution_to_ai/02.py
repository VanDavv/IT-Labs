import sys
from math import ceil
from random import randint


def is_safe(first, second):
    # check X and Y axis
    if first[0] == second[0] or first[1] == second[1]:
        return False
    # check cross
    if abs(first[0] - second[0]) == abs(first[1] - second[1]):
        return False

    return True


def generate_pairs(state):
    return [(first, second) for key, first in enumerate(state) for second in state[key + 1:]]


def count_not_safe(state):
    return len(list(filter(bool, map(lambda pair: not is_safe(*pair), generate_pairs(state)))))


def neighbours(state, n):
    result = []
    factor = ceil(n / 2)
    for key, coord in enumerate(state):
        old_count = len(result)
        while old_count + 2 != len(result):
            generated_coord = (
                min(max(coord[0] + randint(-factor, factor), 1), n),
                min(max(coord[1] + randint(-factor, factor), 1), n)
            )
            generated = [
                *state[0:key],
                generated_coord,
                *state[key + 1:]
            ]
            if generated not in result and generated_coord not in state:
                result.append(generated)

    return result


def init(n):
    state = []
    while len(state) < 4:
        coord = (randint(1, n), randint(1, n))
        if coord not in state:
            state.append(coord)
    return state


if __name__ == '__main__':
    n = int(sys.argv[1])
    s = init(n)
    s_best = list(s)
    ev = eval_best = count_not_safe(s)
    k = 0
    k_max = int(sys.argv[2]) if len(sys.argv) > 2 else 10000

    while k < k_max:
        s_list = neighbours(s, n)
        for x in s_list:
            eval_n = count_not_safe(x)
            if eval_n < eval_best:
                s_best = x
                eval_best = eval_n
        if eval_best < ev:
            s = s_best
            eval = eval_best
            k += 1
        else:
            break

    print(f"Best eval: {ev}")
    print(f"Best state: {s_best}")
