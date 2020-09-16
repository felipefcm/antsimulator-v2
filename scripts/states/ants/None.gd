extends State

func enter(params: Dictionary = {}):
	var ant = subject as Ant;
	ant.steeringObj.velocity = Vector2.ZERO;

