extends State

var nests;
var closestNest;

func enter(_params: Dictionary):
	
	var ant = subject as Ant;
	ant.setCarryingFood(true);
	
	nests = get_tree().get_nodes_in_group('nests');
	closestNest = Util.closestNode(nests, ant.steeringObj.global_position);
	
	ant.steeringObj.maxSpeedOffset = -20;
	ant.steeringObj.setTarget(closestNest);
	ant.steeringObj.setMode('Seek');

func exit(_nextState: State):
	var ant = subject as Ant;
	ant.setCarryingFood(false);
	ant.steeringObj.setMode('Wander');

func onNest(_nest: Node):
	var ant = subject as Ant;
	ant.setCarryingFood(false);
	ant.queue_free();
	Simulator.numAnts -= 1;

func update(_delta: float):
	pass;

func onCollided(_obj: Node, _collision: KinematicCollision2D):
	pass;
