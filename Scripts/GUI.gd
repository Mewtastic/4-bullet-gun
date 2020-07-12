extends MarginContainer

onready var HealthBar = $HBoxContainer/Bars/Bar/Health


func _on_Player_update_health(health):
	HealthBar.value = health
