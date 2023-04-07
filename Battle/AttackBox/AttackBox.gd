extends Control

export var speed : float = 100
onready var hit_areas = [$HitArea, $HitArea2, $HitArea3]
onready var target_hit_areas = [$TargetHitArea, $TargetHitArea2, $TargetHitArea3]
onready var weapon = $Weapon
onready var width = rect_size.x
var last_hit_area : int = -1
var current_hit_area : int = -1
var score = 0
func _ready():
	score = 0
	weapon.rect_position.x = 0

func _process(delta):
	# If still in box continue else send data to Battle Manager
	if (weapon.rect_position.x < width):
		weapon.rect_position.x += speed * delta
	else:
		end()
	
	# If the player didn't attempt the hit area the hit area decreases in opacity
	var new_hit_area = get_current_hit_area()
	if (new_hit_area == -1 && new_hit_area != current_hit_area):
		var hit_area = hit_areas[current_hit_area]
		hit_area.modulate = lerp(Color.black, hit_area.modulate, 0.5)
		target_hit_areas[current_hit_area].modulate = lerp(Color.black, target_hit_areas[current_hit_area].modulate, 0.5)
	current_hit_area = new_hit_area
	
	# Check for weapon hit
	if current_hit_area != -1 && Input.is_action_just_pressed("ui_accept"):
		# Score Attack
		if is_in_target_hit_area():
			score += 3
		else:
			score += 1
		# Instance Slash Object
		var slash = weapon.duplicate()
		slash.set_script(null)
		slash.modulate = Color.red
		slash.rect_size.x /= 2.0
		slash.rect_position.x += slash.rect_size.x / 2.0
		add_child(slash)
		# Make Weapon Last Child in Tree
		remove_child(weapon)
		add_child(weapon)
		# Update Current Hit Area
		last_hit_area = current_hit_area
		current_hit_area = -1

func get_current_hit_area():
	for hit_area in hit_areas:
		if hit_area.rect_position.x <= weapon.rect_position.x and weapon.rect_position.x <= hit_area.rect_position.x + hit_area.rect_size.x:
			var index = hit_areas.find(hit_area)
			if index > last_hit_area:
				return index
	return -1

func is_in_target_hit_area():
	return target_hit_areas[current_hit_area].rect_position.x <= weapon.rect_position.x and weapon.rect_position.x <= target_hit_areas[current_hit_area].rect_position.x + target_hit_areas[current_hit_area].rect_size.x

func end():
	if (get_parent().name == "BattleManager"):
		get_parent().AttackScore(score)
