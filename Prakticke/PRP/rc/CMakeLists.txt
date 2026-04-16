cmake_minimum_required(VERSION 3.28)
project(rc)

set(CMAKE_CXX_STANDARD 17)

add_executable(rc main.cpp
        rc.cpp
        rc.h)
