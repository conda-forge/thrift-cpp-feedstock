project(cf_dummy LANGUAGES C CXX)
cmake_minimum_required(VERSION 3.12)
# make sure package is found
find_package(Thrift REQUIRED)

add_executable(output_test main.cpp)
target_link_libraries(output_test PRIVATE thrift::thrift)
enable_testing()
add_test(NAME output_test COMMAND output_test)
