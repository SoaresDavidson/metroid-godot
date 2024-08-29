extends State

var direction

func Enter():
	#checa qual animação usar,se estiver olhando pra cima so computa a animação de olhar pra cima
	if Input.is_action_pressed("up"):
		var current_frame = animated_sprite.get_frame()
		var current_progress = animated_sprite.get_frame_progress()
		checkAnimation("AimUpDiagonalLeft", "AimUpDiagonalRight")
		# Change the animation with keeping the frame index and progress.
		animated_sprite.set_frame_and_progress(current_frame, current_progress)
	else:
		var current_frame = animated_sprite.get_frame()
		var current_progress = animated_sprite.get_frame_progress()
		checkAnimation("RunningLeft", "RunningRight")
		animated_sprite.set_frame_and_progress(current_frame, current_progress)
		
func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	AnimatedSprite2D
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
	if not direction or direction != facing:
		transitioned.emit(self, "idle")
		
func AimUp():
	if Input.is_action_pressed("up") or Input.is_action_just_released("up"):
		transitioned.emit(self, "Walk")
