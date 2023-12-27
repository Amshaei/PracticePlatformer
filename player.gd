extends CharacterBody2D 


const SPEED = 100.0
const ACCELERATION = 600.0 # change in velocity over time
const FRICTION = 1000.0
const JUMP_VELOCITY = -300.0 # y axis is negative going up
const JETPACK_FORCE = 50.0
const JETPACK_CONSUMPTION_RATE = 1.0
var jetpack_fuel = 100.0
var max_fuel = 100.0
var jetpack_max_velocity = -200
var has_jumped = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var world = get_tree().current_scene
@onready var hud = world.get_node("Hud")

func _ready():
	hud.set_max_fuel(max_fuel)

func _physics_process(delta):
	print("Jetpack Fuel: ", jetpack_fuel)
	apply_gravity(delta)
	handle_jump()
	
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	update_animations(input_axis)
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump():
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
		else:
			if (jetpack_fuel <= max_fuel):
				jetpack_fuel += JETPACK_CONSUMPTION_RATE * 2
	else: # in air
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
		if Input.is_action_pressed("ui_accept"):
			handle_jetpack()

func handle_jetpack():
	if jetpack_fuel > 0:
		velocity.y -= JETPACK_FORCE
		velocity.y = max(velocity.y, jetpack_max_velocity)
		jetpack_fuel -= JETPACK_CONSUMPTION_RATE
	else:
		print("Out of fuel!")

func handle_acceleration(input_axis, delta):
	if input_axis:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)

func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func update_animations(input_axis):
	if input_axis:
		animated_sprite_2d.flip_h = (input_axis < 0)
		collision_shape_2d.scale.x = input_axis
		animated_sprite_2d.play("run")
	else: 
		animated_sprite_2d.play("idle")
		
	if not is_on_floor():
		animated_sprite_2d.play("jump")
