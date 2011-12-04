CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (doom3)

SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake_modules/")

# Options
OPTION (DEDICATED "Dedicated" OFF)

# Allow subdirectories to access other subdirectories by #include <>
INCLUDE_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR})
# Allow to link libs from there
LINK_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR})

# Most of the source now builds without this flag, but there are a 
# few lines in SoundWorld.cpp which I'm unsure how to fix.
SET (CMAKE_CXX_FLAGS "-fpermissive")

#################################################
# PACKAGES
#################################################

# Removed internal CURL, let CMake find it
FIND_PACKAGE (CURL REQUIRED)

FIND_PACKAGE (JPEG REQUIRED)
INCLUDE_DIRECTORIES (${JPEG_INCLUDE_DIR})

#Find Vorbis Libs
FIND_PACKAGE (Vorbis REQUIRED)
INCLUDE_DIRECTORIES (${VORBIS_INCLUDE_DIR})
FIND_PACKAGE (VorbisFile REQUIRED)
INCLUDE_DIRECTORIES (${VORBISFILE_INCLUDE_DIR})

# GL ?
FIND_PACKAGE (OpenGL REQUIRED)
INCLUDE_DIRECTORIES (${OPENGL_INCLUDE_DIR})

# OpenAL - external
FIND_PACKAGE (OpenAL REQUIRED)
INCLUDE_DIRECTORIES (${OPENAL_INCLUDE_DIR})

IF (UNIX)
	# X11
	FIND_PACKAGE (X11 REQUIRED)
	INCLUDE_DIRECTORIES (${X11_INCLUDE_DIR})
ENDIF ()

#################################################
SET (core_SOURCES)

ADD_CUSTOM_COMMAND (
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/glimp_local.h
  COMMAND ${CMAKE_COMMAND} -E chdir sys/linux m4 glimp_local.h.m4 > ${CMAKE_CURRENT_BINARY_DIR}/glimp_local.h
  DEPENDS sys/linux/glimp_local.h.m4)
ADD_CUSTOM_COMMAND (
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/qgl_enforce.h
  COMMAND ${CMAKE_COMMAND} -E chdir sys/linux m4 qgl_enforce.h.m4 > ${CMAKE_CURRENT_BINARY_DIR}/qgl_enforce.h
  DEPENDS sys/linux/qgl_enforce.h.m4)

INCLUDE_DIRECTORIES (${CMAKE_CURRENT_BINARY_DIR})

SET (m4_SOURCES
  glimp_stub.cpp.m4
  glimp_dlopen.cpp.m4)


# renderer
LIST (APPEND core_SOURCES
	renderer/Cinematic.cpp
	renderer/GuiModel.cpp
	renderer/Image_files.cpp
	renderer/Image_init.cpp
	renderer/Image_load.cpp
	renderer/Image_process.cpp
	renderer/Image_program.cpp
	renderer/Interaction.cpp
	renderer/Material.cpp
	renderer/MegaTexture.cpp
	renderer/Model.cpp
	renderer/ModelDecal.cpp
	renderer/ModelManager.cpp
	renderer/ModelOverlay.cpp
	renderer/Model_beam.cpp
	renderer/Model_ase.cpp
	renderer/Model_liquid.cpp
	renderer/Model_lwo.cpp
	renderer/Model_ma.cpp
	renderer/Model_md3.cpp
	renderer/Model_md5.cpp
	renderer/Model_prt.cpp
	renderer/Model_sprite.cpp
	renderer/RenderEntity.cpp
	renderer/RenderSystem.cpp
	renderer/RenderSystem_init.cpp
	renderer/RenderWorld.cpp
	renderer/RenderWorld_demo.cpp
	renderer/RenderWorld_load.cpp
	renderer/RenderWorld_portals.cpp
	renderer/VertexCache.cpp
	renderer/cg_explicit.cpp
	renderer/draw_arb.cpp
	renderer/draw_arb2.cpp
	renderer/draw_common.cpp
	renderer/draw_exp_stub.cpp
	renderer/draw_nv10.cpp
	renderer/draw_nv20.cpp
	renderer/draw_r200.cpp
	renderer/tr_backend.cpp
	renderer/tr_deform.cpp
	renderer/tr_font.cpp
	renderer/tr_guisurf.cpp
	renderer/tr_light.cpp
	renderer/tr_lightrun.cpp
	renderer/tr_main.cpp
	renderer/tr_orderIndexes.cpp
	renderer/tr_polytope.cpp
	renderer/tr_render.cpp
	renderer/tr_rendertools.cpp
	renderer/tr_shadowbounds.cpp
	renderer/tr_stencilshadow.cpp
	renderer/tr_subview.cpp
	renderer/tr_trace.cpp
	renderer/tr_trisurf.cpp
	renderer/tr_turboshadow.cpp)

