extends Node2D


func _ready():
	print("Game started")
	var start = preload("Starting Cave.tscn")
	add_child_below_node(get_node("SceneChangePlayer"), start.instance())
