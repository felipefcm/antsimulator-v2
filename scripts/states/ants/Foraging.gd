extends State

var closestFood;

func enter(_params: Dictionary):
	
	var ant = subject as Ant;
	closestFood = ant.findClosestFood();

func exit(_nextState: State):
	var ant = subject as Ant;
	ant.steeringObj.setMode('Wander');

func update(delta: float):
	
	var ant = subject as Ant;
	
	if(is_instance_valid(closestFood)):
		ant.steeringObj.setTarget(closestFood);
		ant.steeringObj.setMode('Seek');
	else:
		closestFood = ant.findClosestFood();
		if(!is_instance_valid(closestFood)):
			ant.stateMachine.changeState('Wander');

func onCollided(obj: Node, collision: KinematicCollision2D):
	
	var ant = subject as Ant;
	var node = collision.collider as Node2D;

	if(!is_instance_valid(node)): return;

	if(node.is_in_group('food')):
		ant.stateMachine.changeState('CollectingFood', { 'food': node.get_node('Food') });
