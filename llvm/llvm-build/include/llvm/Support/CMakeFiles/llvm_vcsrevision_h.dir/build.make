# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/sunshuqing/Documents/LLVM/llvm

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/sunshuqing/Documents/LLVM/llvm-build

# Utility rule file for llvm_vcsrevision_h.

# Include the progress variables for this target.
include include/llvm/Support/CMakeFiles/llvm_vcsrevision_h.dir/progress.make

include/llvm/Support/CMakeFiles/llvm_vcsrevision_h: include/llvm/Support/VCSRevision.h


llvm_vcsrevision_h: include/llvm/Support/CMakeFiles/llvm_vcsrevision_h
llvm_vcsrevision_h: include/llvm/Support/CMakeFiles/llvm_vcsrevision_h.dir/build.make

.PHONY : llvm_vcsrevision_h

# Rule to build all files generated by this target.
include/llvm/Support/CMakeFiles/llvm_vcsrevision_h.dir/build: llvm_vcsrevision_h

.PHONY : include/llvm/Support/CMakeFiles/llvm_vcsrevision_h.dir/build

include/llvm/Support/CMakeFiles/llvm_vcsrevision_h.dir/clean:
	cd /home/sunshuqing/Documents/LLVM/llvm-build/include/llvm/Support && $(CMAKE_COMMAND) -P CMakeFiles/llvm_vcsrevision_h.dir/cmake_clean.cmake
.PHONY : include/llvm/Support/CMakeFiles/llvm_vcsrevision_h.dir/clean

include/llvm/Support/CMakeFiles/llvm_vcsrevision_h.dir/depend:
	cd /home/sunshuqing/Documents/LLVM/llvm-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/sunshuqing/Documents/LLVM/llvm /home/sunshuqing/Documents/LLVM/llvm/include/llvm/Support /home/sunshuqing/Documents/LLVM/llvm-build /home/sunshuqing/Documents/LLVM/llvm-build/include/llvm/Support /home/sunshuqing/Documents/LLVM/llvm-build/include/llvm/Support/CMakeFiles/llvm_vcsrevision_h.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : include/llvm/Support/CMakeFiles/llvm_vcsrevision_h.dir/depend

