extends State

func enter(obj: Node):
	
	var ant = obj as Ant;
	# ant.connect(
	
	var closestFood = ant.findClosestFood();
	if(closestFood):
		ant.steeringObj.setTarget(closestFood);
		ant.steeringObj.setMode('Seek');

func exit(obj: Node, _nextState: State):
	var ant = obj as Ant;
	ant.steeringObj.setMode('None');

func update(obj: Node, delta: float):
	var ant = obj as Ant;
