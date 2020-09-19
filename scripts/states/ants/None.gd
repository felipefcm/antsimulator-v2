extends State

func enter(_params: Dictionary = {}):
	var ant = subject as Ant;
	ant.velocity = Vector2.ZERO;
