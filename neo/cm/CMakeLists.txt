CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (cm)

SET (cm_SOURCES
	CollisionModel_contacts.cpp
	CollisionModel_contents.cpp
	CollisionModel_debug.cpp
	CollisionModel_files.cpp
	CollisionModel_load.cpp
	CollisionModel_rotate.cpp
	CollisionModel_trace.cpp
	CollisionModel_translate.cpp)

ADD_LIBRARY (cm
	${cm_SOURCES})
