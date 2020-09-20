extends Node
class_name StateMachine

var subject: Node;
var currentState: State = null;

func _ready():
	subject = get_node('..');

func getCurrentState():
	return currentState;

func changeState(newStateName: String, params: Dictionary = {}):

	var newState = get_node(newStateName);

	if(currentState):
		currentState.exit(newState);
		subject.disconnect('collided', currentState, 'onCollided');

	currentState = newState;

	if(newState):
		newState.subject = subject;
		newState.enter(params);
		subject.connect('collided', currentState, 'onCollided');

func update(delta):
	if(currentState):
		currentState.update(delta);
