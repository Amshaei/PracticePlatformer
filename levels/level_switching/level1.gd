extends Node2D

@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D

var next_level = "res://levels/level2.tscn"

func _ready():
	polygon_2d.polygon = collision_polygon_2d.polygon
