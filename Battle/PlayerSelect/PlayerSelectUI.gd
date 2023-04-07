extends Control

export var circle_width = 200
export var circle_height = 150
export var circle_offset_x = 0
export var circle_offset_y = 0
export var transition_time = 1
var object_rotation = 90
onready var objects = [$Sword, $MagicCard, $Backpack, $FloppyDisk]

func _ready():
	pass

func _process(delta):
	for i in range(0,4):
		objects[i].rect_position = Vector2(circle_width * cos(deg2rad(object_rotation + (i*90))), circle_height * sin(deg2rad(object_rotation + (i*90))))
	
	if (object_rotation < 0):
		object_rotation += 360
	
	var pressed_left = Input.is_action_just_pressed("ui_left")
	var pressed_right = Input.is_action_just_pressed("ui_right")
	if fmod(object_rotation,90) == 0.0:
		$Text.bbcode_enabled = true
		match fmod(object_rotation,360):
			90.0:
				$Text.bbcode_text = "[center]FIGHT[/center]"
			0.0:
				$Text.bbcode_text = "[center]MAGIC[/center]"
			270.0:
				$Text.bbcode_text = "[center]INVENTORY[/center]"
			180.0:
				$Text.bbcode_text = "[center]MEMORIES[/center]"
			_:
				$Text.text = "DEFAULT?"
		if pressed_left || pressed_right:
			var tween = get_tree().create_tween()
			var next_rotation = object_rotation + (90 if pressed_right else -90)
			tween.tween_property(self, "object_rotation", next_rotation, transition_time)
	else:
		$Text.text = ""
		
