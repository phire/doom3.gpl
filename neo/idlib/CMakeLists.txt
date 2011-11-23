CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (idlib)

SET (idlib_SOURCES
	precompiled.cpp
	LangDict.cpp
	Heap.cpp
	Base64.cpp
	bv/Box.cpp
	bv/Frustum_gcc.cpp
	bv/Bounds.cpp
	bv/Sphere.cpp
	bv/Frustum.cpp
	CmdArgs.cpp
	Str.cpp
	hashing/MD5.cpp
	hashing/MD4.cpp
	hashing/CRC32.cpp
	Lib.cpp
	Parser.cpp
	math/Polynomial.cpp
	math/Simd_MMX.cpp
	math/Rotation.cpp
	math/Simd_3DNow.cpp
	math/Vector.cpp
	math/Ode.cpp
	math/Simd_SSE3.cpp
	math/Simd_SSE.cpp
	math/Matrix.cpp
	math/Plane.cpp
	math/Complex.cpp
	math/Simd_Generic.cpp
	math/Lcp.cpp
	math/Angles.cpp
	math/Pluecker.cpp
	math/Simd_SSE2.cpp
	math/Simd.cpp
	math/Math.cpp
	math/Quat.cpp
	geometry/Surface_Polytope.cpp
	geometry/Winding2D.cpp
	geometry/Surface_SweptSpline.cpp
	geometry/TraceModel.cpp
	geometry/JointTransform.cpp
	geometry/DrawVert.cpp
	geometry/Surface_Patch.cpp
	geometry/Surface.cpp
	geometry/Winding.cpp
	Timer.cpp
	MapFile.cpp
	Token.cpp
	BitMsg.cpp
	containers/HashIndex.cpp
	Lexer.cpp
	Dict.cpp)

# FIXME: when I have to built this? 
IF (FALSE)
	LIST (APPEND idlib_SOURCES
		math/Simd_AltiVec.cpp)
ENDIF ()

ADD_LIBRARY (idlib
	${idlib_SOURCES})
