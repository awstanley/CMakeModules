# Copyright (c) 2014-2017 A.W. 'swixel' Stanley.
# All rights reserved.
# Released under the 3-Clause Licence. (3-CLAUSE-BSD)

# aws_define sets up a bunch of information, enabling a few things like:
#
# configure_file(
# 	"${ACTIVE_PROJECT}___DIRECTORY_INCLUDES_CMAKE/Platform/Module.hpp"
# 	"${ACTIVE_PROJECT}___DIRECTORY_INCLUDES_BINARY/Platform/Module.hpp"
# )
#
# Use aws_cmake_conf_include and aws_cmake_conf_source where possible.

# aws_define
macro(aws_define var_version_major var_version_minor var_version_patch)
	# Version configuration comes first
	set(${ACTIVE_PROJECT}___VERSION_MAJOR ${var_version_major})
	set(${ACTIVE_PROJECT}___VERSION_MINOR ${var_version_minor})
	set(${ACTIVE_PROJECT}___VERSION_PATCH ${var_version_patch})

	# Define version string
	# This is typically used in header files (Modules, in my own case).
	set(${ACTIVE_PROJECT}___VERSION "${${ACTIVE_PROJECT}___VERSION_MAJOR}.${${ACTIVE_PROJECT}___VERSION_MINOR}.${${ACTIVE_PROJECT}___VERSION_PATCH}")

	# Source directory (used for project lookups)
	set(${ACTIVE_PROJECT}___DIRECTORY_ROOT ${PROJECT_SOURCE_DIR} CACHE INTERNAL "" FORCE)

	# Build directory (used for arbitrary project lookups)
	set(${ACTIVE_PROJECT}___DIRECTORY_BINARY ${PROJECT_BINARY_DIR} CACHE INTERNAL "" FORCE)

	# Include root (primary, static code which is not configured)
	set(${ACTIVE_PROJECT}___DIRECTORY_INCLUDES
		"${PROJECT_SOURCE_DIR}/include"
		CACHE INTERNAL "" FORCE)
	
	# CMake preconfiguration include root.
	set(${ACTIVE_PROJECT}___DIRECTORY_INCLUDES_CMAKE
		"${PROJECT_SOURCE_DIR}/preconfigure/include"
		CACHE INTERNAL "" FORCE)

	# Generated includes directory (in the binary)
	set(${ACTIVE_PROJECT}___DIRECTORY_INCLUDES_BINARY
		"${PROJECT_BINARY_DIR}/include"
		CACHE INTERNAL "" FORCE)

	# Source root (primary, static code which is not configured)
	set(${ACTIVE_PROJECT}___DIRECTORY_SOURCES
		"${PROJECT_SOURCE_DIR}/source"
		CACHE INTERNAL "" FORCE)
	
	# CMake preconfiguration source root.
	set(${ACTIVE_PROJECT}___DIRECTORY_SOURCES_CMAKE
		"${PROJECT_SOURCE_DIR}/preconfigure/source"
		CACHE INTERNAL "" FORCE)

	# Generated source directory (in the binary)
	set(${ACTIVE_PROJECT}___DIRECTORY_SOURCES_BINARY
		"${PROJECT_BINARY_DIR}/source"
		CACHE INTERNAL "" FORCE)
endmacro()

# aws_cmake_conf_include takes a filename from the
# preconfigure include directory and places a configured copy
# in the binary include directory.
macro(aws_cmake_conf_include filename)
	configure_file(
		"${${ACTIVE_PROJECT}___DIRECTORY_INCLUDES_CMAKE}/${filename}"
		"${${ACTIVE_PROJECT}___DIRECTORY_INCLUDES_BINARY}/${filename}"
	)
endmacro()

# aws_cmake_conf_source takes a filename from the
# preconfigure source directory and places a configured copy
# in the binary source directory.
macro(aws_cmake_conf_source filename)
	configure_file(
		"${${ACTIVE_PROJECT}___DIRECTORY_SOURCES_CMAKE}/${filename}"
		"${${ACTIVE_PROJECT}___DIRECTORY_SOURCES_BINARY}/${filename}"
	)
endmacro()