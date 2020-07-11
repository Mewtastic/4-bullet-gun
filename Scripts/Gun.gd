extends Node2D

var Bullet = preload("res://Assets/Instances/Bullet.tscn")
export (NodePath) var TargetPath

onready var TargetNode = get_node(TargetPath)
onready var StartOffset = self.transform.origin - TargetNode.transform.origin

func _ready():
	randomize()

func get_input():
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation, 3)
	get_parent().add_child(b)
	

func _physics_process(delta):
	get_input()
	self.transform.origin = TargetNode.transform.origin + StartOffset
