extends Node2D


func _on_Area2D_area_entered(area):
	$AudioStreamPlayer2D.play()
	$Area2D/Sprite.play()
	$Area2D/CollisionShape2D.queue_free()
	$Explosion.monitorable = true



func _on_Sprite_animation_finished():
	queue_free()
