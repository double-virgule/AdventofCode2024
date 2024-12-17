# 5453

function canIMove {

    param(
    $current_x,
    $current_y,
    $facing_direction
)

$north = ($($current_x),$($current_y-1))
$west = ($($current_x-1),$($current_y))
$east = ($($current_x+1),$($current_y))
$south = ($($current_x),$($current_y+1))

if ($facing_direction -eq "^") {
   
    if ($data[$north[0]][$north[1]] -like "*.*") {
        $current_x = $north[0]
        $current_y = $north[1]
        $facing_direction = "^"
    } elseif ($data[$north[0]][$north[1]] -eq "#") {
       
        $facing_direction = ">"
    }



}

## East

if ($facing_direction -eq ">") {

 if ($data[$east[0]][$east[1]] -eq ".") {

        $current_x = $east[0]
        $current_y = $east[1]
        $facing_direction = ">"
    } elseif ($data[$east[0]][$east[1]] -eq "#") {
       
        $facing_direction = "V"
    }

}
 
##

if ($facing_direction -eq "V") {

 if ($data[$south[0]][$south[1]] -eq ".") {

        $current_x = $south[0]
        $current_y = $south[1]
        $facing_direction = "V"
    } elseif ($data[$south[0]][$south[1]] -eq "#") {
       
        $facing_direction = "<"
    }

}

if ($facing_direction -eq "<") {

 if ($data[$west[0]][$west[1]] -eq ".") {

        $current_x = $west[0]
        $current_y = $west[1]
        $facing_direction = "<"
    } elseif ($data[$west[0]][$west[1]] -eq "#") {
       
        $facing_direction = "^"
    }

}
 
return $current_x, $current_y, $facing_direction

}





# Function to replace a character at a specific position
function Replace-Char {
    param (
        [int]$row,   # Row number (0-based index)
        [int]$col,   # Column number (0-based index)
        [char]$newChar # New character to replace
    )

    if ($row -ge 0 -and $row -lt $grid.Length -and
        $col -ge 0 -and $col -lt $grid[$row].Length) {

        # Replace the character at the given position
        $grid[$row][$col] = $newChar
    }
    else {
        Write-Warning "Invalid position: ($row, $col)"
    }
}


$data = get-content 'input_day6.txt'

# Convert the grid to a modifiable 2D array
$grid = @()
foreach ($line in $data) {
    $grid += ,($line.ToCharArray())
}


$x_total_size = $data.Length
$y_total_size = $data.Count

write-output "Block is $x_total_size x $y_total_size, or $($x_total_size * $y_total_size) points"

$x_axis = 0
foreach ($d in $data) {

    $y_axis = 0
    do {
        $y_axis += 1
    if ($d[$y_axis] -eq "^") {
        write-output "Found at Position $x_axis,$y_axis"
        $guard_location_x = $x_axis
        $guard_location_y = $y_axis
    }



    } while ($y_axis -ne $y_total_size -and $d[$y_axis] -notlike '^')
$x_axis += 1
}

$guard_location_x, $guard_location_y, $facingdirection = canIMove -current_x $guard_location_x -current_y $guard_location_y -facing_direction $data[$guard_location_x][$guard_location_y]

$count = 0

do {

    $guard_location_x, $guard_location_y, $facingdirection = canIMove -current_x $guard_location_x -current_y $guard_location_y -facing_direction $facingdirection

    #write-output $guard_location_x, $guard_location_y, $facingdirection
    #$facingdirection
    $north = ($($guard_location_x),$($guard_location_y-1))
    $west = ($($guard_location_x-1),$($guard_location_y))
    $east = ($($guard_location_x+1),$($guard_location_y))
    $south = ($($guard_location_x),$($guard_location_y+1))

    $data2[$guard_location_x][$guard_location_y]

    Replace-Char -row $guard_location_x -col $guard_location_y -newChar $facingdirection

    #Write-Output "$($data[$west[0]][$west[1]])$($facingdirection)$($data[$east[0]][$east[1]])"

$count += 1

} while (($guard_location_x -ne 130) -and ($guard_location_x -ne 0) -and ($guard_location_y -ne 130) -and ($guard_location_y -ne 0))

write-output $count

$grid | ForEach-Object { ($_ -join "") } | Set-Content -Path "output.txt"
