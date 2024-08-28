extends State



func Enter():

	if "Left" in samus.previous_animation:
		var animation = samus.previous_animation.replace("Left", "TurnRight")
		animated_sprite.play(animation)
	if "Right" in samus.previous_animation:
		var animation = samus.previous_animation.replace("Right", "TurnLeft")
		animated_sprite.play(animation)

func PhysicsUpdate(_delta:float):
	await animated_sprite.animation_finished
	transitioned.emit(self, samus.previous_state)
	
func Exit():
	#guarda a ultima animação do state
	samus.previous_animation = animated_sprite.animation
	#guarda o nome do ultimo state
	samus.previous_state = name
