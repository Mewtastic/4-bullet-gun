extends KinematicBody2D

const PURPLE_BULLET = 0 # Teleport bullet
const BLUE_BULLET = 1 # Obstacle trigger bullet. EX. Will explode barrels
const GREEN_BULLET = 2 # Knockback bullet
const YELLOW_BULLET = 3 # Bounce off walls and damage enemies
const RED_BULLET = 4 # Shoots 3 bullets and damage enemies

var bullet0 = 0
var bullet1 = 0

signal teleport

var pos = Vector2()
var prev_pos = Vector2()
var speed = 1500
var loaded = true
var velocity = Vector2()

export (NodePath) var TargetPath

onready var TargetNode = get_node(TargetPath)
onready var StartOffset = self.transform.origin - TargetNode.transform.origin

func _ready():
	randomize()
	bullet0 = rand_range(0, 5)
	bullet1 = rand_range(0, 5)

func get_input():
	if loaded:
		look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot") and loaded:
		visible = true
		loaded = false
		velocity = Vector2(speed, 0).rotated(rotation)

func _process(delta):
	get_input()
	if loaded:
		self.transform.origin = TargetNode.transform.origin + StartOffset
	velocity = move_and_slide(velocity)


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	# Teleport
	loaded = true
	velocity = Vector2()
	visible = false
	pos = global_position
	emit_signal("teleport", pos)
