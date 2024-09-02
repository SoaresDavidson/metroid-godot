extends State

var direction:int

func Enter():
	checkAnimation("BallJumpLeft", "BallJumpRight")
	
	
func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
		
	
	samus.velocity.x = facing * samus.speed / 2
	
	if direction == 1:
		facing = 1
		animated_sprite.play("BallJumpRight")
		
	elif direction == -1:
		facing = -1
		animated_sprite.play("BallJumpLeft")
		
	if samus.is_on_floor():
		transitioned.emit(self, "Idle")
	
func Exit():
	savePreviuos()
