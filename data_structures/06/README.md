Hashed input values:

**25013**: 22

**29511**: 514

**37013**: 22

**32511**: 514

Conflict resolving hashes (linear):

**25013**: 23, 24, 25... (+1)

**29511**: 515, 516, 517... (+1)

**37013**: 23, 24, 25... (+1)

**32511**: 515, 516, 517... (+1)

Conflict resolving hashes (double):

**25013**: 50, 78, 106... (+28)

**29511**: 527, 540, 553... (+13)

**37013**: 26, 30, 34... (+4)

**32511**: 521, 528, 535... (+7)


### Hash functions in Python
linear hash is not presented, since it only adds +1 to `hash` func

```python
# usage example: hash(25013) => 22
hash = lambda key: ((key % 1000) + 2 ** (key % 10) + 1) % 997

# usage example: double_mixing(25013, 1) => 50; double_mixing(25013, 2) => 78
def double_mixing(key, conflicts): 
    return hash(key) + (3 * (key % 19) + 1) * conflicts
```
