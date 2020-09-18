
func calculateSteeringForce(steeringObj, target):

	if(steeringObj.global_position.distance_to(target.global_position) > 300):
		return Vector2.ZERO;

	if(!is_instance_valid(target)): return Vector2.ZERO;

	print('Fleeing ', target.name);
	
	var desiredVelocity = steeringObj.global_position - target.global_position;
	desiredVelocity = desiredVelocity.normalized() * steeringObj.maxSpeed;

	return desiredVelocity - steeringObj.velocity;

