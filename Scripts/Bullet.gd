extends KinematicBody2D

const PURPLE_BULLET = 0 # Teleport bullet
const BLUE_BULLET = 1 # Obstacle trigger bullet. EX. Will explode barrels
const YELLOW_BULLET = 2 # Bounce off walls and damage enemies
const RED_BULLET = 3 # Shoots a bullet and damage enemies

signal teleport

var speed = 750
var velocity = Vector2()
var bullet_type = null
var bounces = 0
const BOUNCE_MAX = 3

func start(pos, dir, type):
	rotation = dir
	position = pos
	bullet_type = type
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	velocity = move_and_slide(velocity)
	if bullet_type == YELLOW_BULLET:
		var collision = move_and_collide(velocity * delta)
		if collision:
			bounces += 1
			if bounces >= BOUNCE_MAX:
				queue_free()
			velocity = velocity.bounce(collision.normal)
			if collision.collider.has_method("hit"):
				collision.collider.hit()

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if bullet_type == YELLOW_BULLET:
		pass
	else:
		velocity = Vector2()
		visible = false
		if bullet_type == PURPLE_BULLET:
			var pos = global_position
			emit_signal("teleport", pos)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	if bullet_type != PURPLE_BULLET:
		queue_free()
