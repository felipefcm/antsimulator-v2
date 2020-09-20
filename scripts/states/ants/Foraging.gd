extends State

export (int) var minFoodDistance = 200;

var targetFood;

func enter(_params: Dictionary):
	var ant = subject as Ant;
	targetFood = null;
	ant.setMode('Wander');

func exit(_nextState: State):
	var ant = subject as Ant;
	ant.setMode('Wander');

func update(_delta: float):
	
	var ant = subject as Ant;
	
	if(is_instance_valid(targetFood)):
		ant.setTarget(targetFood);
		ant.setMode('Seek');
	else:
		var closestFood = ant.findClosestFood();
		
		if(!is_instance_valid(closestFood)):
			ant.setMode('Wander');
			return;
		
		if(ant.global_position.distance_squared_to(closestFood.global_position) <= minFoodDistance * minFoodDistance):
			targetFood = closestFood;

func onCollided(collider: Node):

	var ant = subject as Ant;

	if(collider.is_in_group('food')):
		ant.stateMachine.changeState('CollectingFood', { 'food': collider.get_node('Food') });
