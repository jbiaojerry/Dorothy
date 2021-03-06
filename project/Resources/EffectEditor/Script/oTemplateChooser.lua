local require = using("EffectEditor.Script")
local CCDirector = require("CCDirector")
local CCSize = require("CCSize")
local oSelectionPanel = require("oSelectionPanel")
local CCDrawNode = require("CCDrawNode")
local oVec2 = require("oVec2")
local ccColor4 = require("ccColor4")
local CCMenu = require("CCMenu")
local oButton = require("oButton")
local CCLabelTTF = require("CCLabelTTF")
local ccColor3 = require("ccColor3")
local oOpacity = require("oOpacity")
local emit = require("emit")
local oContent = require("oContent")
local CCDictionary = require("CCDictionary")
local oCache = require("oCache")
local CCSequence = require("CCSequence")
local CCDelay = require("CCDelay")
local CCCall = require("CCCall")

local templates =
{
	fire = [[
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>angle</key>
    <real>90</real>
    <key>angleVariance</key>
    <real>360</real>
    <key>blendFuncDestination</key>
    <integer>1</integer>
    <key>blendFuncSource</key>
    <integer>770</integer>
    <key>duration</key>
    <real>-1</real>
    <key>emitterType</key>
    <real>0</real>
    <key>emissionRate</key>
    <real>350</real>
    <key>finishColorAlpha</key>
    <real>1</real>
    <key>finishColorBlue</key>
    <real>0</real>
    <key>finishColorGreen</key>
    <real>0</real>
    <key>finishColorRed</key>
    <real>0</real>
    <key>finishColorVarianceAlpha</key>
    <real>0</real>
    <key>finishColorVarianceBlue</key>
    <real>0</real>
    <key>finishColorVarianceGreen</key>
    <real>0</real>
    <key>finishColorVarianceRed</key>
    <real>0</real>
    <key>rotationStart</key>
    <real>0</real>
    <key>rotationStartVariance</key>
    <real>0</real>
    <key>rotationEnd</key>
    <real>0</real>
    <key>rotationEndVariance</key>
    <real>0</real>
    <key>finishParticleSize</key>
    <real>30</real>
    <key>finishParticleSizeVariance</key>
    <real>0</real>
    <key>gravityx</key>
    <real>0</real>
    <key>gravityy</key>
    <real>0</real>
    <key>maxParticles</key>
    <real>100</real>
    <key>maxRadius</key>
    <real>0</real>
    <key>maxRadiusVariance</key>
    <real>0</real>
    <key>minRadius</key>
    <real>0</real>
    <key>minRadiusVariance</key>
    <real>0</real>
    <key>particleLifespan</key>
    <real>1</real>
    <key>particleLifespanVariance</key>
    <real>0.5</real>
    <key>radialAccelVariance</key>
    <real>0</real>
    <key>radialAcceleration</key>
    <real>0</real>
    <key>rotatePerSecond</key>
    <real>0</real>
    <key>rotatePerSecondVariance</key>
    <real>0</real>
    <key>sourcePositionVariancex</key>
    <real>0</real>
    <key>sourcePositionVariancey</key>
    <real>0</real>
    <key>sourcePositionx</key>
    <real>0</real>
    <key>sourcePositiony</key>
    <real>0</real>
    <key>speed</key>
    <real>20</real>
    <key>speedVariance</key>
    <real>5</real>
    <key>startColorAlpha</key>
    <real>1</real>
    <key>startColorBlue</key>
    <real>0.1176471</real>
    <key>startColorGreen</key>
    <real>0.2431373</real>
    <key>startColorRed</key>
    <real>0.7568628</real>
    <key>startColorVarianceAlpha</key>
    <real>0</real>
    <key>startColorVarianceBlue</key>
    <real>0</real>
    <key>startColorVarianceGreen</key>
    <real>0</real>
    <key>startColorVarianceRed</key>
    <real>0</real>
    <key>startParticleSize</key>
    <real>30</real>
    <key>startParticleSizeVariance</key>
    <real>10</real>
    <key>tangentialAccelVariance</key>
    <real>0</real>
    <key>tangentialAcceleration</key>
    <real>0</real>
    <key>rotationIsDir</key>
    <real>0</real>
    <key>textureFileName</key>
    <string>__firePngData</string>
  </dict>
</plist>]],
	rain = [[
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
	<key>textureRecth</key>
	<real>0</real>
	<key>gravityx</key>
	<real>10</real>
	<key>emitterType</key>
	<real>0</real>
	<key>sourcePositionx</key>
	<real>0</real>
	<key>maxParticles</key>
	<real>400</real>
	<key>finishColorVarianceRed</key>
	<real>0</real>
	<key>finishColorVarianceBlue</key>
	<real>0</real>
	<key>startColorRed</key>
	<real>0</real>
	<key>tangentialAccelVariance</key>
	<real>0</real>
	<key>radialAccelVariance</key>
	<real>0</real>
	<key>textureRecty</key>
	<real>0</real>
	<key>startColorBlue</key>
	<real>1</real>
	<key>startColorGreen</key>
	<real>1</real>
	<key>startColorVarianceAlpha</key>
	<real>0.49019607843137</real>
	<key>angle</key>
	<real>-90</real>
	<key>startColorVarianceBlue</key>
	<real>0</real>
	<key>finishColorVarianceGreen</key>
	<real>0</real>
	<key>tangentialAcceleration</key>
	<real>0</real>
	<key>maxRadiusVariance</key>
	<real>0</real>
	<key>angleVariance</key>
	<real>0</real>
	<key>speedVariance</key>
	<real>30</real>
	<key>particleLifespanVariance</key>
	<real>0</real>
	<key>particleLifespan</key>
	<real>1.5</real>
	<key>minRadius</key>
	<real>0</real>
	<key>rotationIsDir</key>
	<real>0</real>
	<key>finishColorGreen</key>
	<real>1</real>
	<key>textureRectw</key>
	<real>0</real>
	<key>rotationStartVariance</key>
	<real>0</real>
	<key>textureRectx</key>
	<real>0</real>
	<key>rotatePerSecondVariance</key>
	<real>0</real>
	<key>finishColorBlue</key>
	<real>1</real>
	<key>rotatePerSecond</key>
	<real>0</real>
	<key>gravityy</key>
	<real>-10</real>
	<key>sourcePositionVariancey</key>
	<real>0</real>
	<key>blendFuncSource</key>
	<real>770</real>
	<key>finishColorAlpha</key>
	<real>0</real>
	<key>finishParticleSizeVariance</key>
	<real>0</real>
	<key>startColorAlpha</key>
	<real>0.70588235294118</real>
	<key>startColorVarianceRed</key>
	<real>0</real>
	<key>minRadiusVariance</key>
	<real>0</real>
	<key>maxRadius</key>
	<real>0</real>
	<key>finishParticleSize</key>
	<real>4</real>
	<key>startParticleSizeVariance</key>
	<real>2</real>
	<key>sourcePositionVariancex</key>
	<real>249</real>
	<key>duration</key>
	<real>-1</real>
	<key>textureFileName</key>
	<string>__firePngData</string>
	<key>startColorVarianceGreen</key>
	<real>0</real>
	<key>sourcePositiony</key>
	<real>0</real>
	<key>rotationStart</key>
	<real>0</real>
	<key>blendFuncDestination</key>
	<real>772</real>
	<key>radialAcceleration</key>
	<real>0</real>
	<key>speed</key>
	<real>400</real>
	<key>rotationEndVariance</key>
	<real>0</real>
	<key>finishColorVarianceAlpha</key>
	<real>0</real>
	<key>finishColorRed</key>
	<real>0</real>
	<key>startParticleSize</key>
	<real>4</real>
	<key>emissionRate</key>
	<real>80</real>
	<key>rotationEnd</key>
	<real>0</real>
  </dict>
</plist>]],
}

