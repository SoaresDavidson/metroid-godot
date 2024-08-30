extends State

func Enter():
	checkAnimation("JumpRisingIdleLeft", "JumpRisingIdleRight")
	
func PhysicsUpdate(_delta:float):
	transitionPreviousState()
	
func Exit():
	savePreviuos()
	
func transitionPreviousState():
	if samus.is_on_floor():
		transitioned.emit(self, "Idle")
