extends Control

export var right_texture : Texture
export var left_texture : Texture
export var up_texture : Texture
export var down_texture : Texture
export var idk_texture : Texture
export var time : float = 1.0
onready var incantation_items = [$Incantations/Item1, $Incantations/Item2, $Incantations/Item3, $Incantations/Item4]
onready var wand = $Wand/Wand
var incantation_indexes = []
var index = 0
onready var wand_tween : SceneTreeTween = get_tree().create_tween()

func _ready():
	$IncantationTimer.wait_time = time

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		do_wand_tween(0)
	if Input.is_action_just_pressed("ui_up"):
		do_wand_tween(90)
	if Input.is_action_just_pressed("ui_left"):
		do_wand_tween(180)
	if Input.is_action_just_pressed("ui_down"):
		do_wand_tween(270)
	wand.rect_position = 100 * Vector2(cos(deg2rad(wand.rect_rotation)),sin(deg2rad(wand.rect_rotation)))
	
func do_wand_tween(rotation: float):
	if (abs(wand.rect_rotation - rotation) < 360):
		rotation += 360
	var this_time = 0.5
	wand_tween.kill()
	wand_tween = get_tree().create_tween()
	wand_tween.tween_property(wand, "rect_rotation", rotation, this_time).set_trans(Tween.EASE_OUT)

func _on_IncantationTimer_timeout():
	if index < len(incantation_items):
		if Input.is_action_pressed("ui_right"):
			incantation_items[index].texture = right_texture
			incantation_indexes = 0
		elif Input.is_action_pressed("ui_left"):
			incantation_items[index].texture = left_texture
			incantation_indexes = 2
		elif Input.is_action_pressed("ui_up"):
			incantation_items[index].texture = up_texture
			incantation_indexes = 1
		elif Input.is_action_pressed("ui_down"):
			incantation_items[index].texture = down_texture
			incantation_indexes = 3
		else:
			incantation_items[index].texture = idk_texture
			incantation_indexes = -1
		incantation_items[index].rect_scale = Vector2.ZERO
		var tween = get_tree().create_tween()
		tween.tween_property(incantation_items[index], "rect_scale", Vector2.ONE * 0.75, 0.1).set_trans(Tween.EASE_OUT)
		index += 1
