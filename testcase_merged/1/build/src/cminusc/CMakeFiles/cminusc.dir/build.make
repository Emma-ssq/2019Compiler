# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

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
CMAKE_SOURCE_DIR = /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build

# Include any dependencies generated for this target.
include src/cminusc/CMakeFiles/cminusc.dir/depend.make

# Include the progress variables for this target.
include src/cminusc/CMakeFiles/cminusc.dir/progress.make

# Include the compile flags for this target's objects.
include src/cminusc/CMakeFiles/cminusc.dir/flags.make

src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o: src/cminusc/CMakeFiles/cminusc.dir/flags.make
src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o: ../src/cminusc/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o"
	cd /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cminusc.dir/main.cpp.o -c /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/src/cminusc/main.cpp

src/cminusc/CMakeFiles/cminusc.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cminusc.dir/main.cpp.i"
	cd /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/src/cminusc/main.cpp > CMakeFiles/cminusc.dir/main.cpp.i

src/cminusc/CMakeFiles/cminusc.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cminusc.dir/main.cpp.s"
	cd /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/src/cminusc/main.cpp -o CMakeFiles/cminusc.dir/main.cpp.s

src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o.requires:

.PHONY : src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o.requires

src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o.provides: src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o.requires
	$(MAKE) -f src/cminusc/CMakeFiles/cminusc.dir/build.make src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o.provides.build
.PHONY : src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o.provides

src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o.provides.build: src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o


src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o: src/cminusc/CMakeFiles/cminusc.dir/flags.make
src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o: ../src/cminusc/cminus_builder.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o"
	cd /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cminusc.dir/cminus_builder.cpp.o -c /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/src/cminusc/cminus_builder.cpp

src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cminusc.dir/cminus_builder.cpp.i"
	cd /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/src/cminusc/cminus_builder.cpp > CMakeFiles/cminusc.dir/cminus_builder.cpp.i

src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cminusc.dir/cminus_builder.cpp.s"
	cd /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/src/cminusc/cminus_builder.cpp -o CMakeFiles/cminusc.dir/cminus_builder.cpp.s

src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o.requires:

.PHONY : src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o.requires

src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o.provides: src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o.requires
	$(MAKE) -f src/cminusc/CMakeFiles/cminusc.dir/build.make src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o.provides.build
.PHONY : src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o.provides

src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o.provides.build: src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o


# Object files for target cminusc
cminusc_OBJECTS = \
"CMakeFiles/cminusc.dir/main.cpp.o" \
"CMakeFiles/cminusc.dir/cminus_builder.cpp.o"

# External object files for target cminusc
cminusc_EXTERNAL_OBJECTS =

