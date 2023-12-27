extends Area2D

# Add a Timer node to your scene and set its wait time to a very small value.
@onready var timer = Timer.new()
@onready var hud = get_tree().current_scene.get_node("Hud")

func _ready():
	add_child(timer)
	var callable = Callable(self, "_on_body_entered")
	connect("body_entered", callable)

func _on_body_entered(body):
	if body.name == "Player":
		timer.start(0.001)  # Start the timer
		await timer.timeout  # Wait for the timer to timeout
		var new_level_path = get_tree().current_scene.next_level
		var new_level_resource = load(new_level_path)
		if new_level_resource is PackedScene:
			var new_level = new_level_resource.instantiate()
			# Add the new level to the scene tree before getting the 'Hud' node.
			get_tree().root.add_child(new_level)
			# Get the 'Hud' node from the new level.
			var hud = new_level.get_node("Hud")
			# Initialize the 'Hud' node.
			var current_scene = get_tree().current_scene
			body.queue_free()  # Destroy the player
			current_scene.queue_free()
			
