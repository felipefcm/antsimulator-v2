extends Node2D
class_name Ant

onready var steeringObj = $SteerableBody2D;
onready var stateMachine = $StateMachine;
onready var sprite = steeringObj.get_node('Sprite');

export (int) var foodCapacity = 1;

signal antCollided;

func _ready():
	add_to_group('ants');
	steeringObj.add_to_group('antSteerable');

	stateMachine.changeState('Foraging');
	# steeringObj.setMode('Wander');

func _physics_process(delta):
	
	stateMachine.update(delta);

	adjustSpriteToRotation();
	
	var numCollisions = steeringObj.get_slide_count();
	if(numCollisions > 0):
		for collisionIdx in range(numCollisions):
			var collision: KinematicCollision2D = steeringObj.get_slide_collision(collisionIdx);
			if(!collision || !collision.collider): continue;
			handleCollision(collision);

func handleCollision(collision: KinematicCollision2D):
	
	var collider = collision.collider as Node2D;
	
	if(collider.is_in_group('walls')): 
		steeringObj.velocity = steeringObj.velocity.rotated(steeringObj.rotation + rand_range(-PI / 2, PI / 2));
		return;

	if(collider.is_in_group('antSteerable')):
		return;

	emit_signal('antCollided', self, collision);

func findClosestFood():
	
	var allFood = get_tree().get_nodes_in_group('food');
	
	if(allFood.size() <= 0):
		return null;
		
	var closestFood;
	var closestDstSq;
	
	for foodObj in allFood:
		if(!is_instance_valid(foodObj)): continue;
		var dstSq = position.distance_squared_to(foodObj.position);
		if(!closestFood || dstSq < closestDstSq):
			closestFood = foodObj;
			closestDstSq = dstSq;

	return closestFood;

func adjustSpriteToRotation():
	if(steeringObj.rotation >= PI && steeringObj.rotation <= 3 * PI):
		sprite.flip_h = true;
	else:
		sprite.flip_h = false;
