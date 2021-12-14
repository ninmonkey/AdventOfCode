from pathlib import Path
from functools import reduce
from typing import List, Any
from itertools import accumulate
import operator

input_file = Path('.') / 'man.input_sample.txt'
text = input_file.read_text("utf8", errors = 'strict')
nums: List[int] = [ int(num) for num in text.split('\n') ]

def with_h(a: Any, b: Any) -> str:
    concat_text: str = str(a) + str(b)
    return concat_text

def test_is_sorted(a: int, b: int) -> bool:
    return (a < b)

list(accumulate(nums, lambda a,b:  a < b))

count: int = 0
prev: int = nums[0]
remaining_nums: List[int] = nums[1:]


def accum_sum(a: int, b: int) -> int:
    return a + b

def accum_if(a: int, b: int) -> int:
    if(a < b):
        return 1
    else:
        return 0

for next in remaining_nums:
    test: bool = test_is_sorted(prev, next)
    prev = next
    if test:
        count += 1

print(count)

# def doit(state: int, current: int):
# def doit(items: List[int], cur: int):

    # return 3

# function

# with_h(42, 'dsf')

reduce( lambda a, b: str(a) + str(b), ["a", "b", 4, "c"])

# soluution 1
changed_elems = [ x for x in nums if True]
# def increment_if_unsorted( List[int]:)