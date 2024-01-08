extends CharacterBody3D
class_name character_Duck

@export var speed = 5.0
@export var acceleration = 4.0
@export var jump_speed =  8.0
@export var rotation_speed = 12.0
@export var mouse_sensitivity = 0.0015

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jumping = false

@onready var model = $character_duck
@onready var spring_arm = $character_duck/SpringArm3D

func _physics_process(delta):
	velocity.y += -gravity * delta
	get_move_input(delta)
	
	move_and_slide()
	
func get_move_input(delta):
	var vy = velocity.y
	velocity.y = 0
	var input = Input.get_vector("left", "right", "forward", "back")
	var dir = Vector3(input.x, 0 , input.y).rotated(Vector3.UP,spring_arm.rotation.y)
	velocity = lerp(velocity, dir * speed, acceleration * delta)
	velocity.y = vy
	
func _unhandled_input(event):
	if event is InputEventMouse:
		spring_arm.rotation.x += event.relative.y * mouse_sensitivity
		spring_arm.rotation_degrees.x = clamp(spring_arm.rotation_degrees.x, -90.0, 30.0 )
		spring_arm.rotation.y -= event.relative.x * mouse_sensitivity
