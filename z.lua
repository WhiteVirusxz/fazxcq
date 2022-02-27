--[==[



  ___________________  ____  ___	      _____       .___         .__         
 /   _____/\______   \ \   \/  /	    /  _  \    __| _/  _____  |__|  ____  
 \_____  \  |     ___/  \     / 	   /  /_\  \  / __ |  /     \ |  | /    \ 
 /        \ |    |      /     \ 	   /    |    \/ /_/ | |  Y Y  \|  ||   |  \
/_______  / |____|     /___/\  \	  \____|__  /\____ | |__|_|  /|__||___|  /
        \/                   \_/	           \/      \/       \/          \/ 

╻
|	SP X Admin name is normal lol, it's like.. gLiTcHY
╹
╻
| Credits to:
|  • WhiteFo0x [aka Byte]
|
|
| Warns:
|  • Some code stealed from =>  Infinity Yield   ^^   CMD-X
|  • MINE MINE MINE MINE MINE MINE
|  • S-sorry.. I added to this dex.. but you can choose versions.. :)  (UwU)
╹
╻
| Updates logs:
| >> https://pastebin.com/raw/JhXdXWF6
|
|
| Current static:
|  • Version: v1.0.79b [BETA]
|  • Lines: dunno
|  • Commands: dunno
|  • Functioncs: dunno
╹



--]==]

_G.spxadmin = {
	ccs = {
		fly = {}
	}
}

local srv = setmetatable({}, {__index = function(Self, Index)
	local NewService = game.GetService(game, Index)
	if NewService then
		Self[Index] = NewService end
	return NewService
end})

local gameid = game.GameId
local lplr = srv.Players.LocalPlayer
local Mouse = lplr:GetMouse()

local primarycol = Color3.fromRGB(35,38,38)
local secondarycol = Color3.new(0,0,0)
local textcol = Color3.fromRGB(229,229,229)
local lastcommand = ""

local headSit,bang,bangAnim,argstosay;

local disconnected,flying,rfling,antifling,banging,following,alrnotifying =
	false,false,false,false,false,false,false

local GUI = Instance.new('ScreenGui')
local cmdsh = Instance.new('Frame',GUI)
local cmdbox = nil

if not syn then syn = {} end
if not is_sirhurt_closure and syn.protect_gui then syn.protect_gui(GUI) end

local funcs,cmds,cmdHandler,notifys = {},{},{},{}

local descendants = function(In)return In:GetDescendants()end
local firstchild = function(In,In2)return In:FindFirstChild(In2)end
local firstchildofc = function(In,In2,In3)if In3 then return In:FindFirstChildOfClass(In2,In3) else return In:FindFirstChildOfClass(In2)end;end
local con = function(In,func)return In:connect(func)end
local discon = function(In,In2)return In:Disconnect()end
local getpropersignal = function(In,In2)return In:GetPropertyChangedSignal(In2)end
local hwait = function(c)return srv.RunService.Heartbeat:wait(c or 0)end
local twplay = function(UI,TIME,TABLE)local t=srv.TweenService:Create(UI,TweenInfo.new(TIME,Enum.EasingStyle.Sine),TABLE)t:play()return t;end

function funcs.randomstring(Length)
	local Text = ""
	for i = 1,typeof(Length) == "number" and math.clamp(Length,1,100) or math.random(10,100) do
		Text = Text..string.char(math.random(1,128))
	end
	return Text
end

function set_properties(instance, properties)
	for i,p in pairs(properties) do
		instance[i] = p
	end
	instance.Name = funcs.randomstring()
end

function loaddef()
	prefix = 'c.'
	rflyspeed = 40
	antikick = false
	antirejoin = false
	shiftlock = false
	cmdboxkey = '\\'
	flykey = 'F'
end
function updatesave()
	local upd = {
		prefix = prefix;
		rflyspeed = rflyspeed;
		antikick = antikick;
		antirejoin = antirejoin;
		shiftlock = shiftlock;
		cmdboxkey = cmdboxkey;
		flykey = flykey;
	}
	writefile("NH-A.lua", srv.HttpService:JSONEncode(upd))
end
function loadsave()
	local saves
	local success, errorsend = pcall(function()
		saves = srv.HttpService:JSONDecode(readfile("NH-A.lua"))
	end)
	if not success then
		loaddef()
		updatesave()
		return
	end
	prefix = saves.prefix
	rflyspeed = saves.rflyspeed
	antikick = saves.antikick
	antirejoin = saves.antirejoin
	shiftlock = saves.shiftlock
	cmdboxkey = saves.cmdboxkey
	flykey = saves.flykey
end

local pohvalno = {
	['WhiteFo0x'] = 'Owner',
	['VannyVenumn'] = 'CoolUser',
	["Rainbow_Dose"] = 'CoolUser',
	["56789j7"] = 'CoolUser',
}
local mt,oldindex,ncallsa
do
	mt = getrawmetatable(game)
	oldindex = mt.__index
	ncallsa = mt.__namecall
	setreadonly(mt, false)
	mt.__index = newcclosure(function(self,...)
		local args = {...}
		if not checkcaller() and self == getParent and args[1] == GUI.Name then
			return nil
		end
		return oldindex(self,...)
	end)
	setreadonly(mt, true)

	set_properties(GUI,{Enabled = true, ResetOnSpawn = false, Parent = srv.CoreGui})
	if writefile and readfile then loadsave()else loaddef()end

	lplr.DevEnableMouseLock = shiftlock
end

