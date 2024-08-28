extends State


var direction

func Enter():
	#checa qual animação usar,se estiver olhando pra cima so computa a animação de olhar pra cima
	if not Input.is_action_pressed("up"):
		checkAnimation("RunningLeft", "RunningRight")
	
func PhysicsUpdate(_delta:float):
	
	direction = Input.get_axis("left", "right")
	
	
	#função responsável pelo movimento,presente na classe pai:State 
	move(direction, _delta)
	
	AimUp()
	#transiciona pra Idle
	transitionIdle()
		
func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
	
func transitionIdle():
	#se não tiver input em direction(direction = 0) transiciona pra idle
	if not direction:
		transitioned.emit(self, "idle")

func AimUp():
	if Input.is_action_pressed("up"):
		if "Left" in animated_sprite.animation:
			facing = -1
			animated_sprite.play("AimUpDiagonalLeft")
		if "Right" in animated_sprite.animation:
			facing = 1
			animated_sprite.play("AimUpDiagonalRight")
	else:
		transitioned.emit(self, "Walk")
