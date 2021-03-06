extends Node2D

export (NodePath) var TargetPath

onready var TargetNode = get_node(TargetPath)

var Bullet = preload("res://Assets/Instances/Bullet.tscn")
var fire_rate = 80  # Number of frames between shots
var fire_timer = fire_rate

func _process(delta):
	fire_timer += 1
	fire_timer = min(fire_rate, fire_timer)
	var player = get_parent().get_node("Player")
	if sqrt(pow(player.global_position.x - global_position.x, 2) + (pow(player.global_position.y - global_position.y, 2))) < 500:
		look_at(player.global_position)
		if(fire_timer == fire_rate):
			var b = Bullet.instance()
			b.start($Position2D.global_position, rotation, int(2), true)
			get_parent().add_child(b)
			fire_timer = 0

	self.global_position = TargetNode.global_position


func _on_Enemy_dead():
	queue_free()


func _on_Drone_dead():
	queue_free()


func _on_Enemy2_dead():
	queue_free()


func _on_Enemy3_dead():
	queue_free()


func _on_Enemy4_dead():
	queue_free()


func _on_Enemy5_dead():
	queue_free()


func _on_Enemy6_dead():
	queue_free()


func _on_Drone2_dead():
	queue_free()


func _on_Drone3_dead():
	queue_free()


func _on_Drone4_dead():
	queue_free()


func _on_Drone5_dead():
	queue_free()


func _on_Drone6_dead():
	queue_free()


func _on_Drone7_dead():
	queue_free()