local function oTemplateChooser(filename)
	local oEditor = require("oEditor")
	local winSize = CCDirector.winSize
	local itemWidth = 120
	local itemNum = 3
	local borderSize = CCSize((itemWidth+10)*itemNum+10,winSize.height-200)
	local panel = oSelectionPanel(borderSize)
	local menu = panel.menu
	local border = panel.border
	local halfBW = borderSize.width*0.5
	local halfBH = borderSize.height*0.5
	local background= CCDrawNode()
	background:drawPolygon(
	{
		oVec2(-halfBW,-halfBH),
		oVec2(halfBW,-halfBH),
		oVec2(halfBW,halfBH),
		oVec2(-halfBW,halfBH)
	},ccColor4(0xe5100000),0.5,ccColor4(0x88ffafaf))
	border:addChild(background,-1)

	local opMenu = CCMenu()
	opMenu.swallowTouches = true
	opMenu.contentSize = CCSize(130,60)
	opMenu.anchor = oVec2(1,0.5)
	opMenu.touchPriority = CCMenu.DefaultHandlerPriority-3
	opMenu.position = oVec2(winSize.width*0.5+borderSize.width*0.5+30,winSize.height*0.5+borderSize.height*0.5)
	panel:addChild(opMenu)

	local cancelButton = oButton("Cancel",17,60,false,
		70,0,
		function(item)
			opMenu.enabled = false
			panel:hide()
			item.enabled = false
		end)
	cancelButton.anchor = oVec2.zero
	local btnBk = CCDrawNode()
	btnBk:drawDot(oVec2.zero,30,ccColor4(0x22ffffff))
	btnBk.position = oVec2(30,30)
	cancelButton:addChild(btnBk,-1)
	opMenu:addChild(cancelButton)

	local n = 0
	local y = 0
	local xStart = 0 -- left
	local yStart = borderSize.height -- top
	local function resetPanel()
		local yTo = winSize.height*0.5+halfBH-y+35
		local viewHeight = yTo < borderSize.height and borderSize.height or yTo
		local viewWidth = borderSize.width
		local paddingX = 0
		local paddingY = 100
		panel:reset(viewWidth,viewHeight,paddingX,paddingY)
	end

	local title = CCLabelTTF("Particle  Template","Arial",24)
	title.texture.antiAlias = false
	title.color = ccColor3(0x00ffff)
	title.anchor = oVec2(0.5,1)
	y = yStart-20
	title.position = oVec2(halfBW,y)
	menu:addChild(title)
	title.opacity = 0
	title:runAction(oOpacity(0.3,1))
	yStart = y-title.contentSize.height-10

	local pair = {true,true}
	local function updateAttr(name,value)
		pair[1] = name
		pair[2] = value
		emit("Effect.attr",pair)
	end

	local templateNames = {}
	for k,_ in pairs(templates) do
		table.insert(templateNames,k)
	end

	for i = 1,#templateNames do
		n = n+1
		y = yStart-35-math.floor((n-1)/itemNum)*60
		local itemName = templateNames[i]
		local button = oButton(
			itemName,
			17,
			itemWidth,50,
			xStart+itemWidth*0.5+10+((n-1)%itemNum)*(itemWidth+10), y,
			function(item)
				panel:hide()
				local templateName = item.template
				local file = oEditor.output..oEditor.prefix..filename
				oContent:saveToFile(file,templates[templateName])
				local name = filename:match("([^\\/]*)%.[^%.\\/]*$")
				oEditor.items[name] = filename
				oEditor.currentName = name
				oEditor.currentFile = filename
				oEditor:dumpEffectFile()

				local dict = CCDictionary(file)
				local parData = {}
				local dataWrapper = {}
				setmetatable(dataWrapper,
				{
					__newindex = function(_,key,value)
						if not oEditor.dirty then
							oEditor.dirty = rawget(parData,key) ~= value
						end
						rawset(parData,name,value)
					end,
					__index = function(_,key)
						return rawget(parData,key)
					end,
					__call = function(_)
						return parData
					end
				})
				oEditor.effectData = dataWrapper
				dict:each(function(k,v)
					parData[k] = v
				end)
				parData.textureRectx = 0
				parData.textureRecty = 0
				parData.textureRectw = 0
				parData.textureRecth = 0
				for k,v in pairs(parData) do
					updateAttr(k,v)
				end
				updateAttr("name",name)
				updateAttr("file",filename)
				oCache.Effect:load(oEditor.output..oEditor.listFile)
				emit("Effect.viewArea.changeEffect",name)
				oEditor:emit("Edited",oEditor.currentName,oEditor.prefix..oEditor.currentFile)
			end)
		button.template = itemName
		button.enabled = false
		button.opacity = 0
		button:runAction(
			CCSequence(
			{
				CCDelay(n*0.05),
				oOpacity(0.2,1),
				CCCall(function()
					button.enabled = true
				end)
			}))
		menu:addChild(button)
	end

	resetPanel()
	panel:show()
	return panel
end

return oTemplateChooser
