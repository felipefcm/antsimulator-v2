extends Node2D

export (int) var radius = 100;
export (PackedScene) var food;

export (int) var maxInstances = 1;
var instances = 0;

func _ready():
	$Timer.wait_time += rand_range(-2, 2);
	$Timer.start();

func _on_Timer_timeout():
	
	if(instances >= maxInstances): return;
	
	var newFood = food.instance();
	newFood.get_node('Food').connect('depleted', self, 'foodDepleted');
	instances += 1;
	newFood.position += Vector2(rand_range(-radius, radius), rand_range(-radius, radius));
	add_child(newFood);

func foodDepleted():
	instances -= 1;
