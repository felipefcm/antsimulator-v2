extends StaticBody2D

onready var food = $Food;

func _ready():
	add_to_group('leaves');
	food.connect('depleted', self, 'foodDepleted');

func foodDepleted():
	queue_free();
