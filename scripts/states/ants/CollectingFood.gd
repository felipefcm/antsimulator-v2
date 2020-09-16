extends State

var collectTimer = 0;
var food;

func enter(params: Dictionary):
	var ant = subject as Ant;
	food = params.food;
	print('got food ', food, ' amount ', food.amount);
	ant.steeringObj.setMode('None');

func exit(_nextState: State):
	var ant = subject as Ant;
	ant.steeringObj.setMode('None');

func update(delta: float):
	
	var ant = subject as Ant;

	if(!is_instance_valid(food) || food is Ant):
		ant.stateMachine.changeState('Foraging');
		return;

	collectTimer += delta;
	if(collectTimer >= 1):
		food.collect(ant.foodCapacity);
		collectTimer = 0;
