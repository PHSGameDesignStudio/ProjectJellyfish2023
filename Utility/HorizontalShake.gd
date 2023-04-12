extends Node

export var shake_radius : float
export var shake_time : float
onready var shake_timer : Timer = $ShakeTimer
var parent_pos : Vector2

func _ready():
	shake_timer.wait_time = shake_time
	shake_timer.start()
	parent_pos = get_parent_pos()

func _process(delta):
	if shake_timer.time_left > 0:
		var t = shake_timer.time_left / shake_timer.wait_time
		var x = lerp(0, shake_radius, t) * sin(t * PI * 4)
		set_parent_pos(Vector2(parent_pos.x + x, parent_pos.y))

func set_parent_pos(pos : Vector2):
	if get_parent() is Node2D:
		var parent = get_parent() as Node2D
		parent.position = pos
	elif get_parent() is Control:
		var parent = get_parent() as Control
		parent.rect_position = pos

func get_parent_pos():
	if get_parent() is Node2D:
		var parent = get_parent() as Node2D
		return parent.position
	elif get_parent() is Control:
		var parent = get_parent() as Control
		return parent.rect_position
	return Vector2.ZERO


func _on_ShakeTimer_timeout():
	set_parent_pos(parent_pos)
	queue_free()