# framework
LIST (APPEND core_SOURCES
	framework/CVarSystem.cpp
	framework/CmdSystem.cpp
	framework/Common.cpp
	framework/Compressor.cpp
	framework/Console.cpp
	framework/DemoFile.cpp
	framework/DeclAF.cpp
	framework/DeclEntityDef.cpp
	framework/DeclFX.cpp
	framework/DeclManager.cpp
	framework/DeclParticle.cpp
	framework/DeclPDA.cpp
	framework/DeclSkin.cpp
	framework/DeclTable.cpp
	framework/EditField.cpp
	framework/EventLoop.cpp
	framework/File.cpp
	framework/FileSystem.cpp
	framework/KeyInput.cpp
	framework/Unzip.cpp
	framework/UsercmdGen.cpp
	framework/Session_menu.cpp
	framework/Session.cpp
	framework/async/AsyncClient.cpp
	framework/async/AsyncNetwork.cpp
	framework/async/AsyncServer.cpp
	framework/async/MsgChannel.cpp
	framework/async/NetworkSystem.cpp
	framework/async/ServerScan.cpp)

# cm
LIST (APPEND core_SOURCES
	cm/CollisionModel_contacts.cpp
	cm/CollisionModel_contents.cpp
	cm/CollisionModel_debug.cpp
	cm/CollisionModel_files.cpp
	cm/CollisionModel_load.cpp
	cm/CollisionModel_rotate.cpp
	cm/CollisionModel_trace.cpp
	cm/CollisionModel_translate.cpp)

# ui
LIST (APPEND core_SOURCES
	ui/BindWindow.cpp
	ui/ChoiceWindow.cpp
	ui/DeviceContext.cpp
	ui/EditWindow.cpp
	ui/FieldWindow.cpp
	ui/GameBearShootWindow.cpp
	ui/GameBustOutWindow.cpp
	ui/GameSSDWindow.cpp
	ui/GuiScript.cpp
	ui/ListGUI.cpp
	ui/ListWindow.cpp
	ui/MarkerWindow.cpp
	ui/RegExp.cpp
	ui/RenderWindow.cpp
	ui/SimpleWindow.cpp
	ui/SliderWindow.cpp
	ui/UserInterface.cpp
	ui/Window.cpp
	ui/Winvar.cpp)
 
# sound
LIST (APPEND core_SOURCES
	sound/snd_cache.cpp
	sound/snd_decoder.cpp
	sound/snd_efxfile.cpp
	sound/snd_emitter.cpp
	sound/snd_shader.cpp
	sound/snd_system.cpp
	sound/snd_wavefile.cpp
	sound/snd_world.cpp)

### TOOLS ###
# aas
LIST (APPEND core_SOURCES
	tools/compilers/aas/AASBuild.cpp
	tools/compilers/aas/AASBuild_file.cpp
	tools/compilers/aas/AASBuild_gravity.cpp
	tools/compilers/aas/AASBuild_ledge.cpp
	tools/compilers/aas/AASBuild_merge.cpp
	tools/compilers/aas/AASCluster.cpp
	tools/compilers/aas/AASFile.cpp
	tools/compilers/aas/AASFile_optimize.cpp
	tools/compilers/aas/AASFile_sample.cpp
	tools/compilers/aas/AASReach.cpp
	tools/compilers/aas/AASFileManager.cpp
	tools/compilers/aas/Brush.cpp
	tools/compilers/aas/BrushBSP.cpp)
