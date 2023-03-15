extends RigidBody2D



func _ready():
	pass


func _on_Moving_below_Tom_body_entered(body):
	z_index = -2




func _on_Moving_up_body_entered(body):
	z_index = 2


func _on_Moving_down_body_entered(body):
	z_index = -2
