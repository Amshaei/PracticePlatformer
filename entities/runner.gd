extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

@export var speed = 100
var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	apply_gravity(delta)
	handle_acceleration(delta)
	update_animation()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

func handle_acceleration(_delta):
	velocity.x = speed * direction
	move_and_slide()

	# Check for wall collisions
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		print(collision)
		if collision: # Check if there is a collider
				direction *= -1 # Reverse direction
				break # Exit loop after reversing direction

func update_animation():
	animated_sprite_2d.play("default")
	if direction > 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
