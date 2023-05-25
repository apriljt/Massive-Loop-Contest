do -- script FireProjectile
	
	-- get reference to the script
	local thisBehavior = LUA.script;
	local projectilePrefab = SerializedField("Projectile", Rigidbody);
	local launchForce = SerializedField("Launch Force", Vector3);
	local projectile = nil;
	
	-- start only called at beginning
	function thisBehavior.Start()
	end

	function thisBehavior.SpawnProjectile()
		projectile = Instantiate(projectilePrefab);
	end
	
	function thisBehavior.LaunchProjectile(scalar)
		projectile.AddRelativeForce(scalar * launchForce, ForceMode.Impulse);
		projectile = nil;
	end
end