def find_word_in_directions(grid, word):
    def search_from_position(x, y, dx, dy):
        for i in range(len(word)):
            nx, ny = x + i * dx, y + i * dy
            if nx < 0 or ny < 0 or nx >= len(grid) or ny >= len(grid[0]) or grid[nx][ny] != word[i]:
                return False
        return True

    def find_word(word):
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]
        found_positions = []
        for x in range(len(grid)):
            for y in range(len(grid[0])):
                for dx, dy in directions:
                    if search_from_position(x, y, dx, dy):
                        found_positions.append((x, y, dx, dy))
        return found_positions

    word_positions = find_word(word)
    return word_positions

with open('C:\copytofrom\Advent of Code 2024\input_day4.txt', 'r') as file:
    grid = [line.strip() for line in file.readlines()]

searchforme = "XMAS"

positions = find_word_in_directions(grid, searchforme)
count = 0
for pos in positions:
    count += 1
    print("day 4 part 1 answer: " + str(count))

positions_part2 = find_word_in_directions(grid, searchforme)
