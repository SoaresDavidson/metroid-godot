extends State
class_name Idle


var direction: float


func Enter():
	#freia
	samus.velocity.x = 0
	#checa qual a animação correta para tocar
	if not Input.is_action_pressed("up"):
		checkAnimation("IdleLeft", "IdleRight")

func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	
	AimUp("AimUpLeft", "AimUpRight", name)
	
	transitionCrouched()
		
	transitionWalk()
	
func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
	
	
func transitionWalk():
	if direction != facing and direction != 0:
		transitioned.emit(self, "Turn")
	if direction:
		transitioned.emit(self, "Walk")

func transitionCrouched():
	if Input.is_action_just_pressed("down"):
		transitioned.emit(self, "Crouched")
