CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (doom3)

# Allow subdirectories to access other subdirectories by #include <>
INCLUDE_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR})

# game
ADD_SUBDIRECTORY (game)
