extends KinematicBody2D


var velocity = Vector2.ZERO
onready var anim = $AnimatedSprite
export var speed = 100

var _movement = Move.RIGHT_IDLE
var last_frame

enum Move {
	LEFT, LEFT_IDLE, RIGHT, RIGHT_IDLE, DOWN, DOWN_IDLE, UP, UP_IDLE,
}


func _ready():
	pass

func get_input():
	if Input.is_action_pressed("ui_right"):
		anim.play("right")
		last_frame = "right"
	elif Input.is_action_pressed("ui_left"):
		anim.play("right")
		last_frame = "left"
	elif Input.is_action_pressed("ui_down"):
		anim.play("forward")
		last_frame = "down"
	elif Input.is_action_pressed("ui_up"):
		anim.play("backward")
		last_frame = "up"
	else:
		# tremble and weep - nangs
		_movement += 1 - (_movement % 2)

func _process(_delta):
	if _movement == Move.LEFT:
		anim.flip_h 
	if last_frame == "right":
		anim.play("idle right")
	if last_frame == "left":
			anim.play("idle right")
	if last_frame == "down":
			anim.play("idle forward")
	if last_frame == "up":
			anim.play("idle backward")

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
	

	
