CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (sys)

# Only linux version at this moment
FIND_PACKAGE (Threads REQUIRED)

SET (sys_SOURCES
	sys_local.cpp
	posix/posix_net.cpp
	posix/posix_main.cpp
	posix/posix_signal.cpp
	posix/posix_threads.cpp
	linux/stack.cpp
	linux/main.cpp
	stub/util_stub.cpp)

ADD_EXECUTABLE (sys
	${sys_SOURCES})

# Additional libs
SET (sys_LIBS
	${CMAKE_THREAD_LIBS_INIT})

# D3 libs
LIST (APPEND sys_LIBS
	idlib
	framework)

TARGET_LINK_LIBRARIES (sys
	${sys_LIBS})
