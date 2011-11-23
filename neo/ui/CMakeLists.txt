CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (ui)

SET (ui_SOURCES
	FieldWindow.cpp
	GameSSDWindow.cpp
	SimpleWindow.cpp
	RegExp.cpp
	ListGUI.cpp
	GameWindow.cpp
	Winvar.cpp
	EditWindow.cpp
	SliderWindow.cpp
	ChoiceWindow.cpp
	UserInterface.cpp
	GameBustOutWindow.cpp
	DeviceContext.cpp
	RenderWindow.cpp
	ListWindow.cpp
	GuiScript.cpp
	BindWindow.cpp
	GameBearShootWindow.cpp
	MarkerWindow.cpp
	Window.cpp)

ADD_LIBRARY (ui
	${ui_SOURCES})
