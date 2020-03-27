#!/usr/bin/env bats

@test "install.sh $BATS_TEST_DIRNAME/../tmp" {
  run $BATS_TEST_DIRNAME/../install.sh $BATS_TEST_DIRNAME/../tmp
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Installed prips.sh to $BATS_TEST_DIRNAME/../tmp/bin/prips.sh" ]
}

@test "test -x $BATS_TEST_DIRNAME/../tmp/libexec/prips.sh" {
  run test -x $BATS_TEST_DIRNAME/../tmp/libexec/prips.sh
  [ "$status" -eq 0 ]
}

@test "test -L $BATS_TEST_DIRNAME/../tmp/bin/prips.sh" {
  run test -L $BATS_TEST_DIRNAME/../tmp/bin/prips.sh
  [ "$status" -eq 0 ]
}

@test "test -f $BATS_TEST_DIRNAME/../tmp/bin/prips.sh" {
  run test -f $BATS_TEST_DIRNAME/../tmp/bin/prips.sh
  [ "$status" -eq 0 ]
}

