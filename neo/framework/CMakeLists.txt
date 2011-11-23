CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (framework)

FIND_PACKAGE (CURL REQUIRED)

SET (framework_SOURCES
	CVarSystem.cpp
	CmdSystem.cpp
	Common.cpp
	Compressor.cpp
	Console.cpp
	DemoFile.cpp
	DeclAF.cpp
	DeclEntityDef.cpp
	DeclFX.cpp
	DeclManager.cpp
	DeclParticle.cpp
	DeclPDA.cpp
	DeclSkin.cpp
	DeclTable.cpp
	EditField.cpp
	EventLoop.cpp
	File.cpp
	FileSystem.cpp
	KeyInput.cpp
	Unzip.cpp
	UsercmdGen.cpp
	Session_menu.cpp
	Session.cpp
	async/AsyncClient.cpp
	async/AsyncNetwork.cpp
	async/AsyncServer.cpp
	async/MsgChannel.cpp
	async/NetworkSystem.cpp
	async/ServerScan.cpp)

ADD_LIBRARY (framework
	${framework_SOURCES})

TARGET_LINK_LIBRARIES (framework
	${CURL_LIBRARIES})
