function beginContact(a, b, coll)
	if a:getUserData().type == "player" and b:getUserData().type == "platform_up" then
		a:getUserData().jumpCounter = 0
	end
	if a:getUserData().type == "platform_up" and b:getUserData().type == "player" then
		b:getUserData().jumpCounter = 0
	end

	if a:getUserData().type == "platform_left" and b:getUserData().type == "player" then
		b:getUserData().wallstick = -1
		b:getUserData().jumpCounter = 1
	end
	if a:getUserData().type == "player" and b:getUserData().type == "platform_left" then
		a:getUserData().wallstick = -1
		a:getUserData().jumpCounter = 1
	end
	if a:getUserData().type == "platform_right" and b:getUserData().type == "player" then
		b:getUserData().wallstick = 1
		b:getUserData().jumpCounter = 1
	end
	if a:getUserData().type == "player" and b:getUserData().type == "platform_right" then
		a:getUserData().wallstick = 1
		a:getUserData().jumpCounter = 1
	end
end

function endContact(a, b, coll)
	if a:getUserData().type == "player" and b:getUserData().type == "platform_up" then
		a:getUserData().jumpCounter = 1
	end
	if a:getUserData().type == "platform_up" and b:getUserData().type == "player" then
		b:getUserData().jumpCounter = 1
	end

	if a:getUserData().type == "platform_left" and b:getUserData().type == "player" then
		b:getUserData().wallstick = 0
		b:getUserData().jumpCounter = 1
	end
	if a:getUserData().type == "player" and b:getUserData().type == "platform_left" then
		a:getUserData().wallstick = 0
		a:getUserData().jumpCounter = 1
	end
	if a:getUserData().type == "platform_right" and b:getUserData().type == "player" then
		b:getUserData().wallstick = 0
		b:getUserData().jumpCounter = 1
	end
	if a:getUserData().type == "player" and b:getUserData().type == "platform_right" then
		a:getUserData().wallstick = 0
		a:getUserData().jumpCounter = 1
	end
end

function preSolve(a, b, coll)
	if a:getUserData().type == "player" and b:getUserData().type == "platform" then
		local vx, vy = a:getUserData().body:getLinearVelocity()
		if vy < 0 then
			coll:setEnabled(false)
		end
	end
	if a:getUserData().type == "platform" and b:getUserData().type == "player" then
		local vx, vy = b:getUserData().body:getLinearVelocity()
		if vy < 0 then
			coll:setEnabled(false)
		end
	end
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
	
end