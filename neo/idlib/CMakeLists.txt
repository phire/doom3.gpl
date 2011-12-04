CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (idlib)

SET (idlib_SOURCES
	bv/Bounds.cpp
	bv/Frustum.cpp
	bv/Sphere.cpp
	bv/Box.cpp
	geometry/DrawVert.cpp
	geometry/Winding2D.cpp
	geometry/Surface_SweptSpline.cpp
	geometry/Winding.cpp
	geometry/Surface.cpp
	geometry/Surface_Patch.cpp
	geometry/TraceModel.cpp
	geometry/JointTransform.cpp
	hashing/CRC32.cpp
	hashing/MD4.cpp
	hashing/MD5.cpp
	math/Angles.cpp
	math/Lcp.cpp
	math/Math.cpp
	math/Matrix.cpp
	math/Ode.cpp
	math/Plane.cpp
	math/Pluecker.cpp
	math/Polynomial.cpp
	math/Quat.cpp
	math/Rotation.cpp
	math/Simd.cpp
	math/Simd_Generic.cpp
	math/Vector.cpp
	BitMsg.cpp
	LangDict.cpp
	Lexer.cpp
	Lib.cpp
	containers/HashIndex.cpp
	Dict.cpp
	Str.cpp
	Parser.cpp
	MapFile.cpp
	CmdArgs.cpp
	Token.cpp
	Base64.cpp
	Timer.cpp
	Heap.cpp)

IF(UNIX)
  LIST(APPEND idlib_SOURCES
    bv/Frustum_gcc.cpp)
ENDIF()


ADD_LIBRARY (idlib
	${idlib_SOURCES})
