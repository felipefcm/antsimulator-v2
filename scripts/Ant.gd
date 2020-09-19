extends 'res://scripts/behaviours/SteerableBody2D.gd';
class_name Ant

onready var stateMachine = $StateMachine;
onready var sprite = $Sprite;
onready var foodCarry = sprite.get_node('FoodCarry');

export (int) var foodCapacity = 1;

var carryingFood := false;
var predators;

signal antCollided;

func _ready():
	add_to_group('ants');

	stateMachine.changeState('Foraging');

	predators = get_tree().get_nodes_in_group('predators');
	
	# setMode('Flee');
	# setTarget(predators[0]);
	# pushMode('Flee');
	# setMode('Wander');

func _physics_process(delta):
	
	stateMachine.update(delta);

	adjustSpriteToRotation();

	var closestPredator = Util.closestNode(predators, global_position);
	setTarget(closestPredator, 1);

	var numCollisions = get_slide_count();
	if(numCollisions > 0):
		for collisionIdx in range(numCollisions):
			var collision: KinematicCollision2D = get_slide_collision(collisionIdx);
			if(!collision || !collision.collider): continue;
			handleCollision(collision);

func handleCollision(collision: KinematicCollision2D):
	
	var collider = collision.collider as Node2D;
	
	if(collider.is_in_group('walls')): 
		velocity = velocity.rotated(rotation + rand_range(-PI / 2, PI / 2));
		return;

	if(collider.is_in_group('ants')):
		return;

	emit_signal('antCollided', self, collision);

func setCarryingFood(carrying: bool):
	carryingFood = carrying;
	foodCarry.visible = carryingFood;

func findClosestFood():
	var allFood = get_tree().get_nodes_in_group('food');	
	return Util.closestNode(allFood, global_position);

func adjustSpriteToRotation(): 

	var intDegRotation = int(rotation_degrees) % 360;
	
	if((intDegRotation < -90 && intDegRotation > -270) || (intDegRotation > 90 && intDegRotation < 270)):
		sprite.flip_v = true;
		foodCarry.centered = false;
	else:
		sprite.flip_v = false;
		foodCarry.centered = true;
