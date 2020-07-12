extends KinematicBody2D

const PURPLE_BULLET = 0 # Teleport bullet ~ Finished
const BLUE_BULLET = 1 # Obstacle trigger bullet. EX. Will explode barrels
const RED_BULLET = 2 # Shoots a bullet and damage enemies

signal teleport

var speed = 1200
var velocity = Vector2()
var bullet_type = null

func start(pos, dir, type, enemy=false):
	rotation = dir
	position = pos
	bullet_type = type
	velocity = Vector2(speed, 0).rotated(rotation)
	if bullet_type == BLUE_BULLET:
		$Area2D.set_collision_layer(32)
		$Sprite.modulate = Color(0, 0, 255)
	elif bullet_type == PURPLE_BULLET:
		$Sprite.modulate = Color(255, 0, 255)
	else:
		$Area2D.set_collision_layer(64)
		if enemy:
			$Area2D.set_collision_layer(128)
			$Area2D.set_collision_mask(29)

func _physics_process(delta):
	velocity = move_and_slide(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	if bullet_type != PURPLE_BULLET:
		queue_free()


func _on_Area2D_body_entered(body):
	velocity = Vector2()
	visible = false
	if bullet_type == PURPLE_BULLET:
		connect("teleport", get_parent().get_child(0), "_on_Bullet_teleport")
		var pos = global_position
		emit_signal("teleport", pos)
	queue_free()
