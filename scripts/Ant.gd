extends Node2D
class_name Ant

onready var steeringObj = $SteerableBody2D;
onready var stateMachine = $StateMachine;
onready var sprite = steeringObj.get_node('Sprite');
onready var foodCarry = sprite.get_node('FoodCarry');

export (int) var foodCapacity = 1;

var carryingFood := false;

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

func setCarryingFood(carrying: bool):
	carryingFood = carrying;
	foodCarry.visible = carryingFood;

func findClosestFood():
	var allFood = get_tree().get_nodes_in_group('food');	
	return Util.closestNode(allFood, steeringObj.global_position);

func adjustSpriteToRotation(): 

	var intDegRotation = int(steeringObj.rotation_degrees) % 360;
	
	if((intDegRotation < -90 && intDegRotation > -270) || (intDegRotation > 90 && intDegRotation < 270)):
		sprite.flip_v = true;
		foodCarry.centered = false;
	else:
		sprite.flip_v = false;
		foodCarry.centered = true;
