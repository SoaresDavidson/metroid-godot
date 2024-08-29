extends Node
class_name State

@onready var animated_sprite = $"../../animatedSprite"
@onready var samus = $"../.."

var aimState:int 

signal transitioned

#direção em que a samus está olhando
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

#func AimUp(animationLeft:String, animationRight:String, state:String):
	#
	#if Input.is_action_pressed("up"):
		#if "Left" in animated_sprite.animation:
			#facing = -1
			#animated_sprite.play(animationLeft)
		#if "Right" in animated_sprite.animation:
			#facing = 1
			#animated_sprite.play(animationRight)
	#else:
		#transitioned.emit(self, state)
