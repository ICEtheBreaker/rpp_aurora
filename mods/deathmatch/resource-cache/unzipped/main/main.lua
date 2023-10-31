local a = 10

function onPlayerJoin ()
    local player = source
    
    outputChatBox("Добро пожаловать , " .. getPlayerName(player) .. "!",player)

    if IsPlayerAdmin(player) then
        outputChatBox("Салам админ !" , admin)
    end
end

AddEventHandler("onPlayerJoin", getRootElement(), onPlayerJoin)