-- Functions
function funcs.createnotif(TEXT,TYPE,DURAT,IFSOUND)
	-- open gui   {1,-250},{1,-220}
	-- hide gui   {1,-250},{2,-220}
	spawn(function()
		warn('start')
		repeat wait()until not alrnotifying
		alrnotifying = true
		warn('start2')
		local txt,icon;
		local function createNotify()
			local shadow = Instance.new("Frame")
			local out = Instance.new("Frame")
			local i_2 = Instance.new("UICorner")
			local UP_TXT = Instance.new("TextLabel")
			local DO_TXT = Instance.new("TextLabel")
			local LINE = Instance.new("Frame")
			local IMG = Instance.new("ImageLabel")
			set_properties(shadow,{
				Parent = GUI,
				BackgroundColor3 = Color3.fromRGB(33,33,33),
				BorderSizePixel = 0,
				Position = UDim2.new(1,0,1,0),
				Size = UDim2.new(0,184,0,100),
				Active = true,
				ZIndex = 11
			})
			set_properties(out,{
				Parent = shadow,
				BackgroundColor3 = Color3.fromRGB(34,34,34),
				BorderSizePixel = 0,
				Position = UDim2.new(.0155362329,0,.0288333334,0),
				Size = UDim2.new(0,178,0,94),
				Active = true,
				ZIndex = 11
			})
			set_properties(UP_TXT,{
				Parent = out,
				BackgroundColor3 = Color3.new(1,1,1),
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				Position = UDim2.new(.196629226,0,.0106382975,0),
				Size = UDim2.new(0,50,0,30),
				Font = Enum.Font.Cartoon,
				Text = "SPX",
				TextColor3 = Color3.new(1,1,1),
				TextSize = 24,
				TextStrokeColor3 = Color3.new(1,1,1),
				TextStrokeTransparency = .830,
				TextWrapped = true,
				Active = true,
				ZIndex = 11
			})
			set_properties(DO_TXT,{
				Parent = out,
				BackgroundColor3 = Color3.new(1,1,1),
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				Position = UDim2.new(0,0,.340425521,0),
				Size = UDim2.new(0,178,0,62),
				Font = Enum.Font.Cartoon,
				Text = "...",
				TextColor3 = Color3.new(1,1,1),
				TextSize = 18,
				TextStrokeColor3 = Color3.new(1,1,1),
				TextStrokeTransparency = .985,
				TextWrapped = true,
				Active = true,
				ZIndex = 11
			})
			set_properties(LINE,{
				Parent = out,
				BackgroundColor3 = Color3.new(1,1,1),
				BorderColor3 = Color3.new(1,1,1),
				Position = UDim2.new(.0337078646,0,.340425521,0),
				Size = UDim2.new(0,166,0,1),
				Active = true,
				ZIndex = 11
			})
			set_properties(IMG,{
				Parent = out,
				BackgroundColor3 = Color3.new(1,1,1),
				BackgroundTransparency = 1,
				Size = UDim2.new(0,29,0,29),
				Image = "rbxasset://textures/DevConsole/Warning.png",
				SliceScale = 0,
				Active = true,
				ZIndex = 11
			})

			set_properties(Instance.new("UICorner"),{
				Name = "i",
				Parent = shadow
			})
			set_properties(Instance.new("UICorner"),{
				Name = "i",
				Parent = out
			})

			txt,icon = DO_TXT,IMG;
			return shadow;
		end

		local nf;
		if TEXT and TYPE and DURAT then
			nf = createNotify()
			table.insert(notifys,nf)
			for _,g in next,notifys do twplay(g,.4,{Position = g.Position+UDim2.new(0,0,-1.05,0)})end
			if TYPE == 'warn'then
				icon.Image = 'rbxasset://textures/DevConsole/Warning.png'
				txt.Text = TEXT
				txt.TextColor3 = Color3.fromRGB(255,255,65)
			elseif TYPE == 'error'then
				icon.Image = 'rbxasset://textures/DevConsole/Error.png'
				txt.Text = TEXT
				txt.TextColor3 = Color3.fromRGB(255,65,65)
			elseif TYPE == 'succ'then
				icon.Image = 'rbxassetid://279548030'
				txt.Text = TEXT
				txt.TextColor3 = Color3.new(1,1,1)
			else return end
		else return end
		nf.Parent = GUI
		warn('created')
		if IFSOUND then funcs.soundnotify()end
		task.spawn(function()
			task.spawn(function()local tww = twplay(nf,.4,{Position = UDim2.new(1,-185,1,-110)})tww.Completed:wait()alrnotifying = false;end)
			warn('moving')
			task.delay(DURAT,function()
				for _ = 0,1.05,.05 do wait()
					nf.Transparency += _
					for z,c in next, nf:GetDescendants()do
						if c:IsA('Frame')then
							c.Transparency += _
						elseif c:IsA('ImageLabel')then
							c.ImageTransparency += _
						elseif c:IsA('TextLabel')then
							c.TextTransparency += _
							c.TextStrokeTransparency += _
						end
					end
				end
				task.wait(.05)
				nf:Destroy()
				warn('destroying')
				for _,t in next,notifys do if(t==nf)then t=nil;end;end
			end)
		end)
		warn('done\n-')
	end)
end

function funcs.soundnotify()
	coroutine.resume(coroutine.create(function()
		local s = Instance.new('Sound')
		s.Parent = srv.ContentProvider
		s.Looped = false
		s.Name = math.random()
		s.Volume = 10
		s.Pitch = 1
		s.SoundId = 'rbxassetid://956930900'
		s.PlayOnRemove = true
		pcall(function()
			s:Destroy()
		end)
	end))
end

function funcs.errormsg(a)
	if a == 1 then
		return funcs.createnotif('Argument 1 missing or nil.','error',5,false)
	elseif a == 2 then
		return funcs.createnotif('Argument 2 missing or nil.','error',5,false)
	elseif a == 'boolean' then
		return funcs.createnotif('Argument 1 can be only boolean value.','error',5,false)
	elseif a == 'key' then
		return funcs.createnotif('Argument 1 must be a key.','error',5,false)
	elseif a == 'uerr' then
		return funcs.createnotif('Unknown error.','error',5,false)
	end
	-- funcs.errormsg()
end

function funcs.split(str,sep)
	sep=sep or '%s'
	local t={}
	for field,s in string.gmatch(str, "([^"..sep.."]*)("..sep.."?)") do
		table.insert(t,field)
		if s=="" then
			return t
		end
	end
end

function funcs.getstring(oh)
	local start = oh-1
	local scv = '' for i,v in pairs(argstosay) do
		if i > start then
			if scv ~= '' then
				scv = scv .. ' ' .. v
			else
				scv = scv .. v
			end
		end
	end
	return scv
end

function funcs.ccmdsl()
	discon(_G.spxadmin.ccs.cmdlc)
	discon(_G.spxadmin.ccs.cmdlcs)
	for _,f in next, descendants(GUI)do
		pcall(function()
			srv.TweenService:Create(f,TweenInfo.new(0.75),{Transparency = 1}):Play()
			srv.TweenService:Create(f,TweenInfo.new(0.75),{ScrollBarImageTransparency = 1}):Play()
		end)
		task.delay(0.76,function()
			f:Destroy()
			hwait()
		end)
	end
end

