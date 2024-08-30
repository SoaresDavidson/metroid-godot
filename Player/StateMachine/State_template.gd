extends Node
class_name State

@onready var animated_sprite = $"../../animatedSprite"
@onready var samus = $"../.."

var aimState:int 

signal transitioned

#direção em que a samus está olhando
#usado somente para saber quando entrar no state turn
var facing:int = -1

func Enter():
	print(name)
	
func Update(_delta:float):
	pass
	
func PhysicsUpdate(_delta:float):
	pass
	
func Exit():
	pass

func move(direction:int, _delta:float):
	samus.velocity.x = move_toward(samus.velocity.x , direction * samus.speed, samus.acceleration * _delta)

func checkAnimation(animationLeft:String, animationRight:String):
	if "Left" in samus.previous_animation:
		facing = -1
		animated_sprite.play(animationLeft)
	if "Right" in samus.previous_animation:
		facing = 1
		animated_sprite.play(animationRight)

func savePreviuos():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
