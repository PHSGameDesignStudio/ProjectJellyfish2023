extends KinematicBody2D


var velocity = Vector2.ZERO
onready var _animated_sprite = $AnimatedSprite
export var speed = 100

var _animation = Animation.RIGHT_IDLE
var _move_x = MoveX.IDLE
var _move_y = MoveY.IDLE

enum MoveX { IDLE, RIGHT, LEFT = -1 }

enum MoveY { IDLE, DOWN, UP = -1 }

enum Animation {
	LEFT, LEFT_IDLE, RIGHT, RIGHT_IDLE, UP, UP_IDLE, DOWN, DOWN_IDLE,
}


func _ready():
	pass

# tremble and weep - nangs
func process_input():
	_move_x = MoveX.IDLE
	_move_y = MoveY.IDLE

	if Input.is_action_pressed("ui_right"):
		_move_x += MoveX.RIGHT
	if Input.is_action_pressed("ui_left"):
		_move_x += MoveX.LEFT

	if Input.is_action_pressed("ui_down"):
		_move_y += MoveY.DOWN
	if Input.is_action_pressed("ui_up"):
		_move_y += MoveY.UP

	if _move_x != MoveX.IDLE:
		_animation = _move_x + 1
	elif _move_y != MoveY.IDLE:
		_animation = _move_y + 5
	else:
		_animation += 1 - (_animation % 2)

func _process(_delta):
	process_input()
	_animated_sprite.flip_h = _animation < Animation.RIGHT
	match _animation:
		Animation.RIGHT:
			_animated_sprite.play("right")
		Animation.LEFT:
			_animated_sprite.play("right")
		Animation.DOWN:
			_animated_sprite.play("forward")
		Animation.UP:
			_animated_sprite.play("backward")
		Animation.RIGHT_IDLE:
			_animated_sprite.play("idle right")
		Animation.LEFT_IDLE:
			_animated_sprite.play("idle right")
		Animation.DOWN_IDLE:
			_animated_sprite.play("idle forward")
		Animation.UP_IDLE:
			_animated_sprite.play("idle backward")

func _physics_process(_delta):
	velocity = Vector2(_move_x, _move_y).normalized()
	velocity *= 150
	move_and_slide(velocity)
	
