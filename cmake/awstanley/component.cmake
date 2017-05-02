# Copyright (c) 2014-2017 A.W. 'swixel' Stanley.
# All rights reserved.
# Released under the 3-Clause Licence. (3-CLAUSE-BSD)
#
# todo: lowercase the things that shouldn't be uppercased.

# Hacky little helper to load something from the components directory
# without resorting to exposing the include call with variables.
#
# Allows usage in smaller things.
macro(aws_component filename)
	include("${PROJECT_SOURCE_DIR}/components/${filename}")
endmacro()