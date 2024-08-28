extends State

var direction:float


func Enter():
	checkAnimation("CrouchedLeft", "CrouchedRight")
		
func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	samus.velocity.x = move_toward(samus.velocity.x, 0, samus.friction * _delta)
	#transiciona pra Idle
	transitionIdle()
	#transiciona para Turn
	transitionTurn()
	
func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name

func transitionIdle():
	if Input.is_action_just_pressed("up"):
		transitioned.emit(self, "Idle")

func transitionTurn():
	if direction != facing and direction != 0:
		transitioned.emit(self, "Turn")
	if direction:
		transitioned.emit(self, "Walk")
