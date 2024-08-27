extends State
@onready var samus = $"../.."
@onready var animated_sprite = $"../../animatedSprite"
var direction
var looking:float

func Enter():
	checkSide()
		
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
	if direction != looking and direction != 0:
		transitioned.emit(self, "Turn")

func checkSide():
	if "Left" in samus.previous_animation:
		animated_sprite.play("CrouchedLeft")
		looking = -1
	if "Right" in samus.previous_animation:
		looking = 1
		animated_sprite.play("CrouchedRight")
