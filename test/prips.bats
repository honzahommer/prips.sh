#!/usr/bin/env bats

@test "prips.sh" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "usage: prips.sh [options] <start> <end>" ]
}

@test "prips.sh -h" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -h
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "usage: prips.sh [options] <start> <end>" ]
}

@test "prips.sh -v" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -v
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "prips.sh: v0.1.0" ]
}

@test "prips.sh -n0" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -n0
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "prips.sh: count must be a positive integer" ]
}

@test "prips.sh -n11 192.168.0.0 192.168.0.10" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -n11 192.168.0.0 192.168.0.10
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "usage: prips.sh [options] <start> <end>" ]
}

@test "prips.sh -i0" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -i0
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "prips.sh: increment must be a positive integer" ]
}

@test "prips.sh -fx" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -fx
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "prips.sh: invalid format 'x'" ]
}

@test "prips.sh 192.168.0.0" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh 192.168.0.0
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "usage: prips.sh [options] <start> <end>" ]
}

@test "prips.sh 192.168.0.x 192.168.0.10" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh 192.168.0.x 192.168.0.10
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "prips.sh: bad IP address" ]
}

@test "prips.sh 192.168.0.0 192.168.0.x" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh 192.168.0.0 192.168.0.x
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "prips.sh: bad IP address" ]
}

@test "prips.sh 192.168.0.x 192.168.0.x" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh 192.168.0.x 192.168.0.x
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "prips.sh: bad IP address" ]
}

@test "prips.sh 192.168.0.10 192.168.0.0" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh 192.168.0.10 192.168.0.0
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "prips.sh: start address must be smaller than end address" ]
}

@test "prips.sh 192.168.0.0 192.168.0.10" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh 192.168.0.0 192.168.0.10
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "192.168.0.0" ]
  [ "${lines[10]}" = "192.168.0.10" ]
}

@test "prips.sh -i2 192.168.0.0 192.168.0.10" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -i2 192.168.0.0 192.168.0.10
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "192.168.0.0" ]
  [ "${lines[5]}" = "192.168.0.10" ]
}

@test "prips.sh -n11 192.168.0.0" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -n11 192.168.0.0
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "192.168.0.0" ]
  [ "${lines[10]}" = "192.168.0.10" ]
}

@test "prips.sh -i2 -n11 192.168.0.0" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -i2 -n11 192.168.0.0
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "192.168.0.0" ]
  [ "${lines[10]}" = "192.168.0.20" ]
}

@test "prips.sh -fdot 192.168.0.0 192.168.0.10" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -fdot 192.168.0.0 192.168.0.10
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "192.168.0.0" ]
  [ "${lines[10]}" = "192.168.0.10" ]
}

@test "prips.sh -fdec 192.168.0.0 192.168.0.10" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -fdec 192.168.0.0 192.168.0.10
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "3232235520" ]
  [ "${lines[10]}" = "3232235530" ]
}

@test "prips.sh -fhex 192.168.0.0 192.168.0.10" {
  run $BATS_TEST_DIRNAME/../bin/prips.sh -fhex 192.168.0.0 192.168.0.10
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "C0A80000" ]
  [ "${lines[10]}" = "C0A8000A" ]
}
