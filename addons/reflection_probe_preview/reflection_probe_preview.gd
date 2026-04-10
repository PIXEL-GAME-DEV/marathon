@tool
extends EditorPlugin

var _instance: RID
var _mesh: Mesh
var _probe: ReflectionProbe

func _enter_tree() -> void:
	EditorInterface.get_selection().selection_changed.connect(_update_preview)
	_create_instance()

func _exit_tree() -> void:
	EditorInterface.get_selection().selection_changed.disconnect(_update_preview)
	_clear_instance()

func _create_instance() -> void:
	_instance = RenderingServer.instance_create()

	_mesh = SphereMesh.new()
	_mesh.radius = 0.5
	_mesh.height = _mesh.radius * 2.0

	var material = StandardMaterial3D.new()
	material.roughness = 0
	material.metallic = 1
	_mesh.surface_set_material(0, material)

	RenderingServer.instance_geometry_set_cast_shadows_setting(_instance, RenderingServer.SHADOW_CASTING_SETTING_OFF)
	RenderingServer.instance_set_base(_instance, _mesh)

func _clear_instance() -> void:
	if _instance:
		RenderingServer.free_rid(_instance)
	if _mesh:
		RenderingServer.free_rid(_mesh)

func _update_preview() -> void:
	var selection = EditorInterface.get_selection().get_selected_nodes()
	if selection.size() == 1 and selection[0] is ReflectionProbe:
		_probe = selection[0]
		var scenario: RID = EditorInterface.get_edited_scene_root().get_world_3d().scenario
		RenderingServer.instance_set_scenario(_instance, scenario)
		RenderingServer.instance_set_visible(_instance, true)
		return

	RenderingServer.instance_set_visible(_instance, false)
	_probe = null

func _process(_delta: float) -> void:
	if not _instance.is_valid() or not _probe:
		return

	var probe_transform = _probe.global_transform
	var origin_offset = _probe.origin_offset
	var instance_transform = probe_transform * Transform3D(Basis(), origin_offset)
	RenderingServer.instance_set_transform(_instance, instance_transform)