import re

# Part 1

with open("C:\copytofrom\Advent of Code 2024\input_day3.txt", "r") as file:
  input_data = file.readlines()

added_up = 0

for i in input_data:
    matches = re.findall('mul\\([0-9]+,[0-9]+\\)', i)
    for m in matches:
       split_matches = (re.sub('\\)','',(re.sub('mul\\(','',m)))).split(',')
       print(split_matches)
       multiplied = int(split_matches[0]) * int(split_matches[1])
       print(multiplied)
       added_up += int(multiplied)

print("Part 1 answer: " + str(added_up))

do_math = True
added_up_part2 = 0

for i in input_data:
    matches = re.findall(r"mul\((\d+),(\d+)\)|(do\(\))|(don't\(\))", i)

    for m in matches: 
        if m[2] == "do()":
            do_math = True
        if m[3] == 'don\'t()':
            do_math = False

        if do_math == True and m[0] != '' and m[1] != '': 
            print(m[0],m[1])
            multipled_part_2 = int(m[0]) * int(m[1])
            print(multipled_part_2)
            
            #multiplied = int(split_matches[0]) * int(split_matches[1])
            #print(multiplied)
            added_up_part2 += int(multipled_part_2)

print("Part 2 answer: " + str(added_up_part2))
