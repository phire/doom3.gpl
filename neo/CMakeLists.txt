CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (doom3)

SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake_modules/")

# Options
OPTION (DEDICATED "Dedicated" OFF)
OPTION (GAME_DLL "Build a seperate game library that gets dynamically linked at runtime" OFF)
OPTION (FORCE32 "Force a 32 bit built on 64 bit systems" OFF)
OPTION (ALSA "Enable ALSA backend support" ON)

#Work around until glimp_logfuncs.cpp generation is included
ADD_DEFINITIONS(-DDISABLE_GLIMP_LOGGING)

# Allow subdirectories to access other subdirectories by #include <>
INCLUDE_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR})
# Allow to link libs from there
LINK_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR})

# CPU architecture 
IF (UNIX)
	EXECUTE_PROCESS (COMMAND uname -m OUTPUT_VARIABLE CPU OUTPUT_STRIP_TRAILING_WHITESPACE)
	IF (CPU STREQUAL "POWERPC")
		SET (CPU "PPC")
	ELSEIF (CPU MATCHES "i.86")
		SET (CPU "X86")
	ENDIF()
ELSE()
	# We are just going to assume that anything not unix is x86
	# Someone should add a check for x86_64 windows later
	SET (CPU "x86")
ENDIF()

# Compiler flags
IF (CMAKE_COMPILER_IS_GNUCXX) # GCC
	# Most of the source now builds without the -fpermissive flag, but there are a 
	# few lines in SoundWorld.cpp which I'm unsure how to fix.
	SET (CMAKE_CXX_FLAGS "-fpermissive -fvisibility=hidden -Wall -Wno-unknown-pragmas")
	SET (CMAKE_C_FLAGS "-fvisibility=hidden -Wall -Wno-unknown-pragmas")

	IF (FORCE32)
		SET (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")
		SET (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")
		SET (CPU "x86")
	ENDIF()
ELSEIF (MSVC) # Visual Studio flags go here
	SET (CMAKE_CXX_FLAGS "")
	SET (CMAKE_C_FLAGS "")
ENDIF()


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

IF (UNIX AND NOT APPLE) # Despite being unix, Apple doesn't primarily use X11
	# X11
	FIND_PACKAGE (X11 REQUIRED)
	INCLUDE_DIRECTORIES (${X11_INCLUDE_DIR})
ENDIF ()

#################################################
SET (core_SOURCES)

# Fill in build hash
INCLUDE(GetGitRevisionDescription)
GET_GIT_HEAD_REVISION(GIT_REFSPEC GIT_SHA1)
CONFIGURE_FILE("sys/git_hash.cpp.in" "${CMAKE_CURRENT_BINARY_DIR}/git_hash.cpp" @ONLY)
LIST (APPEND core_SOURCES "${CMAKE_CURRENT_BINARY_DIR}/git_hash.cpp")

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
  jpeg/jmemdatasrc.c
	tools/compilers/renderbump/renderbump.cpp)
###

# GL
# translated from SConscript.gl

###

# sys
IF (UNIX AND NOT APPLE)
	ADD_CUSTOM_COMMAND (
	  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/glimp_local.h
	  COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_SOURCE_DIR}/sys/linux m4 glimp_local.h.m4 > ${CMAKE_CURRENT_BINARY_DIR}/glimp_local.h
	  DEPENDS sys/linux/glimp_local.h.m4)
	ADD_CUSTOM_COMMAND (
	  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/qgl_enforce.h
	  COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_SOURCE_DIR}/sys/linux m4 qgl_enforce.h.m4 > ${CMAKE_CURRENT_BINARY_DIR}/qgl_enforce.h
	  DEPENDS sys/linux/qgl_enforce.h.m4)

	INCLUDE_DIRECTORIES (${CMAKE_CURRENT_BINARY_DIR})

	SET (m4_SOURCES
	  glimp_stub.cpp.m4
	  glimp_dlopen.cpp.m4)

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
		tools/compilers/dmap/optimize_gcc.cpp
		sys/stub/util_stub.cpp)
	IF (ALSA) 
		LIST (APPEND core_SOURCES sys/linux/sound_alsa.cpp)
	ELSE()
		ADD_DEFINITIONS(-DNO_ALSA)
	ENDIF()
	IF (NOT DEDICATED)
	    ADD_DEFINITIONS(-DGLIMP)
	    FOREACH(f ${m4_SOURCES})
	      ADD_CUSTOM_COMMAND (
	        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${f}.cpp
	        COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_SOURCE_DIR}/sys/linux m4 ${f} > ${CMAKE_CURRENT_BINARY_DIR}/${f}.cpp
	        DEPENDS sys/linux/${f})
	    ENDFOREACH()
  
	    ADD_CUSTOM_COMMAND (
	      OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/gl_extensions.cpp
	      COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_SOURCE_DIR}/sys/gllog m4 gl_extensions.cpp.m4 > ${CMAKE_CURRENT_BINARY_DIR}/gl_extensions.cpp
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
SET (game_SOURCES
	game/AF.cpp
	game/AFEntity.cpp
	game/Actor.cpp
	game/Camera.cpp
	game/Entity.cpp
	game/BrittleFracture.cpp
	game/Fx.cpp
	game/GameEdit.cpp
	game/Game_local.cpp
	game/Game_network.cpp
	game/Item.cpp
	game/IK.cpp
	game/Light.cpp
	game/Misc.cpp
	game/Mover.cpp
	game/Moveable.cpp
	game/MultiplayerGame.cpp
	game/Player.cpp
	game/PlayerIcon.cpp
	game/PlayerView.cpp
	game/Projectile.cpp
	game/Pvs.cpp
	game/SecurityCamera.cpp
	game/SmokeParticles.cpp
	game/Sound.cpp
	game/Target.cpp
	game/Trigger.cpp
	game/Weapon.cpp
	game/WorldSpawn.cpp
	game/ai/AAS.cpp
	game/ai/AAS_debug.cpp
	game/ai/AAS_pathing.cpp
	game/ai/AAS_routing.cpp
	game/ai/AI.cpp
	game/ai/AI_events.cpp
	game/ai/AI_pathing.cpp
	game/ai/AI_Vagary.cpp
	game/gamesys/DebugGraph.cpp
	game/gamesys/Class.cpp
	game/gamesys/Event.cpp
	game/gamesys/SaveGame.cpp
	game/gamesys/SysCmds.cpp
	game/gamesys/SysCvar.cpp
	game/gamesys/TypeInfo.cpp
	game/anim/Anim.cpp
	game/anim/Anim_Blend.cpp
	game/anim/Anim_Import.cpp
	game/anim/Anim_Testmodel.cpp
	game/script/Script_Compiler.cpp
	game/script/Script_Interpreter.cpp
	game/script/Script_Program.cpp
	game/script/Script_Thread.cpp
	game/physics/Clip.cpp
	game/physics/Force.cpp
	game/physics/Force_Constant.cpp
	game/physics/Force_Drag.cpp
	game/physics/Force_Field.cpp
	game/physics/Force_Spring.cpp
	game/physics/Physics.cpp
	game/physics/Physics_AF.cpp
	game/physics/Physics_Actor.cpp
	game/physics/Physics_Base.cpp
	game/physics/Physics_Monster.cpp
	game/physics/Physics_Parametric.cpp
	game/physics/Physics_Player.cpp
	game/physics/Physics_RigidBody.cpp
	game/physics/Physics_Static.cpp
	game/physics/Physics_StaticMulti.cpp
	game/physics/Push.cpp
)

