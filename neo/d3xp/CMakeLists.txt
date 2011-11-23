CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (d3xp)

SET (d3xp_SOURCES
	Target.cpp
	PlayerIcon.cpp
	physics/Physics_Static.cpp
	physics/Physics_Actor.cpp
	physics/Physics_StaticMulti.cpp
	physics/Physics_Base.cpp
	physics/Physics_Player.cpp
	physics/Force_Constant.cpp
	physics/Force_Field.cpp
	physics/Physics_RigidBody.cpp
	physics/Physics_Parametric.cpp
	physics/Clip.cpp
	physics/Physics_AF.cpp
	physics/Force_Grab.cpp
	physics/Force_Drag.cpp
	physics/Physics_Monster.cpp
	physics/Force_Spring.cpp
	physics/Physics.cpp
	physics/Push.cpp
	physics/Force.cpp
	anim/Anim_Import.cpp
	anim/Anim_Testmodel.cpp
	anim/Anim.cpp
	anim/Anim_Blend.cpp
	AF.cpp
	Fx.cpp
	Weapon.cpp
	Projectile.cpp
	Misc.cpp
	Sound.cpp
	WorldSpawn.cpp
	IK.cpp
	Game_network.cpp
	PlayerView.cpp
	Mover.cpp
	Light.cpp
	Entity.cpp
	Moveable.cpp
	GameEdit.cpp
	Actor.cpp
	SmokeParticles.cpp
	Item.cpp
	Trigger.cpp
	script/Script_Interpreter.cpp
	script/Script_Thread.cpp
	script/Script_Program.cpp
	script/Script_Compiler.cpp
	AFEntity.cpp
	Camera.cpp
	Grabber.cpp
	Game_local.cpp
	Player.cpp
	MultiplayerGame.cpp
	gamesys/Class.cpp
	gamesys/SysCmds.cpp
	gamesys/DebugGraph.cpp
	gamesys/TypeInfo.cpp
	gamesys/SysCvar.cpp
	gamesys/SaveGame.cpp
	gamesys/Event.cpp
	SecurityCamera.cpp
	BrittleFracture.cpp
	ai/AAS_debug.cpp
	ai/AI_pathing.cpp
	ai/AI.cpp
	ai/AAS.cpp
	ai/AAS_pathing.cpp
	ai/AAS_routing.cpp
	ai/AI_events.cpp
	ai/AI_Vagary.cpp
	Pvs.cpp)

# FIXME: When I manage to get all these ugly macros work...
IF (FALSE)
	LIST (APPEND d3xp_SOURCES
		EndLevel.cpp)
ENDIF ()

ADD_LIBRARY (d3xp
	${d3xp_SOURCES})
