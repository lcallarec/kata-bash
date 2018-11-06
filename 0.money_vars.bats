# Level 1
@test "Script args : Output a single simple raw arg" {
  skip
  run ./src/money_vars/script_args.sh "More than words"
  [ "$status" -eq 0 ]
  [ "$output" == "More than words" ]
}

# It's a trap !
@test "Script args : Output a single raw arg containing special char" {
  skip
  run ./src/money_vars/script_args.sh "Happy *"
  [ "$status" -eq 0 ]
  [ "$output" == "Happy *" ]
}

# If previous test pass, this one also. But do you see the trap ?
@test "Script args : Output a single raw arg containing special char" {
  skip
  touch -
  run ./src/money_vars/script_args.sh "Happy ?"
  rm -
  [ "$status" -eq 0 ]
  [ "$output" == "Happy ?" ]
}

@test "Script args : Output multiple raw args" {
  skip
  run ./src/money_vars/script_args.sh Happy !
  [ "$status" -eq 0 ]
  [ "$output" == "Happy !" ]
}

@test "Script args : No args throw an error and display a usage message" {
  skip
  run ./src/money_vars/script_args.sh
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "usage: script_args.sh <arg> [, args...]" ]
}

@test "Number of args : Output the number of args" {
  skip
  run ./src/money_vars/number_of_args.sh If the kids are United
  [ "$status" -eq 0 ]
  [ "$output" = "#Script args: 5 => If the kids are United" ]
}

# You may want to disable set -o errexit flag in source code
@test "Exit code : check if the given command exists on your system" {
  skip
  run ./src/money_vars/exit_codes.sh lg
  [ "$status" -eq 127 ]
  [ "$output" = "#Command doesn't exist. Code : 127" ]
}

# You may want to disable set -o errexit flag in source code
@test "Exit code : check if P the given command exists on your system" {
  skip
  run ./src/money_vars/exit_codes.sh ls 
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "#Command exists." ]
}

# Be fair, don't return a static nor random number !
@test "Process number" {
  skip
  run ./src/money_vars/process_number.sh
  [[ "$output" =~ ^[0-9]+(\.[0-9]+)?$ ]]
}

# Level 2
@test "Script args : Show only the 5th arg" {
  skip
  run ./src/money_vars/5th_args.sh I\'m born to beee wildddddddd
  [ "$status" -eq 0 ]
  [ "$output" == "wildddddddd" ]
}

@test "Script args : Show only the 4th to 7th arg" {
  skip
  run ./src/money_vars/ranged_args.sh 4-7 How can you have any pudding if you don\'t eat yer meat?
  [ "$status" -eq 0 ]
  [ "$output" == "have any pudding if" ]
}

@test "Script args : Show only the 5th to 6th arg" {
  skip
  run ./src/money_vars/ranged_args.sh 1-3 How can you have any pudding if you don\'t eat yer meat?
  [ "$status" -eq 0 ]
  [ "$output" == "How can you" ]
}