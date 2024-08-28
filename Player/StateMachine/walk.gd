extends State


var direction

func Enter():
	if not Input.is_action_pressed("up"):
		checkAnimation("RunningLeft", "RunningRight")
	
func PhysicsUpdate(_delta:float):
	
	direction = Input.get_axis("left", "right")
	#função responsável pelo movimento,presente na classe pai:State 
	move(direction, _delta)
	
	transitionIdle()
		
func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
	
func transitionIdle():
	if not direction:
		transitioned.emit(self, "idle")

func AimUp():
	if Input.is_action_pressed("up"):
		if "Left" in animated_sprite.animation:
			facing = -1
			animated_sprite.play("AimUpLeft")
		if "Right" in animated_sprite.animation:
			facing = 1
			animated_sprite.play("AimUpRight")
	else:
		transitioned.emit(self, "idle")