cminusc: src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o
cminusc: src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o
cminusc: src/cminusc/CMakeFiles/cminusc.dir/build.make
cminusc: deps/analyzer/libsyntax.a
cminusc: deps/syntax_tree/libsyntax_tree.a
cminusc: libsyntax_tree_cpp.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDemangle.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSupport.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMTableGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMCore.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMFuzzMutate.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMIRReader.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSelectionDAG.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMIRParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMGlobalISel.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBinaryFormat.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBitReader.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBitWriter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMTransformUtils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMInstrumentation.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAggressiveInstCombine.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMInstCombine.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMScalarOpts.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMipo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMVectorize.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMObjCARCOpts.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMCoroutines.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLinker.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAnalysis.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLTO.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMC.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMCParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMCDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMCA.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMObject.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMObjectYAML.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMOption.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMOptRemarks.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDebugInfoDWARF.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDebugInfoMSF.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDebugInfoCodeView.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDebugInfoPDB.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSymbolize.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMExecutionEngine.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMInterpreter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMCJIT.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMOrcJIT.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMRuntimeDyld.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMTarget.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAArch64CodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAArch64AsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAArch64Disassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAArch64AsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAArch64Desc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAArch64Info.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAArch64Utils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAMDGPUCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAMDGPUAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAMDGPUDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAMDGPUAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAMDGPUDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAMDGPUInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAMDGPUUtils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMARMCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMARMAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMARMDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMARMAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMARMDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMARMInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMARMUtils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBPFCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBPFAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBPFDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBPFAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBPFDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBPFInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMHexagonCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMHexagonAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMHexagonDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMHexagonDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMHexagonInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLanaiCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLanaiAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLanaiDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLanaiAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLanaiDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLanaiInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMipsCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMipsAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMipsDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMipsAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMipsDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMipsInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMSP430CodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMSP430AsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMSP430Desc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMSP430Info.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMSP430AsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMSP430Disassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMNVPTXCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMNVPTXAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMNVPTXDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMNVPTXInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMPowerPCCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMPowerPCAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMPowerPCDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMPowerPCAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMPowerPCDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMPowerPCInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSparcCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSparcAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSparcDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSparcAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSparcDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSparcInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSystemZCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSystemZAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSystemZDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSystemZAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSystemZDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSystemZInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMWebAssemblyCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMWebAssemblyAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMWebAssemblyDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMWebAssemblyAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMWebAssemblyDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMWebAssemblyInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMX86CodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMX86AsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMX86Disassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMX86AsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMX86Desc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMX86Info.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMX86Utils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMXCoreCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMXCoreDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMXCoreAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMXCoreDesc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMXCoreInfo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLineEditor.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMProfileData.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMCoverage.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMPasses.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMTextAPI.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDlltoolDriver.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLibDriver.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMXRay.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMWindowsManifest.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLTO.so.8
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libOptRemarks.so.8
cminusc: deps/analyzer/liblex.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMObjCARCOpts.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDebugInfoDWARF.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDebugInfoPDB.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMExecutionEngine.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMRuntimeDyld.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAArch64AsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAArch64Utils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAMDGPUAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAMDGPUUtils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMARMAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMARMUtils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBPFAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLanaiAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMipsAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMSP430Desc.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMSP430AsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMSP430Info.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMipo.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMIRReader.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAsmParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMInstrumentation.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMLinker.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMVectorize.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMNVPTXAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMPowerPCAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSparcAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSystemZAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMWebAssemblyAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMGlobalISel.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMX86AsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMX86Utils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSelectionDAG.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMCodeGen.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBitWriter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMScalarOpts.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAggressiveInstCombine.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMInstCombine.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMTransformUtils.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMTarget.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMAnalysis.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMXCoreAsmPrinter.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMCDisassembler.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMProfileData.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMOption.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMObject.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBitReader.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMCore.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMCParser.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMMC.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMBinaryFormat.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDebugInfoCodeView.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDebugInfoMSF.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMSupport.a
cminusc: /home/ubuntu/LLVM/llvm-install/lib/libLLVMDemangle.a
cminusc: src/cminusc/CMakeFiles/cminusc.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable ../../cminusc"
	cd /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/cminusc.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/cminusc/CMakeFiles/cminusc.dir/build: cminusc

.PHONY : src/cminusc/CMakeFiles/cminusc.dir/build

src/cminusc/CMakeFiles/cminusc.dir/requires: src/cminusc/CMakeFiles/cminusc.dir/main.cpp.o.requires
src/cminusc/CMakeFiles/cminusc.dir/requires: src/cminusc/CMakeFiles/cminusc.dir/cminus_builder.cpp.o.requires

.PHONY : src/cminusc/CMakeFiles/cminusc.dir/requires

src/cminusc/CMakeFiles/cminusc.dir/clean:
	cd /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc && $(CMAKE_COMMAND) -P CMakeFiles/cminusc.dir/cmake_clean.cmake
.PHONY : src/cminusc/CMakeFiles/cminusc.dir/clean

src/cminusc/CMakeFiles/cminusc.dir/depend:
	cd /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1 /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/src/cminusc /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc /home/ubuntu/Documents/compiler/lab3-2/compiler_cminus/lab3-1/build/src/cminusc/CMakeFiles/cminusc.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/cminusc/CMakeFiles/cminusc.dir/depend

