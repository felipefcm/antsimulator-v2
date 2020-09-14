extends Node
class_name State

var subject;

func enter(_params: Dictionary):
	pass;

func exit(_nextState: State):
	pass;

func update(_delta: float):
	pass;

func onCollided(_obj: Node, _collision: KinematicCollision2D):
	pass
