extends Node
class_name StateMachine

export (NodePath) var subject;

var currentState: State = null;

func _ready():
	subject = get_node(subject);

func getCurrentState():
	return currentState;

func changeState(newStateName: String, params: Dictionary = {}):

	var newState = get_node(newStateName);

	if(currentState):
		currentState.exit(newState);
		subject.disconnect('antCollided', currentState, 'onCollided');

	currentState = newState;

	if(newState):
		newState.subject = subject;
		newState.enter(params);
		subject.connect('antCollided', currentState, 'onCollided');

func update(delta):
	if(currentState):
		currentState.update(delta);
