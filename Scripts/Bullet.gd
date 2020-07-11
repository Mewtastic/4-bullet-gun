extends KinematicBody2D

const PURPLE_BULLET = 0 # Teleport bullet
const BLUE_BULLET = 1 # Obstacle trigger bullet. EX. Will explode barrels
const RED_BULLET = 2 # Shoots a bullet and damage enemies

signal teleport

var speed = 750
var velocity = Vector2()
var bullet_type = null

func start(pos, dir, type):
	rotation = dir
	position = pos
	bullet_type = type
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	velocity = move_and_slide(velocity)


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	velocity = Vector2()
	visible = false
	if bullet_type == PURPLE_BULLET:
		var pos = global_position
		emit_signal("teleport", pos)
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	if bullet_type != PURPLE_BULLET:
		queue_free()


func _on_Area2D_body_entered(body):
	velocity = Vector2()
	visible = false
	if bullet_type == PURPLE_BULLET:
		var pos = global_position
		emit_signal("teleport", pos)
	queue_free()
