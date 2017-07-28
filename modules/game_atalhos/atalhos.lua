-- Public functions
local toolButton = nil
local mouseGrabberWidget = nil
function init()
	bar = g_ui.displayUI('Atalhos', modules.game_interface.getRootPanel())
	g_keyboard.bindKeyDown('Ctrl+A', toggle)

	bar:setOn(false)
	bar:setVisible(false)  
	bar:setDraggable(true)

	toolButton = modules.client_topmenu.addCustomRightButton('toolButton', tr('Ferramentas') .. ' (Ctrl+A)', '/images/icons/tool_icon', toggle, false)
	toolButton:setOn(false)
	toolButton:setVisible(false)

   
	connect(g_game, {
		onGameStart = online,
		onGameEnd = offline,
	})

	if g_game.isOnline() then
		online()
	end
end

function flyUp()
	g_game.talk('h1')
end

function flyDown()
	g_game.talk('h2')
end

function cd()
	g_game.talk('!cd')
end

function online()
	bar:setOn(true)
	bar:setVisible(true)  
	toolButton:setVisible(true)
	toolButton:setOn(true)
end

function toggle()
	if toolButton:isOn() then
		hideTool()
		toolButton:setIcon('/images/icons/tool_icon_off')
		toolButton:setOn(false)
	else
		showTool()
		toolButton:setIcon('/images/icons/tool_icon')
		toolButton:setOn(true)
	end
end

function hideTool()
	bar:hide()
end

function offline()
	hideTool()
	bar:setOn(false)
	bar:setVisible(false) 
	toolButton:setVisible(false)
end

function showTool()
	bar:show()
end
function terminate()
	disconnect(g_game, {
		onGameStart = online,
		onGameEnd = offline,
	})
	bar:destroy()
end
-- End public functions