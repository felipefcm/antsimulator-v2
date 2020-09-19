extends State

func enter(params: Dictionary = {}):
	var ant = subject as Ant;
	ant.velocity = Vector2.ZERO;
