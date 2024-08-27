extends State
class_name Idle
@onready var samus = $"../.."
@onready var animated_sprite = $"../../animatedSprite"

var direction: float
var facing:int = -1

func Enter():
	#freia
	samus.velocity.x = 0
	#checa qual a animação correta para tocar
	checkAnimation()

func PhysicsUpdate(_delta:float):
	direction = Input.get_axis("left", "right")
	
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

func checkAnimation():
	if "Left" in samus.previous_animation:
		facing = -1
		animated_sprite.play("IdleLeft")
	if "Right" in samus.previous_animation:
		facing = 1
		animated_sprite.play("IdleRight")

func transitionCrouched():
	if Input.is_action_just_pressed("down"):
		transitioned.emit(self, "Crouched")
