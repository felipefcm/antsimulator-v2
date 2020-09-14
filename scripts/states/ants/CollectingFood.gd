extends State

var collectTimer = 0;
var food;

func enter(params: Dictionary):
	var ant = subject as Ant;
	food = params.food;
	ant.steeringObj.setMode('None');

func update(delta: float):
	
	var ant = subject as Ant;

	if(!is_instance_valid(food)):
		ant.stateMachine.changeState('Foraging');
		return;

	collectTimer += delta;
	if(collectTimer >= 1 && is_instance_valid(food)):
		(food as Food).collect(ant.foodCapacity);
		collectTimer = 0;
