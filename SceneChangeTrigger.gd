extends Area2D

export (String) var door


func _ready():
	if door == "SC1-SC":
		PlayerAnimatedSprite.flip_h = true
		Player.global_position(Vector2(1,11))
