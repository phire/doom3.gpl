CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (doom3)

# Allow subdirectories to access other subdirectories by #include <>
INCLUDE_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR})

# SCons uses these
ADD_DEFINITIONS (-D_D3XP -DCTF -DGAME_DLL)

# d3xp
ADD_SUBDIRECTORY (d3xp)

# game
ADD_SUBDIRECTORY (game)

# renderer
ADD_SUBDIRECTORY (renderer)

# ui
ADD_SUBDIRECTORY (ui)

# idlib
ADD_SUBDIRECTORY (idlib)
