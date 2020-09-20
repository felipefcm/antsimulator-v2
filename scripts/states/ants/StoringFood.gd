extends State

var nests;
var closestNest;

func enter(_params: Dictionary):
	
	var ant = subject as Ant;
	ant.setCarryingFood(true);
	
	nests = get_tree().get_nodes_in_group('nests');
	closestNest = Util.closestNode(nests, ant.global_position);
	
	ant.maxSpeedOffset = -20;
	ant.setTarget(closestNest);
	ant.setMode('Seek');

func exit(_nextState: State):
	var ant = subject as Ant;
	ant.maxSpeedOffset = 0;
	ant.setCarryingFood(false);
	ant.setMode('Wander');

func onCollided(collider: Node):
	
	var ant = subject as Ant;
	
	if(collider.is_in_group('nests')):
		ant.setCarryingFood(false);
		ant.queue_free();
		Simulator.numAnts -= 1;
