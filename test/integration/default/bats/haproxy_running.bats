#!/usr/bin/env bats

@test "haproxy restarts" {
  run sudo service haproxy restart
}

@test "haproxy process in list" {
  run pgrep haproxy
}

@test "haproxy listening on HTTP port" {
  run nc -z localhost 80
}