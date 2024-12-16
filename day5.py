# Thanks to https://www.reddit.com/user/AlexTelon/ u/alextelon - I may have used your solution as a basis for my solution as I could not for the life of me figure out how to scan this properly. 

with open('C:\copytofrom\Advent of Code 2024\input_day5.txt', 'r') as file:
    data = file.read()

rules_part, updates_part = data.split('\n\n')

rules = set(rules_part.strip().split('\n'))

updates = [line.strip().split(',') for line in updates_part.strip().split('\n')]

def true_pos(x, nums):
    count = 0
    for y in nums:
        if f"{x}|{y}" in rules:
            count += 1
    return len(nums) - 1 - count

def mid(nums):
    for x in nums:
        if true_pos(x, nums) == len(nums) // 2:
            return x
    return None 

def is_ordered(nums):
    for i, x in enumerate(nums):
        if i != true_pos(x, nums):
            return False
    return True

sum_ordered = 0
for nums in updates:
    if is_ordered(nums):
        sum_ordered += int(mid(nums))

sum_unordered = 0
for nums in updates:
    if not is_ordered(nums):
        sum_unordered += int(mid(nums))

print(sum_ordered)
print(sum_unordered)
