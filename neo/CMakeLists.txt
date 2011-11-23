CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (doom3)

# Allow subdirectories to access other subdirectories by #include <>
INCLUDE_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR})

# game
ADD_SUBDIRECTORY (game)

# renderer
ADD_SUBDIRECTORY (renderer)

# framework
ADD_SUBDIRECTORY (framework)

# ui
ADD_SUBDIRECTORY (ui)

# idlib
ADD_SUBDIRECTORY (idlib)

# cm (collision model ?
ADD_SUBDIRECTORY (cm)
