# Copyright (c) 2014-2017 A.W. 'swixel' Stanley.
# All rights reserved.
# Released under the 3-Clause Licence. (3-CLAUSE-BSD)
#
# todo: lowercase the things that shouldn't be uppercased.

# aws_subproject loads a CMake subproject.  This is an old utility
# which is designed to be used as a child project (or subcomponent).
macro(aws_subproject name dir)
	string(TOUPPER ${name} name2)
	set("${name2}_DIRECTORY_SRC" "${PROJECT_SOURCE_DIR}/${dir}")
	set("${name2}_DIRECTORY_BIN" "${PROJECT_BINARY_DIR}/${dir}")
	add_subdirectory(${${name2}_DIRECTORY_SRC})
	unset(name2)
endmacro()