extends SteeringBehaviour

func calculateSteeringForce(body: SteerableBody2D, target: Node2D):

	if(!is_instance_valid(target)): return Vector2.ZERO;
	
	var desiredVelocity = target.global_position - body.global_position;
	desiredVelocity = desiredVelocity.normalized() * body.maxSpeed;

	return desiredVelocity - body.velocity;
