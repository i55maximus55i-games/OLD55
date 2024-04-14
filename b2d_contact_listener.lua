function beginContact(a, b, coll)
	if a:getUserData().type == "player" or b:getUserData().type == "player" then
		local player = {}
		local other = {}
		if a:getUserData().type == "player" then 
			player = a:getUserData()
			other = b:getUserData()
		else 
			other = a:getUserData()
			player = b:getUserData()
		end

		-- Игроки ходят сквозь друг друга
		if other.type == "player" then coll:setEnabled(false) end
		-- Игрок стоит на платформе, обновляем доступность прыжков
		if other.type == "platform_up" then
			player.jumpCounter = 0
			player.isJump = false
			if player.state == "run_punch" then
				player.state = "run"
				player.stateTimer = 0
			end
			if player.state == "sexkick" then
				player.state = "idle"
				player.stateTimer = 0
			end
			if player.state == "ass" then
				player.state = "idle"
				local vx, vy = player.body:getLinearVelocity()
				player.body:setLinearVelocity(vx, -300)
				player.stateTimer = 0
			end
			if player.state == "stun" then
				player.state = "idle"
				player.stateTimer = 0
				player.stun = -1
			end
		end
		-- Коллайдеры для прилипания к платформам
		if other.type == "platform_left" then
			player.jumpCounter = 0
			player.wallstick = -1
		end
		-- Коллайдеры для прилипания к платформам
		if other.type == "platform_right" then
			player.jumpCounter = 0
			player.wallstick = 1
		end
	end

	local ad = a:getUserData()
	local bd = b:getUserData()
	if (ad.type == "random" and ad.collide) then print("case ab", ad.type, bd.type) ad.collide(a,b) end
	if (bd.type == "random" and bd.collide) then print("case ba", ad.type, bd.type) bd.collide(b,a) end
end

function endContact(a, b, coll)
	if a:getUserData().type == "player" or b:getUserData().type == "player" then
		local player = {}
		local other = {}
		if a:getUserData().type == "player" then 
			player = a:getUserData()
			other = b:getUserData()
		else 
			other = a:getUserData()
			player = b:getUserData()
		end

		-- Игрок ушёл с платформы, обновляем доступность прыжков
		if other.type == "platform_up" then 
			if player.state == "run_punch" then
			elseif player.state == "sexkick" then
			elseif player.state == "upper" then
			else 
				player.isJump = true
				if player.jumpCounter == 0 then player.stateTimer = 0.15 else player.stateTimer = 0 end
				player.jumpCounter = 1
			end
		end
		-- Коллайдеры для прилипания к платформам
		if other.type == "platform_left" or other.type == "platform_right" then
			player.jumpCounter = 1
			player.wallstick = 0
		end
	end
end

function preSolve(a, b, coll)
	if a:getUserData().type == "player" or b:getUserData().type == "player" then
		local player = {}
		local other = {}
		if a:getUserData().type == "player" then 
			player = a:getUserData()
			other = b:getUserData()
		else 
			other = a:getUserData()
			player = b:getUserData()
		end

		-- Игроки ходят сквозь друг друга
		if other.type == "player" then coll:setEnabled(false) end
	end
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
	
end