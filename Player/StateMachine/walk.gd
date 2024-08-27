extends State
@onready var animated_sprite = $"../../animatedSprite"
@onready var samus = $"../.."

var direction

func Enter():
	if "Left" in samus.previous_animation:
		animated_sprite.play("RunningLeft")
	if "Right" in samus.previous_animation:
		animated_sprite.play("RunningRight")
	
func PhysicsUpdate(_delta:float):
	
	direction = Input.get_axis("left", "right")
	
	samus.velocity.x = move_toward(samus.velocity.x , direction * samus.speed, samus.acceleration * _delta)

	transitionIdle()
		
func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
	
func transitionIdle():
	if not direction:
		transitioned.emit(self, "idle")