function funcs.findplayer(target)
	if target == 'me' then
		return lplr
	end
	for _,p in next, srv.Players:children() do
		local pn = string.lower(p.Name)
		local pd = string.lower(p.DisplayName)
		if (string.sub(target,1,#target)==string.sub(pn,1,#target) or string.sub(target,1,#target)==string.sub(pd,1,#target)) then
			return p
		end
	end
	funcs.createnotif(target..' is not a player.','error',5,false)
	return nil
end

function funcs.getRoot(char)
	local rootPart = firstchildofc(char,'Humanoid').RootPart
	return rootPart
end

function funcs.getHum(char)
	local hum = firstchildofc(char,'Humanoid',true)
	return hum
end

function funcs.minmax(num,min,max,mode)
	if num==nil then return funcs.errormsg('uerr')end
	local retard = 'Error' 
	if typeof(num) == 'string' then
		num = #num
	end
	if mode == 'len'then
		if min and (num < min) then
			retard = ('Argument length can\'t be less than '..min)
		elseif max and (num > max) then
			retard = ('Argument length can\'t be more than '..max)
		elseif min and (num < min or num == min)then
			return'acc'
		elseif max and (num < max or num == max)then
			return'acc'
		else
			return funcs.errormsg('uerr')
		end
	elseif mode == 'def'then
		if min and (num < min) then
			retard = ('Argument can\'t be less than '..min)
		elseif max and (num > max) then
			retard = ('Argument can\'t be more than '..max)
		elseif min and (num < min or num == min)then
			return'acc'
		elseif max and (num < max or num == max)then
			return'acc'
		else
			return funcs.errormsg('uerr')
		end
	end
	return funcs.createnotif(retard,'error',5,false)
end

function funcs.toboolean(v)
	if v=='false'then return false;elseif v=='true'then return true;else return nil;end
end

function funcs.anti(w,oh)
	if typeof(oh)~='boolean'then return funcs.errormsg('boolean') end
	setreadonly(mt, false)
	if w == 'Kick'then
		if not antikick then
			local ncallsa = mt.__namecall
			mt.__namecall = newcclosure(function(...)
				local args = {...}
				if not checkcaller() and getnamecallmethod() == "Kick" then
					return nil
				end
				return ncallsa(...)
			end)
		end
		antikick = oh
	elseif w == 'Rejoin'then
		if not antirejoin then
			local ncallsa = mt.__namecall
			mt.__namecall = newcclosure(function(...)
				local args = {...}
				if not checkcaller() and (getnamecallmethod() == "Teleport" or getnamecallmethod() == "TeleportToPlaceInstance") then
					return nil
				end
				return ncallsa(...)
			end)
		end
		antirejoin = oh
	else return	end
	setreadonly(mt, true)
	return funcs.createnotif('Anti-'..w..' is now '..tostring(oh),'succ',5,false);
end

-- Commands
function cmds.exit(args)
	disconnected = true
	coroutine.resume(coroutine.create(function()
		for _,f in next, descendants(GUI)do
			pcall(function()
				f.Transparency = 1
				f.ScrollBarImageTransparency = 1
			end)
			f:Destroy()
		end
		pcall(function()
			flying = false
			rfling = false
			for _,c in next, _G.spxadmin.ccs do
				discon(_)
				_ = nil
			end
		end)
	end))
end

function cmds.commands(args)
	set_properties(GUI,{Enabled = false, Parent = srv.CoreGui})
	cmdsh = Instance.new('Frame',GUI)
	set_properties(cmdsh,{BackgroundColor3 = Color3.fromRGB(25,25,25), BackgroundTransparency = 0.3, Position = UDim2.new(0.709,0,0.335,0), Size = UDim2.new(0,309,0,281), ClipsDescendants = true})
	local aspect = Instance.new('UIAspectRatioConstraint',cmdsh)
	set_properties(aspect,{AspectRatio = 1, DominantAxis = "Width", AspectType = "ScaleWithParentSize"})
	local corn1 = Instance.new('UICorner',cmdsh)
	set_properties(corn1,{CornerRadius = UDim.new(0,9)})
	local newCMD = Instance.new('TextLabel')
	set_properties(newCMD,{BackgroundColor3 = Color3.fromRGB(63,63,63), BackgroundTransparency = 0.6, Position = UDim2.new(0,0,-0.004,0), Size = UDim2.new(0,309,0,18),Font = "Roboto", Text = '...', TextColor3 = Color3.fromRGB(255,255,225), TextSize = 14, BorderSizePixel = 0})
	local CMDc = Instance.new('ScrollingFrame',cmdsh)
	set_properties(CMDc,{BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0,0,0.174,0), Size = UDim2.new(0,309,0,249), ClipsDescendants = true, AutomaticCanvasSize = 'Y', CanvasSize = UDim2.new(0,0,0,0), ScrollBarImageTransparency = 0.5, ScrollBarThickness = 7, ScrollingDirection = 'Y'})
	local listlay = Instance.new('UIListLayout',CMDc)
	set_properties(listlay,{Padding = UDim.new(0,2)})
	local searchbox = Instance.new('TextBox',cmdsh)
	set_properties(searchbox,{Text = "", BackgroundColor3 = Color3.fromRGB(22,22,22), BorderSizePixel = 0, Position = UDim2.new(0,0,0.092,0), Size = UDim2.new(0,309,0,16), Font = 'Cartoon', TextSize = 14, PlaceholderText = 'Search a command', TextColor3 = Color3.new(1,1,1)})
	local clcmd = Instance.new('TextButton',cmdsh)
	set_properties(clcmd,{BackgroundColor3 = Color3.fromRGB(255,67,67), Position = UDim2.new(0.95,0,0.012,0), Size = UDim2.new(0,12,0,12), Text = ''})
	local corn2 = Instance.new('UICorner',clcmd)
	set_properties(corn2,{CornerRadius = UDim.new(0,15)})
	local cml = Instance.new('TextLabel',cmdsh)
	set_properties(cml,{BackgroundTransparency = 1, Position = UDim2.new(0.476,0,0.025,0), Size = UDim2.new(0,14,0,18), Font = 'JosefinSans', TextColor3 = Color3.new(1,1,1), Text = 'Commands list', TextSize = 17})
	for _,v in next, cmds do
		for __,c in next, cmdHandler do
			if _==__ then
				local command = newCMD:Clone()
				command.Name = funcs.randomstring()
				command.Text = _..' | '..c[1]
				command.Parent = CMDc
				hwait()
			end
		end
	end
	local function updateSearch(c)
		local tosearch = string.lower(searchbox.Text)
		for _,c in next, CMDc:children() do
			if c:IsA("TextLabel") then
				if tosearch ~= "" then
					local cmd = string.lower(c.Text)
					if cmd:find(tosearch) then
						c.Visible = true
					else
						c.Visible = false
					end
				else
					c.Visible = true
				end
			end
		end
	end
	_G.spxadmin.ccs.cmdlc = con(clcmd.MouseButton1Click,funcs.ccmdsl)
	_G.spxadmin.ccs.cmdlcs = con(getpropersignal(searchbox,'Text'),updateSearch)
	set_properties(GUI,{Enabled = true})
end

function cmds.rfly(args)
	if not flying and lplr.Character~=nil and not following and not banging then
		flying = true
		local Keys,Timing = {W = false,A = false,S = false,D = false},{Throttle = 1,Sine = 0,LastFrame = tick()}
		local Movement = {
			Attacking = false,
			Flying = false,
			CFrame = funcs.getRoot(lplr.Character).CFrame,
			PotentialCFrame = funcs.getRoot(lplr.Character).CFrame,
			Walking = false,
			WalkSpeed = rflyspeed,
			Falling = false
		}

		local Camera = workspace.CurrentCamera
		local LookVector = Camera.CFrame.LookVector

		local RayProperties = RaycastParams.new()
		RayProperties.FilterType = Enum.RaycastFilterType.Blacklist
		RayProperties.IgnoreWater = true

		local function MoveCharacter(X,Z)
			Movement.PotentialCFrame = Movement.PotentialCFrame*CFrame.new(X,0,Z)
		end

		local function Clerp(a,b,t)
			return a:Lerp(b,t < 1 and math.clamp(t*Timing.Throttle,0,1) or 1)
		end

		local function mkeydown(Key_)
			local Key_ = string.upper(Key_)
			if Keys[Key_] ~= nil then
				Keys[Key_] = true
			else
				if Key_ == flykey then
					Movement.Flying = not Movement.Flying
					Movement.CFrame = CFrame.new(Movement.CFrame.Position)
				end
			end
		end
		_G.spxadmin.ccs.fly.MKeyDown = con(Mouse.KeyDown,mkeydown)

		local function mkeyup(Key_)
			local Key_ = string.upper(Key_)
			if Keys[Key_] ~= nil then
				Keys[Key_] = false
			end
		end
		_G.spxadmin.ccs.fly.MKeyUp = con(Mouse.KeyUp,mkeyup)
		task.spawn(function()
			while flying do task.wait()
				if lplr.Character~=nil then
					local suc, err = pcall(function()
						local hump = funcs.getRoot(lplr.Character)
						funcs.getHum(lplr.Character).Sit = false
						if rfling then
							funcs.getRoot(lplr.Character).Velocity = Vector3.new(512,0,512)end
						Timing.Throttle,Timing.Sine = (tick()-Timing.LastFrame)/(1/60),Timing.Sine+(tick()-Timing.LastFrame)*60
						Timing.LastFrame = tick()
						if lplr then
							Camera = workspace.CurrentCamera
							LookVector = Camera.CFrame.LookVector
							local CameraRay = workspace:Raycast(workspace.CurrentCamera.Focus.Position,-workspace.CurrentCamera.CFrame.LookVector
								*(workspace.CurrentCamera.CFrame.Position-workspace.CurrentCamera.Focus.Position).Magnitude,RayProperties)
							if CameraRay then
								workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame*
									CFrame.new(0,0,-(workspace.CurrentCamera.CFrame.Position-workspace.CurrentCamera.Focus.Position)
										.Magnitude)*CFrame.new(0,0,(workspace.CurrentCamera.Focus.Position-CameraRay.Position)
									.Magnitude*.99)
							end
						end
						if not Movement.Flying then
							local Ray_ = workspace:Raycast(Movement.CFrame.Position,Vector3.new(0,-9999999,0),RayProperties)
							local Ray2_ = workspace:Raycast(hump.CFrame.Position,Vector3.new(0,-9999999,0),RayProperties)
							if Ray_ and Ray2_ then
								Movement.Falling = false
								local NewCFrame = Movement.CFrame*CFrame.new(0,(Ray2_.Position.Y-Movement.CFrame.Y)+1.35,0)
								Movement.CFrame = Clerp(Movement.CFrame,NewCFrame,.1)
								if (Movement.CFrame.Position-NewCFrame.Position).Magnitude > 1 then
									Movement.Falling = true
								end
							else
								Movement.Falling = true
								local ooofe = workspace.FallenPartsDestroyHeight+400
								if Movement.CFrame.Y < ooofe or funcs.getRoot(lplr.Character).CFrame.Y < ooofe then
									Movement.CFrame = Movement.CFrame*CFrame.new(0,900,0)
									hump.CFrame = Movement.CFrame
								else
									Movement.CFrame = Movement.CFrame*CFrame.new(0,-3*Timing.Throttle-math.clamp(Movement.CFrame.Y/100,0,1e4),0)
								end
							end
							local OldCFrame = Movement.CFrame
							Movement.PotentialCFrame = CFrame.new(Movement.CFrame.Position,Vector3.new(Movement.CFrame.X+LookVector.X,Movement.CFrame.Y,Movement.CFrame.Z+LookVector.Z))
							if Keys.W then
								MoveCharacter(0,-.5)
							end
							if Keys.A then
								MoveCharacter(-.5,0)
							end
							if Keys.S then
								MoveCharacter(0,.5)
							end
							if Keys.D then
								MoveCharacter(.5,0)
							end
							hump.CFrame = Movement.CFrame
							if (Movement.PotentialCFrame.X ~= OldCFrame.X or Movement.PotentialCFrame.Z ~= OldCFrame.Z) and Movement.WalkSpeed > 0 then
								Movement.Walking = true
								Movement.CFrame = CFrame.new(Movement.CFrame.Position,Movement.PotentialCFrame.Position)*CFrame.new(0,0,-((Movement.WalkSpeed/60)*Timing.Throttle))
								Movement.CFrame = CFrame.new(Movement.CFrame.Position)*(OldCFrame-OldCFrame.Position)
								Movement.CFrame = Clerp(Movement.CFrame,CFrame.new(Movement.CFrame.Position,Vector3.new(OldCFrame.X,Movement.CFrame.Y,OldCFrame.Z))*CFrame.Angles(0,math.rad(180),0),.15)
							else
								Movement.Walking = false
							end
						else
							local OldCFrame = Movement.CFrame
							Movement.PotentialCFrame = CFrame.new(Movement.CFrame.Position,Movement.CFrame.Position+LookVector)
							if Keys.W then
								MoveCharacter(0,-.5)
							end
							if Keys.A then
								MoveCharacter(-.5,0)
							end
							if Keys.S then
								MoveCharacter(0,.5)
							end
							if Keys.D then
								MoveCharacter(.5,0)
							end
							hump.CFrame = Movement.CFrame
							if (Movement.PotentialCFrame.X ~= OldCFrame.X or Movement.PotentialCFrame.Z ~= OldCFrame.Z) and Movement.WalkSpeed > 0 then
								Movement.Walking = true
								Movement.CFrame = CFrame.new(Movement.CFrame.Position,Movement.PotentialCFrame.Position)*CFrame.new(0,0,-((Movement.WalkSpeed/60)*Timing.Throttle))
								Movement.CFrame = CFrame.new(Movement.CFrame.Position,Movement.CFrame.Position+LookVector)
							else
								Movement.Walking = false
							end
						end
						lplr.CameraMode = Enum.CameraMode.Classic
						workspace.CurrentCamera.FieldOfViewMode = Enum.FieldOfViewMode.Vertical
						if srv.UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
							if not Movement.Flying then
								Movement.CFrame = CFrame.new(Movement.CFrame.Position,Vector3.new(Movement.CFrame.X+LookVector.X,Movement.CFrame.Y,Movement.CFrame.Z+LookVector.Z))
							else
								Movement.CFrame = CFrame.new(Movement.CFrame.Position,Movement.CFrame.Position+LookVector)
							end
						end
						Movement.WalkSpeed = rflyspeed
					end)
				end
			end
		end)
		funcs.createnotif('Fly is now on','succ',5,false)
	elseif flying then
		rfling = false
		wait()
		flying = false
		for _,c in next, _G.spxadmin.ccs.fly do
			discon(c)
		end
		funcs.createnotif('Fly is now off','succ',5,false)
	end
end

function cmds.rflyspeed(args)
	if args[1]==nil then return funcs.errormsg(1) end
	local speed = tonumber(args[1])
	if funcs.minmax(speed,1,800,'def')=='acc'then
		rflyspeed = speed
		return funcs.createnotif('RFlySpeed setted to '..speed,'succ',5,false)
	end
end

function cmds.rejoin(args)
	local TeleportService = srv.TeleportService
	if (#srv.Players:GetPlayers() == 1) then
		TeleportService.Teleport(TeleportService, game.PlaceId);
	else
		TeleportService.TeleportToPlaceInstance(TeleportService, game.PlaceId, game.JobId)
	end
end

function cmds.rfling(args)
	rfling = not rfling
	funcs.createnotif('RFling is now '..tostring(rfling),'succ',5,false)
end

function cmds.view(args)
	if args[1]==nil then return funcs.errormsg(1) end
	local p = funcs.findplayer(args[1])
	if p~=nil then
		if p.Character~=nil and funcs.getRoot(p.Character) then
			local cam = workspace.CurrentCamera
			local tarh =funcs.getHum(p.Character)
			if tarh~=nil then
				cam.CameraSubject = tarh
			end
		end
	end
end

function cmds.unview(args)
	if lplr.Character~=nil and funcs.getHum(lplr.Character)then
		local cam = workspace.CurrentCamera
		local hum = funcs.getHum(lplr.Character)
		if hum~=nil then
			cam.CameraSubject = hum
		end
	end
end

function cmds.sync(args)
	if args[1]==nil then return funcs.errormsg(1) end
	if gameid ~= 492245779 then return funcs.createnotif('Game not in my game list.','warn',5,false)end
	local p = funcs.findplayer(args[1])
	if p~=nil and p~=lplr then
		local ocean = "OceanPrimary"
		local dragon = "DragonThird"
		local wing = "RightWing3"

		local mk1 = srv.ReplicatedStorage.MasterKey
		--local mk2 = service.ReplicatedStorage.MasterKey2
		--local mf = service.ReplicatedStorage.MasterFunction

		local key1 = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151".."\153"
		local key2 = "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD"

		local function syncfunc(a,b,v)
			local args = {}
			local nt = nil
			if v~=nil then
				nt = v.Parent.Head:FindFirstChild('NameTag').Main
			end
			if a == 0 then
				args = {
					[1] = "Material",
					[2] = v.Material,
					[3] = {[1] = v.Name}
				}
			elseif a == 1 then
				args = {
					[1] = "customize",
					[2] = {[1] = v.Name},
					[3] = v.Color,
					[4] = "Body"
				}
			elseif a == 2 then
				args = {
					[1] = "Wings",
					[2] = b,
					[3] = key2
				}
			elseif a == 3 then
				args = {
					[1] = "Ocean",
					[2] = b,
					[3] = key2
				}
			elseif a == 4 then
				args = {
					[1] = "Dragon",
					[2] = b,
					[3] = key2
				}
			elseif a == 5 then
				args = {
					[1] = "Fluff",
					[2] = "ChestFluff",
					[3] = b
				}
			elseif a == 6 then
				args = {
					[1] = "Fluff",
					[2] = "BackFluff",
					[3] = b
				}
			elseif a == 7 then
				args = {
					[1] = "Fluff",
					[2] = "EarFluff",
					[3] = b
				}
			elseif a == 8 then
				args = {
					[1] = "Fluff",
					[2] = "JawFluff",
					[3] = b
				}
			elseif a == 9 then
				args = {
					[1] = "Fluff",
					[2] = "TailFluff",
					[3] = b
				}
			elseif a == 10 then
				args = {
					[1] = "ChangeDesc",
					[2] = nt.Description.Text,
					[3] = key1
				}
			elseif a == 11 then
				args = {
					[1] = "ChangeName",
					[2] = nt.Username.Text,
					[3] = key1
				}
			end
			return unpack(args);
		end
		coroutine.resume(coroutine.create(function()
			if p.Character ~= nil and funcs.getRoot(p.Character) then
				for _,v in next, p.Character:children()do
					if v:IsA('Part') or v:IsA('MeshPart') or v:IsA('UnionOperation') then
						mk1:FireServer(syncfunc(1,nil,v))
						mk1:FireServer(syncfunc(0,nil,v))
						mk1:FireServer(syncfunc(10,nil,v))
						mk1:FireServer(syncfunc(11,nil,v))

						local pc = v.Parent
						if firstchild(pc,ocean) and firstchild(pc,ocean).Transparency == 0 then
							mk1:FireServer(syncfunc(3,0,nil))
						else
							mk1:FireServer(syncfunc(3,1,nil))end
						if firstchild(pc,dragon) and firstchild(pc,dragon).Transparency == 0 then
							mk1:FireServer(syncfunc(4,0,nil))
						else
							mk1:FireServer(syncfunc(4,1,nil))end
						if firstchild(pc,wing) and firstchild(pc,wing).Transparency == 0 then
							mk1:FireServer(syncfunc(2,0,nil))
						else
							mk1:FireServer(syncfunc(2,1,nil))end
						if firstchild(pc,'ChestFluff') and firstchild(pc,'ChestFluff').Transparency == 0 then
							mk1:FireServer(syncfunc(5,0,nil))
						else
							mk1:FireServer(syncfunc(5,1,nil))end
						if firstchild(pc,'BackFluff') and firstchild(pc,'BackFluff').Transparency == 0 then
							mk1:FireServer(syncfunc(6,0,nil))
						else
							mk1:FireServer(syncfunc(6,1,nil))end
						if firstchild(pc,'EarFluff') and firstchild(pc,'EarFluff').Transparency == 0 then
							mk1:FireServer(syncfunc(7,0,nil))
						else
							mk1:FireServer(syncfunc(7,1,nil))end
						if firstchild(pc,'JawFluff') and firstchild(pc,'JawFluff').Transparency == 0 then
							mk1:FireServer(syncfunc(8,0,nil))
						else
							mk1:FireServer(syncfunc(8,1,nil))end
						if firstchild(pc,'TailFluff') and firstchild(pc,'TailFluff').Transparency == 0 then
							mk1:FireServer(syncfunc(9,0,nil))
						else
							mk1:FireServer(syncfunc(9,1,nil))end
					end
				end
			end
		end))
	end
end

function cmds.teleport(args)
	if args[1]==nil then return funcs.errormsg(1) end
	local p = funcs.findplayer(args[1])
	if p~=nil then
		if p.Character~=nil and funcs.getRoot(p.Character) and funcs.getRoot(lplr.Character) then
			local hum = funcs.getRoot(lplr.Character)
			local tarh = funcs.getRoot(p.Character)
			if hum~=nil and tarh~=nil then
				hum.CFrame = tarh.CFrame
			end
		end
	end
end

function cmds.prefix(args)
	if args[1]==nil then return end
	local pref = args[1]
	if funcs.minmax(#pref,1,3,'len')=='acc' then
		prefix = pref
		return funcs.createnotif('Prefix setted to '..pref,'succ',5,false)
	end
end

function cmds.music(args)
	if gameid == 492245779 then
		local key2 = "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD"

		local suc, err = pcall(function()
			local mk1 = srv.ReplicatedStorage.MasterKey
			if args[1] == nil then
				mk1:FireServer("StopMusic",nil,key2)
			else
				mk1:FireServer("PlayMusic",args[1],key2)
			end
		end)
		if not suc then
			return funcs.createnotif('Error: '..err,'error',5,false)
		end
	else
		return funcs.createnotif('Game not in my game list.','warn',5,false)
	end
end

function cmds.earrape(args)
	local s = Instance.new('Sound')
	s.Volume = 10
	s.SoundId = 'rbxassetid://6098866072'
	s.Pitch = 1
	s.Name = 'fuckyourself'
	s.PlayOnRemove = true
	s.Parent = srv.SoundService
	task.spawn(function()s:Destroy()end)
end

function cmds.bang(args)
	if args[1]==nil then return funcs.errormsg(1) end if args[2]==nil then return funcs.errormsg(2) end
	local speedbang = tonumber(args[2])
	if funcs.minmax(speedbang,1,15,'def')=='acc'then
		local p = funcs.findplayer(args[1])
		if p~=nil and p~=lplr and not following then
			if p.Character~=nil and funcs.getHum(p.Character) then
				if banging then
					banging = false
				end
				bangAnim = Instance.new("Animation")
				bangAnim.AnimationId = "rbxassetid://148840371"
				bang = funcs.getHum(lplr.Character):LoadAnimation(bangAnim)
				bang:Play(.1,1,1)
				bang:AdjustSpeed(speedbang)
				banging = true
				task.spawn(function()
					while banging do task.wait()
						if lplr.Character~=nil then
							funcs.getRoot(lplr.Character).CFrame = funcs.getRoot(p.Character).CFrame + funcs.getRoot(p.Character).CFrame.lookVector * -1
							funcs.getRoot(lplr.Character).AssemblyLinearVelocity = Vector3.new()
						end
					end
				end)
			end
		end
	end
end

function cmds.unbang(args)
	following = false
	banging = false
	pcall(function()
		if lplr.Character~=nil and funcs.getHum(lplr.Character) then
			bang:Stop()
			bangAnim:Destroy()
			local hum = funcs.getHum(lplr.Character)
			local anim = firstchildofc(hum,'Animator')
			if hum and anim then
				hum:LoadAnimation(anim)
				anim:Play()
			end
		end
	end)
end

function cmds.follow(args)
	if args[1]==nil then return funcs.errormsg(1) end
	local p = funcs.findplayer(args[1])
	if p~=nil and p~=lplr and not banging then
		if p.Character~=nil and funcs.getHum(p.Character) then
			if following then
				following = false
			end
			following = true
			task.spawn(function()
				while following do task.wait()
					if lplr.Character~=nil then
						funcs.getRoot(lplr.Character).CFrame=
							funcs.getRoot(p.Character).CFrame*CFrame.new(0,.8,0)
					end
				end
			end)
		end
	end
end

function cmds.unfollow(args)
	following = false
end

function cmds.servercrash(args)
	return funcs.createnotif('This function is not available.','warn',5,false)
end

function cmds.antikick(args)
	return funcs.anti('Kick',funcs.toboolean(args[1] or 'str'));
end

function cmds.antirejoin(args)
	return funcs.anti('Rejoin',funcs.toboolean(args[1] or 'str'));
end

function cmds.shiftlock(args)
	if args[1] == nil then return funcs.errormsg(1) end
	local onof = string.lower(args[1])
	if onof == 'true' then
		lplr.DevEnableMouseLock = true
		shiftlock = true
	elseif onof == 'false' then
		lplr.DevEnableMouseLock = false
		shiftlock = false
	else
		return funcs.errormsg('boolean')
	end
	return funcs.createnotif('ShiftLock is now: '..onof,'succ',5,false)
end

function cmds.cmdboxkey(args)
	if args[1]==nil then return funcs.errormsg(1) end
	local key = string.lower(args[1])
	if funcs.minmax(key,1,1,'len')=='acc'then
		warn('y')
		cmdboxkey = key
		warn('e')
		funcs.createnotif('Command box key setted to '..key,'succ',5,false)
		warn('s')
	end
end

function cmds.flykey(args)
	if args[1]==nil then return funcs.errormsg(1) end
	local key = string.lower(args[1])
	if funcs.minmax(key,1,1,'len')=='acc'then
		flykey = key
		funcs.createnotif('RFly key setted to '..key,'succ',5,false)
	end
end

function cmds.mutesounds(args)
	for _,s in next, descendants(game) do
		task.spawn(function()
			if s:IsA('Sound') then
				s.Playing = false
			end
		end)
	end
end

function cmds.unmutesounds(args)
	for _,s in next, descendants(game) do
		task.spawn(function()
			if s:IsA('Sound') then
				s.Playing = true
			end
		end)
	end
end

function cmds.antifling(args)
	if args[1]==nil then return funcs.errormsg(1) end
	local onof = args[1]
	if onof == 'false' or onof == 'true' then
		antifling = onof
		if not antifling then
			task.spawn(function()
				while antifling do task.wait()
					if lplr.Character~=nil then
						local char = descendants(lplr.Character)
						local hump = funcs.getRoot(lplr.Character)
						local min = hump.Position - (45*hump.Size)
						local max = hump.Position + (45*hump.Size)
						local region = Region3.new(min,max)
						coroutine.resume(coroutine.create(function()
							local parts = workspace:FindPartsInRegion3WithIgnoreList(region, char, math.huge)
							for _,p in pairs(parts)do
								--print('Angular '..p.AssemblyAngularVelocity.Magnitude)
								--print('Linear '..p.AssemblyLinearVelocity.Magnitude)
								if p.AssemblyAngularVelocity.Magnitude > 50 or p.AssemblyLinearVelocity.Magnitude > 100 then
									p.Parent:Destroy()
									funcs.createnotif('Detected part with high velocity: '..p.Parent.Name,'warn',5,true)
								end
							end
						end))
					end
				end
			end)
		end
	else
		return funcs.errormsg('boolean')
	end
end

function cmds.respawn(args)
	local char = lplr.Character
	if funcs.getHum(char) then funcs.getHum(char):ChangeState(15) end
	char:ClearAllChildren()
	local newChar = Instance.new("Model")
	newChar.Parent = workspace
	lplr.Character = newChar
	wait()
	lplr.Character = char
	newChar:Destroy()
end

function cmds.headsit(args)
	local speaker = funcs.findplayer(args[1])
	if speaker~=nil then
		funcs.getHum(lplr.Character).Sit = true

		local function heads()
			if speaker.Character ~= nil and funcs.getRoot(speaker.Character) and funcs.getRoot(lplr.Character) then
				if speaker and funcs.getHum(lplr.Character).Sit == true then
					funcs.getRoot(lplr.Character).CFrame = funcs.getRoot(speaker.Character).CFrame * CFrame.Angles(0,math.rad(0),0) * CFrame.new(0,1.6,0.4)
				else
					discon(headSit)
				end
			end
		end
		headSit = con(srv.RunService.Heartbeat,heads)
	end
end

function cmds.whisper(args)
	argstosay = args
	local speaker = funcs.findplayer(args[1])
	if speaker~=nil then
		task.spawn(function()
			local pmstring = funcs.getstring(2)
			srv.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..speaker.Name.." "..pmstring, "All")
		end)
	end
end

function cmds.nofog(args)
	srv.Lighting.FogEnd = 100000
	for i,v in pairs(srv.Lighting:GetDescendants()) do
		if v:IsA("Atmosphere") then
			v:Destroy()
		end
	end
end

function cmds.clearnilinstances(args)
	if getnilinstances then
		for _,v in next, getnilinstances() do
			local s, e = pcall(function()
				if not v.Archivable then v.Archivable=true and v:Destroy()end
				if v.Locked then v.Locked=false and v:Destroy()end
			end)--if not s then warn(e)end
		end
	else
		funcs.createnotif('Your exploit does not support this command (missing getnilinstances)','error',5,false)
	end
end

function cmds.remove1stperson(args)
	lplr.CameraMaxZoomDistance = 100000
	lplr.CameraMode = 'Classic'
end

function cmds.message(args)
	local msg = funcs.getstring(1)
	if msg~=nil then
		task.spawn(function()
			srv.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
		end)
	end
end

function exeCmd(cmd, args)
	local cmd2 = cmdHandler[cmd]
	if (cmd2) then cmd2[3](args)updatesave()return end
	for _,a in next, cmdHandler do
		for __,a2 in pairs(a[2]) do
			if a2==cmd then a[3](args)updatesave()return end
		end
	end
end

-- Connects func
function keyDown(k)
	if(k==cmdboxkey)then
		if cmdbox~=nil then return end
		cmdbox = Instance.new("Frame")
		local box = Instance.new("TextBox")
		local label1 = Instance.new("TextLabel")
		set_properties(label1,{Size = UDim2.new(0,15,1,0), TextSize = 10, BackgroundTransparency = 1, TextColor3 = textcol, Text = ">", Parent = cmdbox, Active = true, ZIndex = 11})
		set_properties(box,{Text = "", PlaceholderText = "Insert Command",PlaceholderColor3 = Color3.fromRGB((textcol.R*255)/2,(textcol.G*255)/2,(textcol.B*255)/2), Size = UDim2.new(1,-15,1,0),TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.new(0,15,0,0), TextColor3 = textcol, BackgroundTransparency = 1,TextSize = 14, Font = Enum.Font.Arcade, TextWrapped = true, ClearTextOnFocus = false, Parent = cmdbox, Active = true, ZIndex = 11})
		set_properties(cmdbox,{Size = UDim2.new(0.4,0,0,20), Position = UDim2.new(0.5,0,0,-100), AnchorPoint = Vector2.new(0.5,0), BorderSizePixel = 0, BackgroundColor3 = secondarycol, Parent = GUI, Active = true, ZIndex = 11})
		local lasttext = ""
		wait()
		box.Text = ""
		local labs = {}
		local function destroylabs()for _,v in pairs(labs)do if(v~=nil)then v:Destroy() end labs={}end end

		local function boxchanged()
			if(box.Text~=lasttext)then
				destroylabs()
				local x = 1
				if(box.Text~="")or(box.Text~=" ")then
					for _,v in next, cmdHandler do
						if string.find(_.." ",box.Text:sub(1,_:len())) then
							local lab = Instance.new("TextLabel",cmdbox)
							table.insert(labs, lab)
							lab.Size = UDim2.new(1,0,1,0)
							lab.TextSize = 12
							lab.TextXAlignment = Enum.TextXAlignment.Left
							lab.BorderSizePixel = 0
							lab.Position = UDim2.new(0,0,x+(x*0.05),0)
							lab.BackgroundColor3 = secondarycol
							lab.TextColor3 = textcol
							lab.Font = Enum.Font.Arcade
							lab.Text = "   ".._
							x = x+1
						end
					end
				end
			end
			lasttext = box.Text
		end
		con(box.Changed,boxchanged)

		local function boxfocuslost()
			destroylabs()
			srv.TweenService:Create(cmdbox, TweenInfo.new(1), {["Position"]=UDim2.new(0.5,0,0,-100)}):Play()
			local tokens = funcs.split(box.Text)
			local cmd = tokens[1]:sub(1)
			local args = {select(2, unpack(tokens))}
			exeCmd(cmd, args)
			wait(.8)
			box:Destroy()
			cmdbox:Destroy()
			cmdbox=nil
		end
		con(box.FocusLost,boxfocuslost)

		box:CaptureFocus()
		srv.TweenService:Create(cmdbox, TweenInfo.new(1, Enum.EasingStyle.Bounce), {["Position"]=UDim2.new(0.5,0,0,20)}):Play()
	end
end

function loldetect(p)
	for _,__ in next, pohvalno do
		if _==p.Name then
			funcs.createnotif('Joined:\n'.._..' | '..__,'warn',5,true)
		end
	end
end

function Chatted(m)
	local m = m:lower()
	if m:lower():sub(1,#prefix) == prefix then
		m = m:sub(#prefix+1,#m)
	elseif m:lower():sub(1,#prefix+3) == '/e '..prefix then
		m = m:sub(#prefix+4,#m)
	else return end
	if not disconnected and m~='' then
		local tokens = funcs.split(m)
		local cmd = tokens[1]:sub(1)
		local args = {select(2, unpack(tokens))}
		exeCmd(cmd, args)
	end
end

function Died()
	discon(_G.spxadmin.ccs.died)
	_G.spxadmin.ccs.died = nil
	repeat wait() until lplr.Character~=nil and funcs.getHum(lplr.Character)
	_G.spxadmin.ccs.died = con(funcs.getHum(lplr.Character).Died,Died)
end

-- Initialize
do
	coroutine.resume(coroutine.create(function()
		cmdHandler = {
			exit = {
				[1] = "exit:  Remove all admin connections",
				[2] = {},
				[3] = cmds.exit,
			},
			commands = {
				[1] = "commands/cmds:  Show commands list",
				[2] = {'cmds'},
				[3] = cmds.commands,
			},
			rfly = {
				[1] = "rfly:  Enable/disable fly  [glitchy]",
				[2] = {},
				[3] = cmds.rfly,
			},
			rflyspeed = {
				[1] = "rflyspeed/rfs <value>:  Change fly speed",
				[2] = {'rfs'},
				[3] = cmds.rflyspeed,
			},
			rejoin = {
				[1] = "rejoin/rj:  Reconnect to the server",
				[2] = {'rj'},
				[3] = cmds.rejoin,
			},
			rfling = {
				[1] = "rfling:  Enabled/disable fling  [only with fly]",
				[2] = {},
				[3] = cmds.rfling,
			},
			view = {
				[1] = "view/spectate/spec [Player]:  Spectate the player",
				[2] = {'spectate','spec'},
				[3] = cmds.view,
			},
			unview = {
				[1] = "unview/unspectate/unspec:  Stop spectate the player",
				[2] = {'unspectate','unspec'},
				[3] = cmds.unview,
			},
			sync = {
				[1] = "sync [Player]:  Copy player character  [only 1 game]",
				[2] = {},
				[3] = cmds.sync,
			},
			teleport = {
				[1] = "teleport/to/tp [Player]:  Teleport to player",
				[2] = {'to','tp'},
				[3] = cmds.teleport,
			},
			prefix = {
				[1] = "prefix/p [prefix]:  Set commands prefix",
				[2] = {'p'},
				[3] = cmds.prefix,
			},
			music = {
				[1] = "music/mus <MusicId>:  FireRemote with music",
				[2] = {'mus'},
				[3] = cmds.music,
			},
			earrape = {
				[1] = "errape:  Do your ears bloody ;D",
				[2] = {},
				[3] = cmds.earrape,
			},
			bang = {
				[1] = "bang [Player] <speed>:  Bang someone",
				[2] = {},
				[3] = cmds.bang,
			},
			unbang = {
				[1] = "unbang:  Stop banging",
				[2] = {},
				[3] = cmds.unbang,
			},
			servercrash = {
				[1] = "servercrash/sc:  Attempt to crash server",
				[2] = {'sc'},
				[3] = cmds.servercrash,
			},
			antikick = {
				[1] = "antikick/akk [false/true]:  Disable/Enable Anti-Kick",
				[2] = {'akk'},
				[3] = cmds.antikick,
			},
			antirejoin = {
				[1] = "antirejoin/arj [false/true]:  Disable/Enable Anti-Rejoin",
				[2] = {'arj'},
				[3] = cmds.antirejoin,
			},
			shiftlock = {
				[1] = "shiftlock/sfl [false/true]:  Disable/Enable shiftlock",
				[2] = {'sfl'},
				[3] = cmds.shiftlock,
			},
			cmdboxkey = {
				[1] = "cmdboxkey [KEY]:  Set command box key",
				[2] = {},
				[3] = cmds.cmdboxkey,
			},
			flykey = {
				[1] = "flykey [KEY]:  Set RFly key",
				[2] = {},
				[3] = cmds.flykey,
			},
			mutesounds = {
				[1] = "mutesounds/ms:  Disable all sounds in game",
				[2] = {'ms'},
				[3] = cmds.mutesounds,
			},
			unmutesounds = {
				[1] = "unmutesounds/ums:  Enable all sounds in game",
				[2] = {'ums'},
				[3] = cmds.unmutesounds,
			},
			antifling = {
				[1] = "antifling/af [false/true]:  Disable/Enable Anti-Fling",
				[2] = {'af'},
				[3] = cmds.antifling,
			},
			respawn = {
				[1] = "respawn/rs:  Respawn character",
				[2] = {'rs'},
				[3] = cmds.respawn,
			},
			headsit = {
				[1] = "headsit [Player]:  Sit on player head",
				[2] = {},
				[3] = cmds.headsit,
			},
			whisper = {
				[1] = "whisper/pm [Player] [Message]:  Send PM message to user",
				[2] = {'pm'},
				[3] = cmds.whisper,
			},
			nofog = {
				[1] = "nofog:  Remove Lighting FOG",
				[2] = {},
				[3] = cmds.nofog,
			},
			clearnilinstances = {
				[1] = "clearnilinstances/cni:  Clear all what in NIL",
				[2] = {'cni'},
				[3] = cmds.clearnilinstances,
			},
			remove1stperson = {
				[1] = "remove1stperson/r1p:  Remove first person limits",
				[2] = {'r1p'},
				[3] = cmds.remove1stperson,
			},
			follow = {
				[1] = "follow:  Follow player",
				[2] = {},
				[3] = cmds.follow,
			},
			unfollow = {
				[1] = "unfollow:  UnFollow player",
				[2] = {},
				[3] = cmds.unfollow,
			},
			message = {
				[1] = "message:  Send message to chat",
				[2] = {'msg'},
				[3] = cmds.message,
			},
		}
		funcs.createnotif('Welcome to SPX Admin, '..lplr.Name..'!','warn',5,true);
		for _,p in next, srv.Players:GetPlayers() do
			loldetect(p)
		end
	end))
end

-- Connects
_G.spxadmin.ccs.cmdbmdown = con(Mouse.KeyDown,keyDown)
_G.spxadmin.ccs.pohvalno = con(srv.Players.PlayerAdded,loldetect)
_G.spxadmin.ccs.disc = con(lplr.Chatted,Chatted)
task.spawn(function()
	repeat wait() until lplr.Character~=nil and funcs.getHum(lplr.Character)
	_G.spxadmin.ccs.died = con(funcs.getHum(lplr.Character).Died,Died)
end)
