extends State

@onready var samus = $"../.."



func Enter():
	print(name)
	
func Update(_delta:float):
	pass
	
func PhysicsUpdate(_delta:float):
	
	# Add the gravity.
	if not samus.is_on_floor():
		samus.velocity += samus.get_gravity() * _delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and samus.is_on_floor():
		samus.velocity.y = samus.JUMP_VELOCITY
	
	if Input.is_action_just_released("jump") and samus.velocity.y < 0:
		samus.velocity.y = samus.JUMP_VELOCITY /4
		
	transitionBack()

	
func Exit():
	pass

func transitionBack():
	if samus.is_on_floor():
		transitioned.emit(self, samus.previous_state)
