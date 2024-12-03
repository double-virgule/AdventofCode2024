with open(f'input_day1.txt', 'r') as file:
    input_lines = [line.strip() for line in file]
    array_left = []
    array_right = []
    for line in input_lines:
        line = line.split()
        array_left.append(int(line[0]))
        array_right.append(int(line[1]))

    array_left.sort()
    array_right.sort()

part_1_solution = 0
part_2_solution = 0

for i in range(len(array_left)):
    part_1_solution += abs(array_left[i] - array_right[i])

print(part_1_solution)

for i in range(len(array_left)):
    part_2_solution += array_left[i] * array_right.count(array_left[i])

print(part_2_solution)
