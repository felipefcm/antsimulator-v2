extends Node2D
class_name Food

export (int) var amount = 10;

signal depleted;

func _ready():
	$'..'.add_to_group('food');

func collect(collectAmount):
	amount = max(amount - collectAmount, 0);
	if(amount <= 0):
		emit_signal('depleted');
