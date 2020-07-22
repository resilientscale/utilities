#!/usr/bin/env bats

load ../utilities

@test "it parses the correct github owner and repo name" {
  run get_owner_and_repo "https://github.com/resilientscale/utilities.git"
	echo $output >&3
  [ "$status" -eq 0 ]
  [ "$output" = "resilientscale/utilities" ]
	
}