extends KinematicBody2D

var velocity = Vector2.ZERO
onready var _animated_sprite =  $AnimatedSprite
var last_action_pressed 
export var speed = 100


func _ready():
	pass

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		last_action_pressed = "right"
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		last_action_pressed = "left"
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		last_action_pressed = "down"
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		last_action_pressed = "up"
	velocity = velocity.normalized() * 150
	_animated_sprite = $AnimatedSprite
	
func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.flip_h = false
		_animated_sprite.play("left_right")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.flip_h = true
		_animated_sprite.play("left_right")
	elif Input.is_action_pressed("ui_up"):
		_animated_sprite.play("backward")
	elif Input.is_action_pressed("ui_down"):
		_animated_sprite.play("forward")
	elif velocity.x == 0 and last_action_pressed == "right":
		_animated_sprite.flip_h = false
		_animated_sprite.play("idle left_right")
	elif velocity.x == 0 and last_action_pressed == "left":
		_animated_sprite.flip_h = true
		_animated_sprite.play("idle left_right")
	elif velocity.x == 0 and last_action_pressed == "down":
		_animated_sprite.play("idle forward")
	elif velocity.x == 0 and last_action_pressed == "up":
		_animated_sprite.play("idle backward")

func _physics_process(_delta):
	get_input()
	move_and_slide(velocity)
	
func _on_NewSceneArea_body_entered(body):
	if ("nextScene" in body):
		get_tree().change_scene(body.nextScene)
	


func _on_SceneTrigger_area_entered(area):
	if ("nextScene" in area):
		get_tree().change_scene(area.nextScene)
