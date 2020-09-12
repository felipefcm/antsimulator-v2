extends StaticBody2D

onready var food = $Food;

func _ready():
	food.connect('depleted', self, 'foodDepleted');

func foodDepleted():
	queue_free();
