extends Node
class_name State

signal transitioned

func Enter():
	print(name)
	
func Update(_delta:float):
	pass
	
func PhysicsUpdate(_delta:float):
	pass
	
func Exit():
	pass
