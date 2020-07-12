extends Node2D

var Bullet = preload("res://Assets/Instances/Bullet.tscn")
export (NodePath) var TargetPath

onready var TargetNode = get_node(TargetPath)

var barrel0 = 0
var barrel1 = 0
var loaded = true

func _ready():
	randomize()
	barrel0 = int(rand_range(0, 3))
	barrel1 = int(rand_range(0, 3))

func get_input():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot"):
		shoot()

func shoot():
	if loaded:
		$AudioStreamPlayer2D.play()
		var b = Bullet.instance()
		b.start($Muzzle.global_position, rotation, int(barrel0))
		get_parent().add_child(b)
		loaded = false
		load_barrel()
	

func load_barrel():
	if barrel1 != null:
		barrel0 = barrel1
		barrel1 = null
		$ShotDelay.start(.25)
		$LoadDelay.start(1.5)
	else:
		barrel0 = null

func _process(delta):
	get_input()
	self.global_position = TargetNode.global_position


func _on_ShotDelay_timeout():
	if barrel0 != null:
		loaded = true


func _on_LoadDelay_timeout():
	if barrel0 == null:
		barrel0 = int(rand_range(0, 3))
		barrel1 = int(rand_range(0, 3))
		loaded = true
	else:
		barrel1 = int(rand_range(0, 3))
		loaded = true