# dmap
LIST (APPEND core_SOURCES
	tools/compilers/dmap/dmap.cpp
	tools/compilers/dmap/facebsp.cpp
	tools/compilers/dmap/gldraw.cpp
	tools/compilers/dmap/glfile.cpp
	tools/compilers/dmap/leakfile.cpp
	tools/compilers/dmap/map.cpp
	tools/compilers/dmap/optimize.cpp
	tools/compilers/dmap/output.cpp
	tools/compilers/dmap/portals.cpp
	tools/compilers/dmap/shadowopt3.cpp
	tools/compilers/dmap/tritjunction.cpp
	tools/compilers/dmap/tritools.cpp
	tools/compilers/dmap/ubrush.cpp
	tools/compilers/dmap/usurface.cpp)

LIST (APPEND core_SOURCES
  tools/compilers/roqvq/roq.cpp
  tools/compilers/roqvq/roqParam.cpp
  tools/compilers/roqvq/codec.cpp
  tools/compilers/roqvq/NSBitmapImageRep.cpp
	tools/compilers/renderbump/renderbump.cpp)
###

# GL
# translated from SConscript.gl

###

# sys

IF (UNIX)
  INCLUDE_DIRECTORIES(sys/linux/oss/include)
	LIST (APPEND core_SOURCES
		sys/sys_local.cpp
		sys/posix/posix_net.cpp
		sys/posix/posix_main.cpp
		sys/posix/posix_signal.cpp
		sys/posix/posix_threads.cpp
		sys/linux/stack.cpp
		sys/linux/main.cpp
		sys/linux/sound.cpp
		sys/linux/sound_alsa.cpp
	  tools/compilers/dmap/optimize_gcc.cpp
		sys/stub/util_stub.cpp)
	IF (NOT DEDICATED)
    ADD_DEFINITIONS(-DGLIMP)
    FOREACH(f ${m4_SOURCES})
      ADD_CUSTOM_COMMAND (
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${f}.cpp
        COMMAND ${CMAKE_COMMAND} -E chdir sys/linux m4 ${f} > ${CMAKE_CURRENT_BINARY_DIR}/${f}.cpp
        DEPENDS sys/linux/${f})
    ENDFOREACH()
  
    ADD_CUSTOM_COMMAND (
      OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/gl_extensions.cpp
      COMMAND ${CMAKE_COMMAND} -E chdir sys/gllog m4 gl_extensions.cpp.m4 > ${CMAKE_CURRENT_BINARY_DIR}/gl_extensions.cpp
      DEPENDS sys/gllog/gl_extensions.cpp.m4)

		LIST (APPEND core_SOURCES
      ${CMAKE_CURRENT_BINARY_DIR}/gl_extensions.cpp
      ${CMAKE_CURRENT_BINARY_DIR}/glimp_local.h
      ${CMAKE_CURRENT_BINARY_DIR}/qgl_enforce.h
      ${CMAKE_CURRENT_BINARY_DIR}/glimp_dlopen.cpp.m4.cpp
			sys/linux/glimp.cpp
			sys/posix/posix_input.cpp
			sys/linux/input.cpp
			sys/linux/libXNVCtrl/NVCtrl.c)
	ELSE ()
		LIST (APPEND core_SOURCES
      ${CMAKE_CURRENT_BINARY_DIR}/gl_extensions.cpp
      ${CMAKE_CURRENT_BINARY_DIR}/glimp_stub.cpp.m4.cpp
			linux/dedicated.cpp)
	ENDIF ()
ENDIF ()


# Game
ADD_SUBDIRECTORY (game)
# idlib
ADD_SUBDIRECTORY (idlib)

# Core (actual Doom3 sources)
ADD_EXECUTABLE (doom3
	${core_SOURCES})

TARGET_LINK_LIBRARIES (doom3
	game
	idlib
	pthread
	Xxf86vm
	${OPENGL_gl_LIBRARY}
	${OPENGL_glu_LIBRARY}
	${VORBIS_LIBRARY}
  ${VORBISFILE_LIBRARY}
  ${OPENAL_LIBRARY}
	${CURL_LIBRARY}
  ${JPEG_LIBRARY}
	${X11_LIBRARIES})
