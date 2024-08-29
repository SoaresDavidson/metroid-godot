extends State

var direction:int

func Enter():
	checkAnimation("AimUpDiagonalLeft", "AimUpDiagonalRight")
	
func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_released("Aim"):
		transitioned.emit(self, "Idle")
		
	if Input.is_action_just_pressed("down"):
		transitioned.emit(self, "AimDiagonalDown")
		
	if direction != facing and direction != 0:
		transitioned.emit(self, "Turn")
		
	if direction:
		transitioned.emit(self, "Walk")
	
func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
	
	samus.aimState = 0
