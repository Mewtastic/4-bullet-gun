extends Node2D


func _on_Area2D_area_entered(area):
	$Area2D/Sprite.play()


func _on_Sprite_animation_finished():
	queue_free()
