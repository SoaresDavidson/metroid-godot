extends State
class_name Idle


var direction: float


func Enter():
	#freia
	samus.velocity.x = 0
	#checa qual a animação correta para tocar
	if Input.is_action_pressed("up"):
		checkAnimation("AimUpLeft", "AimUpRight")
		return
		
	checkAnimation("IdleLeft", "IdleRight")
	samus.aimState = 0

func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	
	AimUp()
	
	AimMode()
	
	transitionCrouched()
	
	transitionWalk()
	
func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
	
func AimUp():
	if pressedUp():
		transitioned.emit(self, "Idle")
	
func AimMode():
	if pressedAim():
		if "Down" in samus.previous_animation:
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
	if Input.is_action_just_pressed("down") and not Input.is_action_pressed("Aim"):
		transitioned.emit(self, "Crouched")
		
func pressedUp():
	return Input.is_action_pressed("up") or Input.is_action_just_released("up")

func pressedAim():
	return Input.is_action_pressed("Aim") or Input.is_action_just_released("Aim")
