do -- script NewLuaBehavior 
	
	-- get reference to the script
	local NewLuaBehavior = LUA.script;
	local teleport_spot = SerializedField("Portal location" , GameObject);

	function NewLuaBehavior.OnTriggerEnter(collision)

		local objName = string.lower(tostring(collision.gameObject));
		Debug.Log("Collider of game object collided with: ".. objName);

		if collision.gameObject.isPlayer() then
			local player = collision.gameObject.GetPlayer();

			player.Teleport(teleport_spot.transform.position);
		end

	end

	-- start only called at beginning\
	function NewLuaBehavior.Start()

	end

	
	-- update called every frame
	function NewLuaBehavior.Update()

	
	end
end