local require = using("BodyEditor.Script")
local CCDirector = require("CCDirector")
local oVec2 = require("oVec2")
local CCLayer = require("CCLayer")
local CCMenu = require("CCMenu")
local CCNode = require("CCNode")
local CCDrawNode = require("CCDrawNode")
local ccColor4 = require("ccColor4")
local CCClipNode = require("CCClipNode")
local CCSize = require("CCSize")
local CCRect = require("CCRect")
local oEase = require("oEase")
local CCSequence = require("CCSequence")
local CCSpawn = require("CCSpawn")
local oOpacity = require("oOpacity")
local oScale = require("oScale")
local CCCall = require("CCCall")

local function oSelectionPanel(borderSize,noCliping,noMask)
	local winSize = CCDirector.winSize
	local halfBW = borderSize.width*0.5
	local halfBH = borderSize.height*0.5
	local viewWidth = 0
	local viewHeight = 0
	local moveY = 0
	local moveX = 0
	local totalDelta = oVec2.zero
	local paddingY = 200
	local paddingX = 200
	local startPos = oVec2.zero
	local time = 0
	local _s = oVec2.zero
	local _v = oVec2.zero
	local deltaMoveLength = 0
	local panel = CCLayer()
	panel.anchor = oVec2.zero
	panel.touchEnabled = true

	if not noMask then
		local mask = CCLayer()
		mask.anchor = oVec2.zero
		mask.touchPriority = CCMenu.DefaultHandlerPriority-1
		mask.swallowTouches = true
		mask.touchEnabled = true
		mask:slot("TouchBegan",function() return panel.visible end)
		panel:addChild(mask)
		panel.mask = mask
	end

	local border = CCNode()
	border.position = oVec2(winSize.width*0.5,winSize.height*0.5)
	panel:addChild(border)

	local view
	if noCliping then
		view = CCNode()
	else
		local stencil = CCDrawNode()
		stencil:drawPolygon(
		{
			oVec2(-halfBW+1,-halfBH+1),
			oVec2(halfBW-1,-halfBH+1),
			oVec2(halfBW-1,halfBH-1),
			oVec2(-halfBW+1,halfBH-1)
		},ccColor4())
		view = CCClipNode(stencil)
	end
	border:addChild(view)

	local menu = CCMenu()
	menu.swallowTouches = true
	menu.contentSize = CCSize(borderSize.width,borderSize.height)
	menu.touchPriority = CCMenu.DefaultHandlerPriority-2
	menu.anchor = oVec2(0,1)
	menu.position = oVec2(-halfBW,halfBH)

	local contentRect = CCRect(oVec2.zero,borderSize)
	local itemRect = CCRect.zero
	local function moveItems(delta)
		menu:eachChild(function(child)
			child.position = child.position + delta
			local positionX, positionY, width, height = child.positionX, child.positionY, child.width, child.height
			itemRect:set(positionX, positionY - height, width, height)
			child.visible = contentRect:intersectsRect(itemRect)
		end)
	end

	local function updateReset(deltaTime)
		local xVal = nil
		local yVal = nil
		time = time + deltaTime
		local t = time/4.0
		if t > 1.0 then t = 1.0 end

		if startPos.x > 0 then
			xVal = totalDelta.x
			totalDelta.x = oEase:func(oEase.OutExpo,t,startPos.x,0-startPos.x)
			xVal = totalDelta.x - xVal
		end
		if startPos.x < moveX then
			xVal = totalDelta.x
			totalDelta.x = oEase:func(oEase.OutBack,t,startPos.x,moveX-startPos.x)
			xVal = totalDelta.x - xVal
		end
		if startPos.y < 0 then
			yVal = totalDelta.y
			totalDelta.y = oEase:func(oEase.OutBack,t,startPos.y,0-startPos.y)
			yVal = totalDelta.y - yVal
		end
		if startPos.y > moveY then
			yVal = totalDelta.y
			totalDelta.y = oEase:func(oEase.OutBack,t,startPos.y,moveY-startPos.y)
			yVal = totalDelta.y - yVal
		end

		moveItems(oVec2(xVal and xVal or 0, yVal and yVal or 0))

		if t == 1.0 then
			panel:unschedule()
		end
	end

	local function isReseting()
		if totalDelta.x > 0 or totalDelta.x < moveX or totalDelta.y > moveY or totalDelta.y < 0 then
			return true
		end
		return false
	end

	local function startReset()
		startPos = totalDelta
		time = 0
		panel:schedule(updateReset)
	end

	local function setOffset(deltaPos, touching)
		local newPos = totalDelta + deltaPos

		if touching then
			if newPos.x > paddingX then
				newPos.x = paddingX
			elseif newPos.x-moveX < -paddingX then
				newPos.x = moveX-paddingX
			end
			if newPos.y < -paddingY then
				newPos.y = -paddingY
			elseif moveY-newPos.y < -paddingY then
				newPos.y = moveY+paddingY
			end
			deltaPos = newPos - totalDelta

			local lenY = 0
			local lenX = 0
			if newPos.y < 0 then
				lenY = -newPos.y/paddingY
			elseif newPos.y > moveY then
				lenY = (newPos.y-moveY)/paddingY
			end
			if newPos.x > 0 then
				lenX = newPos.x/paddingX
			elseif newPos.x < moveX then
				lenX = (moveX-newPos.x)/paddingX
			end
			if lenY > 0 then
				local v = 3*lenY
				deltaPos.y = deltaPos.y / (v > 1 and v*v or 1)
			end
			if lenX > 0 then
				local v = 3*lenX
				deltaPos.x = deltaPos.x / (v > 1 and v*v or 1)
			end
		else
			if newPos.x > paddingX then
				newPos.x = paddingX
			elseif newPos.x < moveX-paddingX then
				newPos.x = moveX-paddingX
			end
			if newPos.y < -paddingY then
				newPos.y = -paddingY
			elseif newPos.y > moveY+paddingY then
				newPos.y = moveY+paddingY
			end
			deltaPos = newPos - totalDelta
		end

		if viewWidth < borderSize.width then deltaPos.x = 0 end
		if viewHeight < borderSize.height then deltaPos.y = 0 end

		totalDelta = totalDelta + deltaPos

		moveItems(deltaPos)

		if not touching and (newPos.y < -paddingY*0.5 or newPos.y > moveY+paddingY*0.5 or newPos.x > paddingX*0.5 or newPos.x < moveX-paddingX*0.5) then
			startReset()
		end
	end
	view:addChild(menu)

	local accel = winSize.height*2
	local function updateSpeed(deltaTime)
		_v = _s / deltaTime
		if _v.length > accel then
			_v:normalize()
			_v = _v * accel
		end
		_s = oVec2.zero
	end
	local function updatePos(deltaTime)
		local dir = oVec2(_v.x,_v.y)
		dir:normalize()
		local a = dir * -accel
		local incX = _v.x > 0
		local incY = _v.y > 0
		_v = _v + a * deltaTime * 0.5
		local decX = _v.x < 0
		local decY = _v.y < 0
		if incX == decX and incY == decY then
			if isReseting() then
				startReset()
			else
				panel:unschedule()
			end
		else
			local ds = _v * deltaTime
			setOffset(ds, false)
		end
	end

	local function setPos(self,delta)
		local newPos = totalDelta+delta
		if newPos.x > 0 then
			newPos.x = 0
		elseif newPos.x-moveX < 0 then
			newPos.x = moveX
		end
		if newPos.y < 0 then
			newPos.y = 0
		elseif moveY < newPos.y then
			newPos.y = moveY
		end
		delta = newPos - totalDelta
		if viewWidth < borderSize.width then delta.x = 0 end
		if viewHeight < borderSize.height then delta.y = 0 end

		totalDelta = totalDelta + delta

		moveItems(delta)
	end
	panel.setPos = setPos

	panel.touchPriority = CCMenu.DefaultHandlerPriority-3
	panel:slot("TouchBegan",function(touch)
		if touch.id ~= 0 then
			return false
		end
		if not CCRect(oVec2(winSize.width-borderSize.width,winSize.height-borderSize.height)*0.5, borderSize):containsPoint(panel:convertToNodeSpace(touch.location)) then
			return false
		end

		deltaMoveLength = 0
		menu.enabled = true
		_s = oVec2.zero
		_v = oVec2.zero
		panel:schedule(updateSpeed)
		return true
	end)

	local function touchEnded()
		menu.enabled = true
		if isReseting() then
			startReset()
		else
			if _v ~= oVec2.zero and deltaMoveLength > 10 then
				panel:schedule(updatePos)
			end
		end
	end
	panel:slot("TouchEnded",touchEnded)
	panel:slot("TouchCancelled",touchEnded)

	panel:slot("TouchMoved",function(touch)
		deltaMoveLength = deltaMoveLength + touch.delta.length
		_s = touch.delta
		if deltaMoveLength > 10 then
			menu.enabled = false
			setOffset(touch.delta, true)
		end
	end)

	panel.view = view
	panel.border = border
	panel.menu = menu

	panel.show = function(self)
		if panel.mask then panel.mask.touchEnabled = true end
		panel.visible = true
		panel.touchEnabled = true
		border.scaleX = 0.3
		border.scaleY = 0.3
		border.opacity = 0
		border:stopAllActions()
		border:runAction(
			CCSequence(
			{
				CCSpawn(
				{
					oOpacity(0.3,1),
					oScale(0.3,1,1,oEase.OutBack)
				}),
				CCCall(
					function()
						if panel.init then
							panel:init()
						end
					end)
			}))
	end

	panel.isAutoRemove = true
	panel.hide = function(self)
		panel.touchEnabled = false
		menu.enabled = false
		border:stopAllActions()
		border:runAction(
			CCSequence(
			{
				CCSpawn(
				{
					oOpacity(0.3,0),
					oScale(0.3,0.3,0.3,oEase.InBack)
				}),
				CCCall(
					function()
						panel:unschedule()
						panel.visible = false
						if panel.mask then panel.mask.touchEnabled = false end
						if panel.ended then
							panel:ended()
						end
						if panel.isAutoRemove then
							panel.parent:removeChild(panel)
						end
					end)
			}))
	end

	panel.reset = function(self,width,height,padX,padY)
		viewWidth = math.max(width,borderSize.width)
		viewHeight = math.max(height,borderSize.height)
		moveY = viewHeight-borderSize.height
		moveX = borderSize.width-viewWidth
		paddingX = padX
		paddingY = padY
		totalDelta = oVec2.zero
		startPos = oVec2.zero
		time = 0
		_s = oVec2.zero
		_v = oVec2.zero
		deltaMoveLength = 0
	end

	panel.getTotalDelta = function(self)
		return totalDelta
	end

	panel.updateSize = function(self,width,height)
		viewWidth = math.max(width,borderSize.width)
		viewHeight = math.max(height,borderSize.height)
		moveY = viewHeight-borderSize.height
		moveX = borderSize.width-viewWidth
	end

	return panel
end

return oSelectionPanel
