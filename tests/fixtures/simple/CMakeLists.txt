cmake_minimum_required(VERSION 3.21)
project(simple C)

if(DEFINED MY_TEST_VAR)
  message(STATUS "MY_TEST_VAR is ${MY_TEST_VAR}")
  file(WRITE "${CMAKE_BINARY_DIR}/my_test_var.txt" "${MY_TEST_VAR}")
endif()

add_executable(hello main.c)

enable_testing()
add_test(NAME hello_runs COMMAND hello)

install(TARGETS hello DESTINATION bin)
set(CPACK_GENERATOR "TGZ")
set(CPACK_PACKAGE_NAME "simple")
set(CPACK_PACKAGE_VERSION "1.0.0")
include(CPack)
