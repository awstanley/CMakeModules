# Copyright (c) 2014-2017 A.W. 'swixel' Stanley.
# All rights reserved.
# Released under the 3-Clause Licence. (3-CLAUSE-BSD)
#
# This particular file is just a loader for the subprojects.
# The CMake file using this must point `AWS_CMAKE_DIRECTORY` to
# the directory containing this.  The typical loading methood is:
#
#    set(
#        AWS_CMAKE_DIRECTORY
#        "${PROJECT_SOURCE_DIR}/cmake/awstanley"
#    )
#    include("${AWS_CMAKE_DIRECTORY}.cmake")
#
# This makes it easier to load this file and the utilities below.
#
# See `awstanley.example` for a trivial project that uses this.
# Note that `awstanley.example` assumes the project has this folder
# in `cmake`

include("${AWS_CMAKE_DIRECTORY}/component.cmake")
include("${AWS_CMAKE_DIRECTORY}/subproject.cmake")
include("${AWS_CMAKE_DIRECTORY}/unwind.cmake")
include("${AWS_CMAKE_DIRECTORY}/define.cmake")