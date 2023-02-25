extends Node2D

signal world_changed(world_name)
var entered = false

export (String) var world_name = "World"

func _process(delta):
	if entered == true:
		emit_signal("world_changed", world_name)

func _on_Area2D_body_entered(body):
	entered = true
func _on_Area2D_body_exited(body):
	entered = false

func _on_To_Starting_Cave_body_entered(body):
	entered = true
func _on_To_Starting_Cave_body_exited(body):
	entered = false
