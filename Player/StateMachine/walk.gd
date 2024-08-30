extends State

var direction

func Enter():
	#checa qual animação usar,se estiver olhando pra cima so computa a animação de olhar pra cima
	#preguiça de tirar essas funções repetidas pro algum motivo n da certo colocar em funções
	if Input.is_action_pressed("up"):
		samus.aimState = 0
		keepAnimation("RunningAimUpDiagonalLeft",  "RunningAimUpDiagonalRight")
		return
		
	if Input.is_action_pressed("down"):
		samus.aimState = 1
		keepAnimation("RunningAimDownDiagonalLeft", "RunningAimDownDiagonalRight")
		return
		
	if Input.is_action_pressed("Aim"):
		if samus.aimState:
			keepAnimation("RunningAimDownDiagonalLeft", "RunningAimDownDiagonalRight")
		else:
			keepAnimation("RunningAimUpDiagonalLeft", "RunningAimUpDiagonalRight")
		return

	keepAnimation("RunningLeft", "RunningRight")
	samus.aimState = 0
	
		
func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	#função responsável pelo movimento,presente na classe pai:State 
	move(direction, _delta)
	#quando o player aperta para baixo,cima e A o personagem mira correndo
	AimUp()
	#transiciona pra Idle
	transitionIdle()
		
func Exit():
	savePreviuos()
	
func transitionIdle():
	#se não tiver input em direction(direction = 0) transiciona pra idle
	if not direction or direction != facing:
		transitioned.emit(self, "idle")
		
func AimUp():
	if Up() or Down() or Aim():
		transitioned.emit(self, "Walk")

func keepAnimation(AimDiagonalLeft: String, AimDiagonalRight: String):
	var current_frame = animated_sprite.get_frame()
	var current_progress = animated_sprite.get_frame_progress()
	checkAnimation(AimDiagonalLeft, AimDiagonalRight)
	# Change the animation with keeping the frame index and progress.
	animated_sprite.set_frame_and_progress(current_frame, current_progress)

func Up():
	return Input.is_action_pressed("up") or Input.is_action_just_released("up") 

func Down():
	return Input.is_action_pressed("down") or Input.is_action_just_released("down")

func Aim():
	return Input.is_action_pressed("Aim") or Input.is_action_just_released("Aim")

func AimAnimation(input: String,AnimationLeft:String, AnimationRight:String) -> void:
	if Input.is_action_pressed(input):
		samus.aimState = 0
		keepAnimation(AnimationLeft, AnimationRight)
		return
		
