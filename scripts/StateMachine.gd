extends Node
class_name StateMachine

export (NodePath) var subject;

signal beforeEnteringState;
signal afterEnteringState;
signal beforeExitingState;
signal afterExitingState;

var currentState: State;
export (NodePath) var initialState;

func _ready():
	subject = get_node(subject);

func setInitialState():
	currentState = get_node(initialState);
	currentState.enter(subject);

func changeState(newStateName: String):

	var newState = get_node(newStateName);

	if(currentState):
		emit_signal('beforeExitingState', currentState);
		currentState.exit(subject, newState);
		emit_signal('afterExitingState', currentState);

	currentState = newState;

	if(newState):
		emit_signal('beforeEnteringState', newState);
		newState.enter(subject);
		emit_signal('afterEnteringState', newState);

func update(delta):
	if(currentState):
		currentState.update(subject, delta);