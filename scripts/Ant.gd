extends Node2D
class_name Ant

onready var steeringObj = $SteerableBody2D;
onready var stateMachine = $StateMachine;

export (int) var foodCapacity = 1;

signal collided;

func _ready():
	add_to_group('ants');
	stateMachine.changeState('Foraging');
	# steeringObj.setMode('Wander');

func _physics_process(delta):
	
	stateMachine.update(delta);
	
	var numCollisions = steeringObj.get_slide_count();
	if(numCollisions > 0):
		for collisionIdx in range(numCollisions):
			var collision: KinematicCollision2D = steeringObj.get_slide_collision(collisionIdx);
			emit_signal('collided', self, collision);

func findClosestFood():
	
	var food = get_tree().get_nodes_in_group('food');
	
	if(food.size() > 0):
		
		var closestFood;
		var closestDstSq;
		
		for foodObj in food:
			if(!is_instance_valid(foodObj)): continue;
			var dstSq = position.distance_squared_to(foodObj.position);
			if(!closestFood || dstSq < closestDstSq):
				closestFood = foodObj;
				closestDstSq = dstSq;

		return closestFood;

	return null;
