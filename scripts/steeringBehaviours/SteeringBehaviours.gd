extends Node

var modes = {
	'None': null,
	'Seek': preload('res://scripts/steeringBehaviours/behaviours/Seek.gd').new(),
	'Wander': preload('res://scripts/steeringBehaviours/behaviours/Wander.gd').new(),
	'Evade': preload('res://scripts/steeringBehaviours/behaviours/Evade.gd').new(),
	'Flee': preload('res://scripts/steeringBehaviours/behaviours/Flee.gd').new(),
};
