extends State
class_name Idle


var direction: float


func Enter():
	#freia
	samus.velocity.x = 0
	#checa qual a animação correta para tocar
	checkAnimation("IdleLeft", "IdleRight")

func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	
	#AimUp("AimUpLeft", "AimUpRight", name)
	
	transitionCrouched()
		
	transitionWalk()
	
func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
	
	
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
