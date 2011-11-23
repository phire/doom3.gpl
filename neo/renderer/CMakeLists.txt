CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (renderer)

SET (renderer_SOURCES
	RenderWorld_portals.cpp
	tr_main.cpp
	tr_polytope.cpp
	Model_ma.cpp
	RenderSystem_init.cpp
	draw_nv20.cpp
	cg_explicit.cpp
	tr_render.cpp
	tr_subview.cpp
	tr_guisurf.cpp
	Model_beam.cpp
	Material.cpp
	tr_shadowbounds.cpp
	RenderWorld.cpp
	tr_backend.cpp
	Model.cpp
	tr_font.cpp
	Image_init.cpp
	Model_lwo.cpp
	ModelDecal.cpp
	RenderWorld_demo.cpp
	tr_orderIndexes.cpp
	ModelManager.cpp
	VertexCache.cpp
	Cinematic.cpp
	tr_lightrun.cpp
	Model_md3.cpp
	tr_deform.cpp
	Model_ase.cpp
	Image_program.cpp
	draw_r200.cpp
	GuiModel.cpp
	draw_arb2.cpp
	draw_common.cpp
	draw_nv10.cpp
	ModelOverlay.cpp
	tr_rendertools.cpp
	Model_md5.cpp
	Model_prt.cpp
	Image_load.cpp
	RenderWorld_load.cpp
	RenderEntity.cpp
	tr_trace.cpp
	tr_trisurf.cpp
	draw_arb.cpp
	Image_process.cpp
	tr_light.cpp
	Image_files.cpp
	draw_exp_stub.cpp
	Interaction.cpp
	tr_turboshadow.cpp
	RenderSystem.cpp
	Model_liquid.cpp
	tr_stencilshadow.cpp
	Model_sprite.cpp
	MegaTexture.cpp)

IF (WIN32)
	LIST (APPEND renderer_SOURCES
		draw_exp.cpp)
ENDIF (WIN32)

ADD_LIBRARY (renderer
	${renderer_SOURCES})
