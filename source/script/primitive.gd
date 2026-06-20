@tool class_name Primitive2D extends Node2D


@export var points: PackedVector2Array:
	set(value):
		points = value
		queue_redraw()

@export var colors: PackedColorArray:
	set(value):
		colors = value
		queue_redraw()

@export var uvs: PackedVector2Array:
	set(value):
		uvs = value
		queue_redraw()

@export var texture: Texture2D:
	set(value):
		texture = value
		queue_redraw()


func _draw() -> void:
	draw_primitive(points, colors, uvs, texture)
