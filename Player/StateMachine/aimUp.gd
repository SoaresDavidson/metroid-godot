extends State

var direction:float

func Enter():
	checkAnimation("AimUpLeft", "AimUpRight")

func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	
	if direction != facing and direction != 0:
		transitioned.emit(self, "Turn")
	
	if direction:
		transitioned.emit(self, "Walk")

func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
