extends State

var dict:Dictionary = {
	"Left": "TurnRight",
	"Right": "TurnLeft"
}

func Enter():

	switchSides("Left")
	
	switchSides("Right")

func PhysicsUpdate(_delta:float):
	await animated_sprite.animation_finished
	transitioned.emit(self, samus.previous_state)
	
func Exit():
	savePreviuos()

func switchSides(side: String):
	#ex: if "Left" in IdleLeft
	#var animation = "IdleLeft".replace("Left",dict["Left])
	#animated_sprite.play("IdleTurnRight")
	if side in samus.previous_animation:
		var animation = samus.previous_animation.replace(side, dict[side])
		animated_sprite.play(animation)
