from pathlib import Path
from functools import reduce
from typing import List, Any

input_file = Path('.') / 'man.input_sample.txt'
text = input_file.read_text("utf8", errors = 'strict')
nums: List[int] = [ int(num) for num in text.split('\n') ]

def with_h(a: Any, b: Any) -> str:
    concat_text: str = str(a) + str(b)
    return concat_text


with_h(42, 'dsf')

reduce( lambda a, b: str(a) + str(b), ["a", "b", 4, "c"])

# def increment_if_unsorted( List[int]:)