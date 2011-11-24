CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
PROJECT (renderer)

SET (renderer_SOURCES
	Cinematic.cpp
	GuiModel.cpp
	Image_files.cpp
	Image_init.cpp
	Image_load.cpp
	Image_process.cpp
	Image_program.cpp
	Interaction.cpp
	Material.cpp
	MegaTexture.cpp
	Model.cpp
	ModelDecal.cpp
	ModelManager.cpp
	ModelOverlay.cpp
	Model_beam.cpp
	Model_ase.cpp
	Model_liquid.cpp
	Model_lwo.cpp
	Model_ma.cpp
	Model_md3.cpp
	Model_md5.cpp
	Model_prt.cpp
	Model_sprite.cpp
	RenderEntity.cpp
	RenderSystem.cpp
	RenderSystem_init.cpp
	RenderWorld.cpp
	RenderWorld_demo.cpp
	RenderWorld_load.cpp
	RenderWorld_portals.cpp
	VertexCache.cpp
	cg_explicit.cpp
	draw_arb.cpp
	draw_arb2.cpp
	draw_common.cpp
	draw_exp_stub.cpp
	draw_nv10.cpp
	draw_nv20.cpp
	draw_r200.cpp
	tr_backend.cpp
	tr_deform.cpp
	tr_font.cpp
	tr_guisurf.cpp
	tr_light.cpp
	tr_lightrun.cpp
	tr_main.cpp
	tr_orderIndexes.cpp
	tr_polytope.cpp
	tr_render.cpp
	tr_rendertools.cpp
	tr_shadowbounds.cpp
	tr_stencilshadow.cpp
	tr_subview.cpp
	tr_trace.cpp
	tr_trisurf.cpp
	tr_turboshadow.cpp)

ADD_LIBRARY (renderer
	${renderer_SOURCES})
