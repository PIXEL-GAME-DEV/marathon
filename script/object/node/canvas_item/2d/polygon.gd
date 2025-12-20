@tool
class_name Polygon2DPlus
extends Node2D


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


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	draw_polygon(points, colors, uvs, texture)
