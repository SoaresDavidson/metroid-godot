extends State
class_name Idle


var direction: float


func Enter():
	#freia
	samus.velocity.x = 0
	#checa qual a animação correta para tocar
	if Input.is_action_pressed("up") and samus.previous_state != "Crouched":
		checkAnimation("AimUpLeft", "AimUpRight")
		return
		
	checkAnimation("IdleLeft", "IdleRight")


func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	
	#se o player aperta pra cima samus mirar pra cima
	AimUp()
	#ativa o modo mirar samus fica travada em uma diagonal função dos states AimDiagonalUp e AimDiagonalDown
	AimMode()
	#ao apertar pra baixo samus se agacha função do state Couched
	transitionCrouched()
	#ao aperta esquerda ou direita começa a andar função do state Walk
	transitionWalk()
	
func Exit():
	savePreviuos()
	
func AimUp():
	if pressedUp():
		if samus.previous_state == "Crouched":
			await get_tree().create_timer(0.125).timeout
			if Input.is_action_pressed("up"):
				transitioned.emit(self, "Idle")
		else:
			transitioned.emit(self, "Idle")


func AimMode():
	if pressedAim():
		#por padrão ao ativar o modo mira samus olha pra cima salvo casos onde ela
		#ja estava olhando para baixo
		if samus.aimState and samus.previous_state == "Walk":
			transitioned.emit(self, "AimDiagonalDown")
			
		transitioned.emit(self, "AimDiagonalUp")
		
func transitionWalk():
	# se na função Enter o state detecta a direção que a samus ta olhando,se em algum momento o 
	#direction for diferente dessa direção que ela ta olhando ele vai pro state Turn
	if direction != facing and direction != 0:
		transitioned.emit(self, "Turn")
	#se direction tiver um valor diferente de 0 então o jogador ta apertando esquerda ou direita
	#portanto vai pro state Walk
	if direction:
		transitioned.emit(self, "Walk")

func transitionCrouched():
	if Input.is_action_just_pressed("down"):
		transitioned.emit(self, "Crouched")
		
func transitionJump():
	if Input.is_action_just_pressed("Jump") or not samus.is_on_floor():
		samus.velocity.y = -400
		transitioned.emit(self, "StandingJump")
		
func pressedUp():
	return Input.is_action_pressed("up") or Input.is_action_just_released("up")

func pressedAim():
	return Input.is_action_pressed("Aim") or Input.is_action_just_released("Aim")
