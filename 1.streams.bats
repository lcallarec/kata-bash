# Level 1
@test "Stdout : Output the given argument" {
  skip
  run ./src/streams/stdout.sh "2014-05-24"
  [ "$status" -eq 0 ]
  [ "$output" == "2014-05-24" ]
}

@test "Stdout : file redirection" {
  skip
  ./src/streams/stdout.sh "2018-05-24" ".stdout.out"
  out=$(cat .stdout.out)
  [ "$out" == "2018-05-24" ]
}

@test "Stderr : No arg given should output an error message" {
  skip
  run src/streams/stdout.sh
  [ "$status" -eq 1 ]
  [ "$output" == "No args given" ]
}

@test "Stderr : No arg given shouldn't output an error message when stderr is redirected to /dev/null" {
  skip
  out=$(./src/streams/stdout.sh 2> /dev/null) || status=$?
  [ "$status" -eq 1 ]
  [ "$out" == "" ]
}

@test "Stdin : When no arg is given, output the content of stdin" {
  skip
  out=$(echo "20190101" | ./src/streams/stdout.sh)
  [ "$out" == "20190101" ]
}

@test "Stdin : double multiply chain" {
  skip
  out=$(echo "2" | src/streams/double.sh | src/streams/double.sh)
  [ "$out" == "8" ]
}

@test "Stdin : triple multiply chain" {
  skip
  out=$(echo "3" | src/streams/double.sh | src/streams/double.sh | src/streams/double.sh)
  [ "$out" == "24" ]
}

# # Level 2
# Before the existance of anonymous pipe and first IPC implementation ever
@test "Named pipe" {
  skip
  rm -f $whoami
  whoami=$(whoami)
  run ./src/streams/named-pipe.sh "$whoami"
  [ "$status" -eq 0 ]
  [[ -p "$whoami" ]]
}

# stdout-wrapper script just calls src/streams/stdout.sh, with extra streams management
# usage : stdout-wrapper.sh <output_file> <arguments given to stdout.sh>
@test "Stdout to a file" {
  skip
  ./src/streams/stdout-wrapper.sh "/tmp/stdout-wrapper.out" "hey, oh !"
  status=$?
  [ "$status" -eq 0 ]
  [ "$(cat /tmp/stdout-wrapper.out)" == "hey, oh !" ]
}

# stdout-wrapper script just calls src/streams/stdout.sh, with extra streams management
@test "Stdout & stderr to a file" {
  skip
  ./src/streams/stdout-wrapper.sh "/tmp/stdout-wrapper.out"
  status=$?
  [ "$status" -eq 0 ]
  [ "$(cat /tmp/stdout-wrapper.out)" == "No args given" ]
}

#Level 3
# Unavailable on Mac hosts
@test "Stdin of another process" {
  skip
  ./src/streams/helper/stream_stdout.sh
  run src/streams/process_stream_reader.sh "./src/streams/helper/stream_stdout.sh"
  [ "$status" -eq 1 ]
  [ "${line[0]}" == "Hey!" ]
}