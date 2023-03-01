extends KinematicBody2D


var velocity = Vector2.ZERO
onready var _animated_sprite =  $AnimatedSprite
export var speed = 100

var _movement = Move.DOWN_IDLE

enum Move {
	LEFT, LEFT_IDLE, RIGHT, RIGHT_IDLE, DOWN, DOWN_IDLE, UP, UP_IDLE,
}


func _ready():
	pass

func get_input():
	if Input.is_action_pressed("ui_right"):
		_movement = Move.RIGHT
	elif Input.is_action_pressed("ui_left"):
		_movement = Move.LEFT
	elif Input.is_action_pressed("ui_down"):
		_movement = Move.DOWN
	elif Input.is_action_pressed("ui_up"):
		_movement = Move.UP
	else:
		# tremble and weep - nangs
		_movement += 1 - (_movement % 2)

func _process(_delta):
	_animated_sprite.flip_h = _movement < Move.RIGHT
	match _movement:
		Move.RIGHT:
			_animated_sprite.play("right")
		Move.LEFT:
			_animated_sprite.play("right")
		Move.DOWN:
			_animated_sprite.play("forward")
		Move.UP:
			_animated_sprite.play("backward")
		Move.RIGHT_IDLE:
			_animated_sprite.play("idle right")
		Move.LEFT_IDLE:
			_animated_sprite.play("idle right")
		Move.DOWN_IDLE:
			_animated_sprite.play("idle forward")
		Move.UP_IDLE:
			_animated_sprite.play("idle backward")

func _physics_process(_delta):
	get_input()
	velocity = Vector2()
	match _movement:
		Move.RIGHT:
			velocity.x = 1
		Move.LEFT:
			velocity.x = -1
		Move.DOWN:
			velocity.y = 1
		Move.UP:
			velocity.y = -1
		_:
			pass
	# already unit vector
	velocity *= 150
	move_and_slide(velocity)
	
func _on_NewSceneArea_body_entered(body):
	if ("nextScene" in body):
		get_tree().change_scene(body.nextScene)
	

func _on_SceneTrigger_area_entered(area):
	if ("nextScene" in area):
		get_tree().change_scene(area.nextScene)