# idlib
SET (idlib_SOURCES
	idlib/bv/Bounds.cpp
	idlib/bv/Frustum.cpp
	idlib/bv/Sphere.cpp
	idlib/bv/Box.cpp
	idlib/geometry/DrawVert.cpp
	idlib/geometry/Winding2D.cpp
	idlib/geometry/Surface_SweptSpline.cpp
	idlib/geometry/Winding.cpp
	idlib/geometry/Surface.cpp
	idlib/geometry/Surface_Patch.cpp
	idlib/geometry/TraceModel.cpp
	idlib/geometry/JointTransform.cpp
	idlib/hashing/CRC32.cpp
	idlib/hashing/MD4.cpp
	idlib/hashing/MD5.cpp
	idlib/math/Angles.cpp
	idlib/math/Lcp.cpp
	idlib/math/Math.cpp
	idlib/math/Matrix.cpp
	idlib/math/Ode.cpp
	idlib/math/Plane.cpp
	idlib/math/Pluecker.cpp
	idlib/math/Polynomial.cpp
	idlib/math/Quat.cpp
	idlib/math/Rotation.cpp
	idlib/math/Simd.cpp
	idlib/math/Simd_Generic.cpp
	idlib/math/Vector.cpp
	idlib/BitMsg.cpp
	idlib/LangDict.cpp
	idlib/Lexer.cpp
	idlib/Lib.cpp
	idlib/containers/HashIndex.cpp
	idlib/Dict.cpp
	idlib/Str.cpp
	idlib/Parser.cpp
	idlib/MapFile.cpp
	idlib/CmdArgs.cpp
	idlib/Token.cpp
	idlib/Base64.cpp
	idlib/Timer.cpp
	idlib/Heap.cpp)

IF(UNIX)
  LIST(APPEND idlib_SOURCES
    idlib/bv/Frustum_gcc.cpp)
ENDIF()

# Unfortunally, building idlib as a seperate library leads to binutil errors
# So we just append to core sources
LIST(APPEND core_SOURCES ${idlib_SOURCES})

IF(GAME_DLL)
	#idlib gets built twice, with diffrent defines
	LIST(APPEND game_SOURCES ${idlib_SOURCES})

	ADD_LIBRARY (game${CPU} SHARED
		${game_SOURCES})
	SET_TARGET_PROPERTIES(game${CPU} PROPERTIES COMPILE_FLAGS "-DGAME_DLL")
	SET_TARGET_PROPERTIES(game${CPU} PROPERTIES PREFIX "")
ELSE()
	# Otherwise we just append game to the main exe
	LIST(APPEND core_SOURCES ${game_SOURCES})
ENDIF()

# Core (actual Doom3 sources)
ADD_EXECUTABLE (doom3
	${core_SOURCES})

IF(GAME_DLL)
	SET_TARGET_PROPERTIES(doom3 PROPERTIES COMPILE_FLAGS "-D__DOOM_DLL__")
ENDIF()

TARGET_LINK_LIBRARIES (doom3
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
