extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Bullet = preload("res://Assets/Instances/Bullet.tscn")
var fire_rate = 30  # Number of frames between shots
var fire_timer = fire_rate

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func get_input():
#	look_at($Player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fire_timer += 1
	fire_timer = min(fire_rate, fire_timer)
	var player = get_parent().get_node("Player")
	if sqrt(pow(player.global_position.x - global_position.x, 2) + (pow(player.global_position.y - global_position.y, 2))) < 500:
		look_at(player.global_position)
		if(fire_timer == fire_rate):
			var b = Bullet.instance()
			b.start(global_position, rotation, int(2), true)
			get_parent().add_child(b)
			fire_timer = 0

	global_position = get_parent().get_node("Enemy").global_position
