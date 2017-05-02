# Copyright (c) 2014-2017 A.W. 'swixel' Stanley.
# All rights reserved.
# Released under the 3-Clause Licence. (3-CLAUSE-BSD)

# aws_unwind
# This unwinds a list into source_group and stores files in ${outvar}.
# e.g. unwind_source_groups(LUA_SOURCE_GROUPS ${EXE_FILES})
#
# This has evolved over the years but should be relatively backwards
# compatible.
#
# An example of this is in `unwind.example`
macro(aws_unwind list outvar)
	set(SGLEN 0)
	set(SGPOS 0)
	list(LENGTH ${list} SGLEN)
	if(NOT ${SGLEN} EQUAL ${SGPOS})
		while(TRUE)
			set(SGNAME "")
			set(SGLISTNAME "")
			set(SGLIST "")
			list(GET ${list} ${SGPOS} SGNAME)
			math(EXPR SGPOS "${SGPOS}+1")
			if(${SGPOS} EQUAL ${SGLEN})
				break()
			endif()
			list(GET ${list} ${SGPOS} SGLISTNAME)
			math(EXPR SGPOS "${SGPOS}+1")
			foreach(a ${${SGLISTNAME}})
				list(APPEND SGLIST ${a})
				list(APPEND ${outvar} ${a})
			endforeach()
			source_group(${SGNAME} FILES ${SGLIST})
			if(${SGPOS} EQUAL ${SGLEN})
				break()
			endif()
		endwhile()
	endif()
endmacro()