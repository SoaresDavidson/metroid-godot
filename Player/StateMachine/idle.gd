extends State
class_name Idle
@onready var samus = $"../.."
@onready var animated_sprite = $"../../animatedSprite"

var direction: float

func Enter():
	print("cu")
	
func Update(_delta:float):
	pass
	
func PhysicsUpdate(_delta:float):
	var direction = Input.get_axis("left", "right")
	samus.velocity.x = move_toward(samus.velocity.x, 0, samus.friction * _delta)
	if samus.previous_animation == "RunningLeft":
		animated_sprite.play("IdleLeft")
	else:
		animated_sprite.play("IdleRight")
	if direction:
		transitioned.emit(self, "Walk")
func Exit():
	pass

func turningAnimation(direction: float) -> void:
	var hold
	if not hold:
		hold = direction
	if hold != direction and direction != 0:
		if hold < 0:
			animated_sprite.play("TurnLeft")
		if hold > 0:
			animated_sprite.play("TurnRight")
		hold = direction
