extends Node2D
class_name Ant

onready var steeringObj = $SteerableBody2D;
onready var stateMachine = $StateMachine;

func _ready():
	add_to_group('ants');
	# stateMachine.setInitialState();
	stateMachine.changeState('Foraging');

func _physics_process(delta):
	stateMachine.update(delta);

func findClosestFood():
	
	var food = get_tree().get_nodes_in_group('food');
	
	if(food.size() > 0):
		
		var closestFood;
		var closestDstSq;
		
		for foodObj in food:
			var dstSq = position.distance_squared_to(foodObj.position);
			if(!closestFood || dstSq < closestDstSq):
				closestFood = foodObj;
				closestDstSq = dstSq;

		return closestFood;

	return null;
