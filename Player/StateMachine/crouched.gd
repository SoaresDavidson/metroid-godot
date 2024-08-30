extends State

var direction:float

func Enter():
	samus.velocity.x = 0
	checkAnimation("CrouchedLeft", "CrouchedRight")
		
func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	#transiciona pra Idle
	transitionIdle()
	#modo mira
	AimMode()
	
	#transiciona para Turn
	transitionWalk()
	
func Exit():
	savePreviuos()

func transitionIdle():
	if Input.is_action_just_pressed("up"):
		transitioned.emit(self, "Idle")

func transitionWalk():
	#verifica se precisa dar uma virada antes de ir para Walk
	transitionTurn()
	if direction:
		var time:float = 0.15
		if "Crouched" in samus.previous_animation: 
			time += 0.15
		await get_tree().create_timer(time).timeout
		if direction:
			transitioned.emit(self, "Walk")

func AimMode():
	if Input.is_action_just_pressed("Aim"):
		transitioned.emit(self, "CrouchedAimUp")

func transitionTurn():
	if direction != facing and direction != 0:
		transitioned.emit(self, "Turn")
