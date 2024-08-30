extends State

var direction:int

func Enter():
	checkAnimation("CrouchedAimDownLeft", "CrouchedAimDownRight")
	
func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("up"):
		transitioned.emit(self, "CrouchedAimUp")
	
	if Input.is_action_just_released("Aim"):
		transitioned.emit(self, "Crouched")
	
	if direction != facing and direction != 0:
		transitioned.emit(self, "Turn")
		
	if direction:
		transitioned.emit(self, "Walk")
	
	
func Exit():
	savePreviuos()

	samus.aimState = 1
