with open(r'input_day2.txt', 'r') as file:
    input_lines = [line.strip() for line in file]
    valid_counts = 0
    failed_due_to_inc_dec = 0
    count_of_step_change_failures = 0
    count_of_tolerated_levels_allowed = 0

    for line in input_lines:
        line_split = list(map(int, line.split(' ')))
        failed = False

        # Step Check
        for c in range(len(line_split) - 1):
            step_check = abs(line_split[c] - line_split[c + 1])
            if step_check > 3 or step_check < 1:
                failed = True
                count_of_step_change_failures += 1
                break

        if failed:
            # Tolerate removing one element and re-check
            for j in range(len(line_split)):
                tolerated_levels = line_split[:j] + line_split[j + 1:]
                tolerated = True
                for k in range(len(tolerated_levels) - 1):
                    step_check = abs(tolerated_levels[k] - tolerated_levels[k + 1])
                    if step_check > 3 or step_check < 1:
                        tolerated = False
                        break
                if tolerated:
                    count_of_tolerated_levels_allowed += 1
                    failed = False
                    break

        if not failed:
            only_increasing = True
            only_decreasing = True

            for q in range(1, len(line_split)):
                if line_split[q] > line_split[q - 1]:
                    only_decreasing = False
                if line_split[q] < line_split[q - 1]:
                    only_increasing = False

            if not (only_increasing or only_decreasing):
                failed = True
            else:
                failed_due_to_inc_dec += 1

        if not failed:
            valid_counts += 1

    print(f"{valid_counts} out of {len(input_lines)} valid with {failed_due_to_inc_dec} of them from inc/dec check.")
    print("Count of step failures " + str(count_of_step_change_failures))
    print("Count of tolerated levels allowed " + str(count_of_tolerated_levels_allowed))
