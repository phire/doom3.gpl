FIND_PATH(ASOUND_INCLUDE_DIR NAMES alsa/asoundlib.h)
FIND_LIBRARY(ASOUND_LIBRARY NAMES asound)

IF (ASOUND_INCLUDE_DIR AND ASOUND_LIBRARY)
   SET(ASOUND_FOUND TRUE)
ENDIF (ASOUND_INCLUDE_DIR AND ASOUND_LIBRARY)

IF (ASOUND_FOUND)
   IF (NOT ASOUND_FIND_QUIETLY)
      MESSAGE(STATUS "Found asound: ${ASOUND_LIBRARY}")
   ENDIF (NOT ASOUND_FIND_QUIETLY)
ELSE (ASOUND_FOUND)
   IF (ASOUND_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find asound-dev")
   ENDIF (ASOUND_FIND_REQUIRED)
ENDIF (ASOUND_FOUND)
