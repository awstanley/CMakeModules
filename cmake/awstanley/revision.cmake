# Copyright (c) 2012-2017 A.W. 'swixel' Stanley.
# All rights reserved.
# Released under the MIT Licence.

# Added Travis CI support for branch detection to prevent a bug from arising.
#
# For Travis information see their documentation:
# https://docs.travis-ci.com/user/environment-variables/

# Gets TAG, HASH, and BRANCH.
macro(aws_git_info)

	# Order isn't too important here, the aim is to make sure the early calls
	# have the least cost so less time is wasted.
	# In this case I call rev-parse first to get the hash because I want it more
	# than I want the branch anyway.  If it's missing, it's a problem.

	# First, get git.
	find_package(Git)
	if(NOT GIT_EXECUTABLE)
		message(FATAL_ERROR "error: could not find git")
	endif()

	# This is called first because it makes sure git exists.
	# It's a relatively cheap call and one that's typically the most important.
	#execute_process(COMMAND "${GIT_BINARY} version"
	execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --verify HEAD
		WORKING_DIRECTORY ${${ACTIVE_PROJECT}___DIRECTORY_ROOT}
		RESULT_VARIABLE GIT_HASH_RESULT
		OUTPUT_VARIABLE GIT_HASH_OUTPUT
		ERROR_VARIABLE GIT_HASH_ERROR
		OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(GIT_HASH_RESULT EQUAL 0)
		set(${ACTIVE_PROJECT}___GIT_HASH ${GIT_HASH_OUTPUT})
	else()
		# This should never fail.  Provided a single commit has gone down, it's fine.
		message("git hash generation error.")
		message("    Result:  '${GIT_HASH_RESULT}'")
		message("    Error:   '${GIT_HASH_ERROR}'")
		message("    Output:  '${GIT_HASH_OUTPUT}'")
		set(${ACTIVE_PROJECT}___GIT_HASH "nogit")
	endif()

	# Fetching the branch is easy, only issue is if the git call fails.
	execute_process(COMMAND ${GIT_EXECUTABLE} branch
		RESULT_VARIABLE GIT_EXIT_CODE
		OUTPUT_VARIABLE GIT_BRANCH
		ERROR_QUIET
		OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(GIT_EXIT_CODE EQUAL 0)
		set(${ACTIVE_PROJECT}___GIT_BRANCH ${GIT_BRANCH})
	else()
		set(${ACTIVE_PROJECT}___GIT_BRANCH "branchless")
	endif()

	# If using Travis CI then the tag is tied to what CI is doing.
	# Since Travis builds based on a given commit this can be used.
	set(ARG --dirty)
	if (DEFINED ENV{TRAVIS_COMMIT})
		set(ARG $ENV{TRAVIS_COMMIT})
	endif()

	# This call actually looks up the 
	execute_process(COMMAND ${GIT_EXECUTABLE} describe ${ARG}
		RESULT_VARIABLE GIT_EXIT_CODE
		OUTPUT_VARIABLE GIT_DESCRIBE
		ERROR_QUIET
		OUTPUT_STRIP_TRAILING_WHITESPACE)
	
	if (GIT_EXIT_CODE EQUAL 0)
		set(${ACTIVE_PROJECT}___GIT_TAG ${GIT_DESCRIBE})
	else()
		set(${ACTIVE_PROJECT}___GIT_TAG "unversioned")
	endif()
endmacro()