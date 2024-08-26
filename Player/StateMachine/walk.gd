extends State
@onready var animated_sprite = $"../../animatedSprite"

@onready var samus = $"../.."
var direction
func Enter():
	pass
	
func Update(_delta:float):
	pass
	
func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	samus.velocity.x = move_toward(samus.velocity.x , direction * samus.speed, samus.acceleration * _delta)
	if direction > 0:
		animated_sprite.play("RunningRight")
	if direction < 0:
		animated_sprite.play("RunningLeft")
	if not direction:
		transitioned.emit(self, "idle")
		
	samus.hold = direction
func Exit():
	samus.previous_animation = animated_sprite.animation
