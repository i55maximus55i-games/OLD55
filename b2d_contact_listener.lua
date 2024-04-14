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
			player.jumpCounter = 1
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