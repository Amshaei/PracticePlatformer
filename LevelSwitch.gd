extends Area2D

var levels = []
var current_level_index = 0

@onready var current_level = $"../Start"
@onready var player = $"../Player"

func _ready():
	var callable = Callable(self, "_on_body_entered")
	connect("body_entered", callable)

	var dir = DirAccess.open("res://levels/level_switching/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tscn"):
				var level = {
					"scene": load("res://levels/level_switching/" + file_name),
					"player_position": Vector2(32, 0)  # replace with the desired player position
				}
				levels.append(level)
			file_name = dir.get_next()

func _on_body_entered(body):
	if body.name == "Player":
		if current_level_index < levels.size():
			var level = levels[current_level_index]
			var scene = level["scene"].instantiate()
			current_level.queue_free()
			get_tree().get_root().add_child(scene)
			current_level = scene
			player.position = level["player_position"]
			current_level_index += 1
