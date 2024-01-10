extends Area2D


func _ready():
	var callable = Callable(self, "_on_body_entered")
	connect("body_entered", callable)
	
func _on_body_entered(body):
	if body.name == "Player":
		GlobalVars.has_jetpack = true
		queue_free()
