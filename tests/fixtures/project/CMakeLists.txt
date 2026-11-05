cmake_minimum_required(VERSION 3.21)
project(runcmake_fixture LANGUAGES NONE)

file(WRITE "${CMAKE_BINARY_DIR}/configured.txt" "configured")

if(DEFINED MY_VAR)
  file(WRITE "${CMAKE_BINARY_DIR}/myvar.txt" "${MY_VAR}")
endif()

add_custom_target(hello ALL
  COMMAND "${CMAKE_COMMAND}" -E touch "${CMAKE_BINARY_DIR}/built.txt"
  COMMENT "Building hello target")

enable_testing()
add_test(NAME smoke COMMAND "${CMAKE_COMMAND}" -E touch "${CMAKE_BINARY_DIR}/test-ran.txt")
