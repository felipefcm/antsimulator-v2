extends State

export (int) var minFoodDistance = 200;

var targetFood;

func enter(_params: Dictionary):
	var ant = subject as Ant;
	targetFood = null;
	ant.steeringObj.setMode('Wander');

func exit(_nextState: State):
	var ant = subject as Ant;
	ant.steeringObj.setMode('Wander');

func update(_delta: float):
	
	var ant = subject as Ant;
	
	if(is_instance_valid(targetFood)):
		ant.steeringObj.setTarget(targetFood);
		ant.steeringObj.setMode('Seek');
	else:
		var closestFood = ant.findClosestFood();
		
		if(!is_instance_valid(closestFood)):
			ant.steeringObj.setMode('Wander');
			return;
		
		if(ant.position.distance_squared_to(closestFood.position) <= minFoodDistance * minFoodDistance):
			targetFood = closestFood;

func onCollided(_obj: Node, collision: KinematicCollision2D):
	
	var ant = subject as Ant;
	var collider = collision.collider as Node2D;

	if(!is_instance_valid(collider)): return;

	if(collider.is_in_group('food')):
		ant.stateMachine.changeState('CollectingFood', { 'food': collider.get_node('Food') });
