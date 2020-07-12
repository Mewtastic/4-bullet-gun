extends RigidBody2D

signal dead()

func _on_Area2D_area_entered(area):
	emit_signal("dead")
	$Sprite.visible = false
	$Explosion.play()


func _on_Explosion_animation_finished():
	queue_free()
