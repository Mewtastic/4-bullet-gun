extends KinematicBody2D

export (int) var speed = 350
const GRAVITY = 1200
signal update_health()

var health = 100
var velocity = Vector2()
var friction = 0.025
var acceleration = 0.07

var frame = 0
var regen = 1 # Health gained per frame that regen activates
var regen_rate = 30 # The number of frames before regen activates

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

func _process(delta):
	get_input()
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity)
	if health < 100: # Regen
		frame += 1
		if frame == regen_rate:
			health += regen
			frame = 0
			if health >= 100:
				health == 100
			emit_signal("update_health", int(health)) # Update health bar

func _on_Bullet_teleport(target):
	velocity = Vector2()
	global_position = target


func _on_Area2D_area_entered(area):
	health -= 5 # Take damage after taking a hit from an enemy bullet
	emit_signal("update_health", int(health)) # update health bar
