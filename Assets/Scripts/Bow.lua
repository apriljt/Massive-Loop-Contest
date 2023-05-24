do -- script Bow
	
	-- get reference to the script
	local thisBehavior = LUA.script;
	local projectileBehavior;
	local grab;
	local drawScalar = 0;

	local function clamp(value, min, max)
		if value < min then
			return min;
		elseif value > max then
			return max;
		else 
			return value;
		end
	end
	
	-- start only called at beginning
	function thisBehavior.Start()
		projectileBehavior = GetComponent(FireProjectile);
		grab = GetComponent(MLGrab);
	end

	
	-- update called every frame
	function thisBehavior.Update()
		if !MassiveLoop.IsInDesktopMode and grab.SecondaryHand ~= null then
			drawScalar = grab.SecondaryGrabPoint.localPosition.z - grab.SecondaryHand.localPosition.z;
			drawScalar = clamp(drawScalar, 0, 1);
		elseif MassiveLoop.IsInDesktopMode then
			drawScalar = math.sin(Time.time);
		end
	end
	
	function thisBehavior.Release()
		projectileBehavior.LaunchProjectile(drawScalar);
	end
end