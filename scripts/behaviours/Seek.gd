
func calculateSteeringForce(steeringObj, target):

	if(!is_instance_valid(target)): return Vector2.ZERO;
	
	var desiredVelocity = target.global_position - steeringObj.global_position;
	desiredVelocity = desiredVelocity.normalized() * steeringObj.maxSpeed;

	return desiredVelocity - steeringObj.velocity;
