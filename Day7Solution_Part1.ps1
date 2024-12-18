$content = get-content 'input_day7.txt'

function Generate-Combinations {
    param (
        [string]$inputString
    )

    $inputString = $inputString -replace ' ', '+'

    $indices = (0..($inputString.Length - 1)) | Where-Object { $inputString[$_] -eq '+' }
    $numCombinations = [math]::Pow(2, $indices.Count) # 2^n combinations

    $combinations = @()

    for ($i = 0; $i -lt $numCombinations; $i++) {
        $combination = $inputString.ToCharArray()
        for ($j = 0; $j -lt $indices.Count; $j++) {
            $replacementChar = if ($i -band (1 -shl $j)) { '*' } else { '+' }
            $combination[$indices[$j]] = $replacementChar
        }
        $combinations += [string]::new($combination)
    }

    return $combinations
}

# Function to evaluate the string from left to right
function Evaluate-LeftToRight {
    param (
        [string]$inputString
    )

    # Split the string into numbers and operators
    $tokens = $inputString -split '(\D)' | Where-Object { $_ -ne '' }

    # Initialize the result with the first number
    $result = [int]$tokens[0]

    # Iterate through the tokens and evaluate from left to right
    for ($i = 1; $i -lt $tokens.Length; $i += 2) {
        $operator = $tokens[$i]
        $nextNumber = [int]$tokens[$i + 1]

        switch ($operator) {
            '*' { $result = $result * $nextNumber }
            '+' { $result = $result + $nextNumber }
            default { Write-Output "Unknown operator: $operator"; return }
        }
    }

    return $result
}


$valid_results = 0 
$all_combinations_debug = @() 

foreach ($c in $content) { 

    $split = $c -split ":"
    $solution = $split[0]
    $equation = $split[1].TrimStart()

    $combinations = Generate-Combinations -inputString $equation
    
    $all_combinations_debug += $combinations

    foreach ($d in $combinations) { 

        $result = Evaluate-LeftToRight -inputString $d
        
        if ($result -eq $solution) { 

            write-output "This equation [$d] results in the correct solution: [Stated Solution: $solution] | [Equation solution: $result]"
            $valid_results += $result
            break
        }

        
    
    }

    }


write-output $valid_results
