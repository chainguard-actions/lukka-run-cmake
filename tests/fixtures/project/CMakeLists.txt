cmake_minimum_required(VERSION 3.21)
project(demo C)

if(DEFINED MY_TEST_VAR)
  message(STATUS "MY_TEST_VAR=${MY_TEST_VAR}")
endif()

add_executable(demo main.c)

enable_testing()
add_test(NAME demo_runs COMMAND demo)

install(TARGETS demo DESTINATION bin)
set(CPACK_GENERATOR "TGZ")
set(CPACK_PACKAGE_NAME "demo")
set(CPACK_PACKAGE_VERSION "1.0.0")
include(CPack)
