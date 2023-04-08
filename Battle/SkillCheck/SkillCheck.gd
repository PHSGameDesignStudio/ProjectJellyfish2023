extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# var b = "text"
export var radius : float = 100
export var weapon_halflength : float = 50
export var weapon_speed : float = 270
onready var line = $Line
onready var target = $Target
onready var weapon = $Weapon
onready var shake_timer = $ShakeTimer
var weapon_rotation_pos = 0
var target_rotation_pos = 0
export var target_rotation_size = 0
export var shake_speed = 100
export var shake_radius = 100
var score = 0
var shakeTime = 0

func _ready():
	draw_circle_line()
	create_new_target()

func _process(delta):
	if shake_timer.time_left > 0:
		var t = shake_timer.time_left / shake_timer.wait_time
		var x = lerp(0, shake_radius, t) * cos(t * PI * 4)
		line.position.x = x
		target.position.x = x
		weapon.position.x = x 
	else:
		weapon_rotation_pos += weapon_speed * delta
		if Input.is_action_just_pressed("ui_accept"):
			if is_in_target_hit_area():
				score += 1
				create_new_target()
				if score >= 5:
					end()
			else:
				fail()
		if target_rotation_pos + target_rotation_size + 15 < weapon_rotation_pos:
			fail()
		draw_weapon_line()

func draw_line2d(line2d : Line2D, pos_radius : float, pos_rotation : float, size_rotation : float, vertices : int = 30, offset : Vector2 = Vector2(0,0)):
	var pts = []
	for i in range(0,vertices + 1):
		var rot = ((size_rotation / vertices) * i) + pos_rotation
		pts.append((pos_radius * get_vector(rot))+offset)
	line2d.points = pts

func draw_weapon_line():
	weapon.points = [(radius + weapon_halflength) * get_vector(weapon_rotation_pos), (radius - weapon_halflength) * get_vector(weapon_rotation_pos)]

func draw_circle_line():
	draw_line2d(line, radius, 0, 360, 100)
	
func draw_target_line():
	draw_line2d(target, radius, target_rotation_pos, target_rotation_size, 100)

func is_in_target_hit_area():
	return target_rotation_pos <= weapon_rotation_pos && weapon_rotation_pos <= target_rotation_pos + target_rotation_size

func get_vector(rot):
	return Vector2(cos(deg2rad(rot)), sin(deg2rad(rot)))

func create_new_target():
	target_rotation_pos += rand_range(90.0,330.0)
	draw_target_line()

func end():
	queue_free()
	pass
	# or hide object

func fail():
	shake_timer.start()
	set_all_colors(Color.red)

func set_all_colors(col : Color):
	line.default_color = col
	weapon.default_color = col
	target.default_color = col

func _on_ShakeTimer_timeout():
	end()
