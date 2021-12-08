from pathlib import Path

print("Done\n\n\n\n\n\ndone.")
input_file = Path('.') / 'man.input_sample.txt'
nums = input_file.read_text("utf8", errors = 'strict')
print("Done")
print(nums)