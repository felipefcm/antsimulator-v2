extends Node

var modes = {
	'None': null,
	'Seek': preload('res://scripts/behaviours/Seek.gd').new(),
	'Wander': preload('res://scripts/behaviours/Wander.gd').new(),
};