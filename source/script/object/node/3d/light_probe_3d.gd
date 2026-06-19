@tool class_name LightProbe3D extends Node3D


@export var size := 1.0:
	set(value):
		size = clampf(value, 0 , INF)
		if _mesh_instance:
			_mesh_instance.scale = Vector3(1.414, 1, 1.414) * size
		if _cam1:
			_cam1.size = size
			_cam1.far = size
		if _cam2:
			_cam2.size = size
			_cam2.far = size
		if _remote_transform1:
			_remote_transform1.position = Vector3.UP * size
		if _remote_transform2:
			_remote_transform2.position = Vector3.DOWN * size

@export var color: Color

@export var luminance: float


var _mesh: Mesh = preload("res://mesh/primitive/octahedron.tres")

var _material: Material = preload("res://material/shader/spatial/light_probe.tres")

var _mesh_instance: MeshInstance3D:
	set(value):
		if _mesh_instance:
			_mesh_instance.queue_free()
		_mesh_instance = value
		_mesh_instance.mesh = _mesh
		_mesh_instance.material_override = _material
		_mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		add_child(_mesh_instance)
		_mesh_instance.owner = self
		_mesh_instance.rotation.y = PI/4
		_mesh_instance.scale = Vector3(1.414, 1, 1.414) * size

var _view1: SubViewport:
	set(value):
		if _view1:
			_view1.queue_free()
		_view1 = value
		_view1.size = Vector2i(4, 4)
		_view1.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
		_view1.render_target_update_mode = SubViewport.UPDATE_ALWAYS
		_view1.debug_draw = Viewport.DEBUG_DRAW_LIGHTING
		add_child(_view1)
		_view1.owner = self

var _view2: SubViewport:
	set(value):
		if _view2:
			_view2.queue_free()
		_view2 = value
		_view2.size = Vector2i(4, 4)
		_view2.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
		_view2.render_target_update_mode = SubViewport.UPDATE_ALWAYS
		_view2.debug_draw = Viewport.DEBUG_DRAW_LIGHTING
		add_child(_view2)
		_view2.owner = self

var _cam1: Camera3D:
	set(value):
		if _cam1:
			_cam1.queue_free()
		_cam1 = value
		_cam1.projection = Camera3D.PROJECTION_ORTHOGONAL
		_view1.add_child(_cam1)
		_cam1.owner = self

var _cam2: Camera3D:
	set(value):
		if _cam2:
			_cam2.queue_free()
		_cam2 = value
		_cam2.projection = Camera3D.PROJECTION_ORTHOGONAL
		_view2.add_child(_cam2)
		_cam2.owner = self

var _remote_transform1: RemoteTransform3D:
	set(value):
		if _remote_transform1:
			_remote_transform1.queue_free()
		_remote_transform1 = value
		add_child(_remote_transform1)
		_remote_transform1.owner = self
		_remote_transform1.remote_path = _remote_transform1.get_path_to(_cam1)
		_remote_transform1.position = Vector3.UP * size
		#_remote_transform1.position = Vector3.ZERO
		_remote_transform1.rotation.x = -PI/2

var _remote_transform2: RemoteTransform3D:
	set(value):
		if _remote_transform2:
			_remote_transform2.queue_free()
		_remote_transform2 = value
		add_child(_remote_transform2)
		_remote_transform2.owner = self
		_remote_transform2.remote_path = _remote_transform2.get_path_to(_cam2)
		_remote_transform2.position = Vector3.DOWN * size
		#_remote_transform2.position = Vector3.ZERO
		_remote_transform2.rotation.x = PI/2


func _init() -> void:
	_mesh_instance = MeshInstance3D.new()
	_view1 = SubViewport.new()
	_view2 = SubViewport.new()
	_cam1 = Camera3D.new()
	_cam2 = Camera3D.new()
	_remote_transform1 = RemoteTransform3D.new()
	_remote_transform2 = RemoteTransform3D.new()


func _process(_delta: float) -> void:
	get_color()


func get_color():
	await RenderingServer.frame_post_draw
	
	var _image1 := _view1.get_texture().get_image()
	_image1.resize(1, 1, Image.INTERPOLATE_LANCZOS)
	var _image2 := _view2.get_texture().get_image()
	_image2.resize(1, 1, Image.INTERPOLATE_LANCZOS)
	
	color = (_image1.get_pixel(0, 0) + _image2.get_pixel(0, 0))/2
	luminance = color.get_luminance()
