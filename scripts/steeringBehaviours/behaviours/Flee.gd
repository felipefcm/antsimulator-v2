extends SteeringBehaviour

func calculateSteeringForce(body: SteerableBody2D, target: Node2D):

	if(body.global_position.distance_to(target.global_position) > 300):
		return Vector2.ZERO;

	if(!is_instance_valid(target)): return Vector2.ZERO;

	print('Fleeing ', target.name);
	
	var desiredVelocity = body.global_position - target.global_position;
	desiredVelocity = desiredVelocity.normalized() * body.maxSpeed;

	return desiredVelocity - body.velocity;

