extends KinematicBody2D

export (int) var speed = 350
const GRAVITY = 1200

var velocity = Vector2()
var friction = 0.025
var acceleration = 0.07

func get_input():
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
	if Input.is_action_pressed("left"):
		dir -= 1
	if dir != 0:
		# accelerate when there's input
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		# slow down when there's no input
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	get_input()
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity)

func _on_Bullet_teleport(target):
	velocity = Vector2()
	global_position = target
