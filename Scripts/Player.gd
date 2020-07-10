extends KinematicBody2D

export (int) var speed = 350

var velocity = Vector2()

func _ready():
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	velocity = velocity.normalized() * speed

func _process(delta):
	get_input()
	velocity = move_and_slide(velocity)
