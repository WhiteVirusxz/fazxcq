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
|  • To open cmdbar use button: \
|  • To use chat commands use prefix: c.
╹
╻
| Updates logs:
| >> https://pastebin.com/raw/JhXdXWF6
|
|
| Current static:
|  • Version: v1.1.4b [BETA]
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

local secondarycol = Color3.new(0,0,0)
local textcol = Color3.fromRGB(229,229,229)

local headSit,bang,bangAnim,argstosay;

local flying,rfling,antifling,banging,following,alrnotifying,riding =
	false,false,false,false,false,false,false

local GUI = Instance.new('ScreenGui')
local cmdsh = Instance.new('Frame',GUI)
local cmdbox = nil

if not syn then syn = {} end
if not is_sirhurt_closure and syn.protect_gui then syn.protect_gui(GUI) end

local funcs,cmds,cmdHandler,notifys =
	{},{},{},{}

local pohvalno = {
	['WhiteFo0x'] = 'Owner',
	['VannyVenumn'] = 'CoolUser',
	["Rainbow_Dose"] = 'CoolUser',
	["56789j7"] = 'CoolUser',
}

local descendants,con,discon,getpropersignal,hwait,twplay = function(In)return In:GetDescendants()end
,function(In,func)return In:connect(func)end
,function(In,In2)return In:Disconnect()end
,function(In,In2)return In:GetPropertyChangedSignal(In2)end
,function(c)return srv.RunService.Heartbeat:wait(c or 0)end
,function(UI,TIME,TABLE)local t=srv.TweenService:Create(UI,TweenInfo.new(TIME,Enum.EasingStyle.Sine),TABLE)t:play()return t;end

local getRoot,getHum = function(char)local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso') or false;return rootPart;end
,function(char)local hum = char:FindFirstChildOfClass('Humanoid',true) or false;return hum;end

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

do
	-- Functions
	function funcs.createnotif(TEXT,TYPE,DURAT,IFSOUND)
		-- open gui   {1,-250},{1,-220}
		-- hide gui   {1,-250},{2,-220}
		spawn(function()
			repeat wait()until not alrnotifying
			alrnotifying = true
			local txt,icon,NEWGUI;
			local function createNotify()
				NEWGUI = Instance.new('ScreenGui')
				local shadow = Instance.new("Frame")
				local out = Instance.new("Frame")
				local i_2 = Instance.new("UICorner")
				local UP_TXT = Instance.new("TextLabel")
				local DO_TXT = Instance.new("TextLabel")
				local LINE = Instance.new("Frame")
				local IMG = Instance.new("ImageLabel")
				if not is_sirhurt_closure and syn.protect_gui then syn.protect_gui(NEWGUI) end
				
				set_properties(NEWGUI,{
					Parent = srv.CoreGui,
					Name = funcs.randomstring(),
					Enabled = true,
					ResetOnSpawn = false
				})
				set_properties(shadow,{
					Parent = NEWGUI,
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
				for _,g in next,notifys do twplay(g,.4,{Position = g.Position+UDim2.new(0,0,-.13,0)})end
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
			nf.Parent = NEWGUI
			if IFSOUND then funcs.soundnotify()end
			task.spawn(function()
				task.spawn(function()local tww = twplay(nf,.4,{Position = UDim2.new(1,-185,1,-110)})tww.Completed:wait()alrnotifying = false;end)
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
					NEWGUI:Destroy()
					for _,t in next,notifys do if(t==nf)then t=nil;end;end
				end)
			end)
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
		else return false end
		setreadonly(mt, true)
		funcs.createnotif('Anti-'..w..' is now '..tostring(oh),'succ',5,false);
	end

	-- Commands
	function cmds.commands(args)
		cmdsh = Instance.new('Frame',GUI)
		set_properties(cmdsh,{BackgroundColor3 = Color3.fromRGB(25,25,25), BackgroundTransparency = 0.3, Position = UDim2.new(0.709,0,0.335,0), Size = UDim2.new(0,309,0,281), ClipsDescendants = true, Visible = false})
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
					command.Text = c[4]..': '..c[1]
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
		set_properties(cmdsh,{Visible = true})
	end

	function cmds.rfly(args)
		if flying then
			if rfling then
				rfling = false
				funcs.createnotif('RFling is now off','succ',5,false)
			end
			wait()
			flying = false
			for _,c in next, _G.spxadmin.ccs.fly do
				discon(c)
			end
			funcs.createnotif('RFly is now off','succ',5,false)return
		end
		if not flying and lplr.Character~=nil and getRoot(lplr.Character) and getHum(lplr.Character) and not following and not banging then
			flying = true
			local Keys,Timing = {W = false,A = false,S = false,D = false},{Throttle = 1,Sine = 0,LastFrame = tick()}
			local Movement = {
				Attacking = false,
				Flying = false,
				CFrame = getRoot(lplr.Character).CFrame,
				PotentialCFrame = getRoot(lplr.Character).CFrame,
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
					if lplr.Character~=nil and getRoot(lplr.Character) and getHum(lplr.Character) then
						local su,er = pcall(function()
							local hump = getRoot(lplr.Character)
							getHum(lplr.Character).Sit = false
							if rfling then
								getRoot(lplr.Character).Velocity = Vector3.new(512,0,512)end
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
									if Movement.CFrame.Y < ooofe or getRoot(lplr.Character).CFrame.Y < ooofe then
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
			funcs.createnotif('RFly is now on','succ',5,false)
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
		if (#srv.Players:GetPlayers() < 1) then
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
			if p.Character~=nil and getRoot(p.Character) then
				local cam = workspace.CurrentCamera
				local tarh =getHum(p.Character)
				if tarh~=nil then
					cam.CameraSubject = tarh
				end
			end
		end
	end

	function cmds.unview(args)
		if lplr.Character~=nil and getHum(lplr.Character)then
			local cam = workspace.CurrentCamera
			local hum = getHum(lplr.Character)
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
			return funcs.createnotif('Waiting Peace.','error',4,false)
		end
	end

	function cmds.teleport(args)
		if args[1]==nil then return funcs.errormsg(1) end
		local p = funcs.findplayer(args[1])
		if p~=nil then
			if lplr.Character~=nil and p.Character~=nil and getRoot(lplr.Character) and getRoot(p.Character) then
				if getHum(lplr.Character)and getHum(lplr.Character).Sit==true then getHum(lplr.Character).Sit=false end
				local hum = getRoot(lplr.Character)
				local tarh = getRoot(p.Character)
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

			local mk1 = srv.ReplicatedStorage.MasterKey
			if args[1] == nil then
				mk1:FireServer("StopMusic",nil,key2)
			else
				mk1:FireServer("PlayMusic",args[1],key2)
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
				if p.Character~=nil and getHum(p.Character) then
					if banging then return funcs.createnotif('Turn off bang first.','warn',4,false)
					end
					bangAnim = Instance.new("Animation")
					bangAnim.AnimationId = "rbxassetid://148840371"
					bang = getHum(lplr.Character):LoadAnimation(bangAnim)
					bang:Play(.1,1,1)
					bang:AdjustSpeed(speedbang)
					banging = true
					task.spawn(function()
						while banging do task.wait()
							if getHum(lplr.Character)and getHum(lplr.Character).Sit==true then getHum(lplr.Character).Sit=false end
							if lplr.Character==nil or not getHum(lplr.Character)or not getRoot(lplr.Character)then banging=false end
							if lplr.Character~=nil and p.Character~=nil and getRoot(lplr.Character) and getRoot(p.Character) then
								getRoot(lplr.Character).CFrame = getRoot(p.Character).CFrame + getRoot(p.Character).CFrame.lookVector * -1
								getRoot(lplr.Character).AssemblyLinearVelocity = Vector3.new()
							end
						end
					end)
					funcs.createnotif('Banging now '..p.Name,'succ',5,false)
				end
			end
		end
	end

	function cmds.unbang(args)
		following = false
		banging = false
		pcall(function()
			if lplr.Character~=nil and getHum(lplr.Character) then
				bang:Stop()
				bangAnim:Destroy()
				local hum = getHum(lplr.Character)
				local anim = hum:FindFirstChildOfClass('Animator')
				if hum and anim then
					hum:LoadAnimation(anim)
					anim:Play()
				end
				funcs.createnotif('Not banging now','succ',5,false)
			end
		end)
	end

	function cmds.follow(args)
		if args[1]==nil then return funcs.errormsg(1) end
		local p = funcs.findplayer(args[1])
		if p~=nil and p~=lplr and not banging then
			if p.Character~=nil and getHum(p.Character) then
				if following then return funcs.createnotif('Turn off follow first.','warn',4,false)
				end
				following = true
				task.spawn(function()
					while following do task.wait()
						if srv.Players:FindFirstChild(p.Name) then
							if getHum(lplr.Character)and getHum(lplr.Character).Sit==true then getHum(lplr.Character).Sit=false end
							if lplr.Character~=nil and p.Character~=nil and getRoot(lplr.Character) and getRoot(p.Character) then
								getRoot(lplr.Character).CFrame=
									getRoot(p.Character).CFrame
							end else following=false end
					end
				end)
				funcs.createnotif('Following[1] now '..p.Name,'succ',5,false)
			end
		end
	end

	function cmds.follow2(args)
		if args[1]==nil then return funcs.errormsg(1) end
		local p = funcs.findplayer(args[1])
		if p~=nil and p~=lplr and not banging then
			if p.Character~=nil and getHum(p.Character) then
				if following then return funcs.createnotif('Turn off follow first.','warn',4,false)
				end
				following = true
				task.spawn(function()
					while following do task.wait()
						if srv.Players:FindFirstChild(p.Name) then
						if getHum(lplr.Character)and getHum(lplr.Character).Sit==true then getHum(lplr.Character).Sit=false end
						if lplr.Character~=nil and p.Character~=nil and getRoot(lplr.Character) and getRoot(p.Character) then
							if getHum(lplr.Character)and getHum(lplr.Character).Sit==true then getHum(lplr.Character).Sit=false end
							getRoot(lplr.Character).CFrame=
								getRoot(p.Character).CFrame*CFrame.new(0,1.1,0)
							end else following=false end
					end
				end)
				funcs.createnotif('Following[2] now'..p.Name,'succ',5,false)
			end
		end
	end

	function cmds.unfollow(args)
		following = false
		funcs.createnotif('Not following now','succ',5,false)
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
		funcs.createnotif('ShiftLock is now: '..onof,'succ',5,false)
	end

	function cmds.cmdboxkey(args)
		if args[1]==nil then return funcs.errormsg(1) end
		local key = string.lower(args[1])
		if funcs.minmax(key,1,1,'len')=='acc'then
			cmdboxkey = key
			funcs.createnotif('Command box key setted to '..key,'succ',5,false)
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
		funcs.createnotif('Muted all sounds','succ',5,false)
	end

	function cmds.unmutesounds(args)
		for _,s in next, descendants(game) do
			task.spawn(function()
				if s:IsA('Sound') then
					s.Playing = true
				end
			end)
		end
		funcs.createnotif('UnMuted all sounds','succ',5,false)
	end

	function cmds.antifling(args)
		if args[1]==nil then return funcs.errormsg(1) end
		local onof = args[1]
		if onof == 'false' or onof == 'true' then
			antifling = onof
			funcs.createnotif('Anti-Fling is now '..onof,'succ',5,false)
			if not antifling then
				task.spawn(function()
					while antifling do task.wait()
						if lplr.Character~=nil then
							local char = descendants(lplr.Character)
							local hump = getRoot(lplr.Character)
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
		if getHum(char) then getHum(char):ChangeState(15) end
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
			getHum(lplr.Character).Sit = true

			local function heads()
				if speaker.Character ~= nil and getRoot(speaker.Character) and getRoot(lplr.Character) then
					if speaker and getHum(lplr.Character).Sit == true then
						getRoot(lplr.Character).CFrame = getRoot(speaker.Character).CFrame * CFrame.Angles(0,math.rad(0),0) * CFrame.new(0,1.6,0.4)
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
				if not v.Archivable then v.Archivable=true and v:Destroy()end
				if v.Locked then v.Locked=false and v:Destroy()end
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
		argstosay = args
		local msg = funcs.getstring(1)
		if msg~=nil then
			task.spawn(function()
				srv.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
			end)
		end
	end
	
	function cmds.audiologger(args)
		pcall(function()
			loadstring(game:HttpGet('https://raw.githubusercontent.com/WhiteVirusxz/fazxcq/main/alogger'))()
		end)
		funcs.createnotif('Launching Audio Logger..','succ',4,false)
	end
	
	function cmds.sit(args)
		getHum(lplr.Character).Sit=true
	end
	
	function cmds.lay(args)
		if not getHum(lplr.Character)then
			return
		end
		getHum(lplr.Character).Sit = true
		task.wait(.1)
		getHum(lplr.Character).RootPart.CFrame = getHum(lplr.Character).RootPart.CFrame * CFrame.Angles(math.pi * .5, 0, 0)
		for _, v in ipairs(getHum(lplr.Character):GetPlayingAnimationTracks()) do
			v:Stop()
		end
	end
	
	do -- free cam settings
		fcRunning = false
		local Camera = workspace.CurrentCamera
		workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			local newCamera = workspace.CurrentCamera
			if newCamera then
				Camera = newCamera
			end
		end)

		local INPUT_PRIORITY = Enum.ContextActionPriority.High.Value

		Spring = {} do
			Spring.__index = Spring

			function Spring.new(freq, pos)
				local self = setmetatable({}, Spring)
				self.f = freq
				self.p = pos
				self.v = pos*0
				return self
			end

			function Spring:Update(dt, goal)
				local f = self.f*2*math.pi
				local p0 = self.p
				local v0 = self.v

				local offset = goal - p0
				local decay = math.exp(-f*dt)

				local p1 = goal + (v0*dt - offset*(f*dt + 1))*decay
				local v1 = (f*dt*(offset*f - v0) + v0)*decay

				self.p = p1
				self.v = v1

				return p1
			end

			function Spring:Reset(pos)
				self.p = pos
				self.v = pos*0
			end
		end

		local cameraPos = Vector3.new()
		local cameraRot = Vector2.new()

		local velSpring = Spring.new(5, Vector3.new())
		local panSpring = Spring.new(5, Vector2.new())

		Input = {} do

			keyboard = {
				W = 0,
				A = 0,
				S = 0,
				D = 0,
				E = 0,
				Q = 0,
				Up = 0,
				Down = 0,
				LeftShift = 0,
			}

			mouse = {
				Delta = Vector2.new(),
			}

			NAV_KEYBOARD_SPEED = Vector3.new(1, 1, 1)
			PAN_MOUSE_SPEED = Vector2.new(1, 1)*(math.pi/64)
			NAV_ADJ_SPEED = 0.75
			NAV_SHIFT_MUL = 0.25

			navSpeed = 1

			function Input.Vel(dt)
				navSpeed = math.clamp(navSpeed + dt*(keyboard.Up - keyboard.Down)*NAV_ADJ_SPEED, 0.01, 4)

				local kKeyboard = Vector3.new(
					keyboard.D - keyboard.A,
					keyboard.E - keyboard.Q,
					keyboard.S - keyboard.W
				)*NAV_KEYBOARD_SPEED

				local shift = srv.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)

				return (kKeyboard)*(navSpeed*(shift and NAV_SHIFT_MUL or 1))
			end

			function Input.Pan(dt)
				local kMouse = mouse.Delta*PAN_MOUSE_SPEED
				mouse.Delta = Vector2.new()
				return kMouse
			end

			do
				function Keypress(action, state, input)
					keyboard[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
					return Enum.ContextActionResult.Sink
				end

				function MousePan(action, state, input)
					local delta = input.Delta
					mouse.Delta = Vector2.new(-delta.y, -delta.x)
					return Enum.ContextActionResult.Sink
				end

				function Zero(t)
					for k, v in pairs(t) do
						t[k] = v*0
					end
				end

				function Input.StartCapture()
					srv.ContextActionService:BindActionAtPriority("FreecamKeyboard",Keypress,false,INPUT_PRIORITY,
					Enum.KeyCode.W,
					Enum.KeyCode.A,
					Enum.KeyCode.S,
					Enum.KeyCode.D,
					Enum.KeyCode.E,
					Enum.KeyCode.Q,
					Enum.KeyCode.Up,
					Enum.KeyCode.Down
					)
					game:GetService("ContextActionService"):BindActionAtPriority("FreecamMousePan",MousePan,false,INPUT_PRIORITY,Enum.UserInputType.MouseMovement)
				end

				function Input.StopCapture()
					navSpeed = 1
					Zero(keyboard)
					Zero(mouse)
					game:GetService("ContextActionService"):UnbindAction("FreecamKeyboard")
					game:GetService("ContextActionService"):UnbindAction("FreecamMousePan")
				end
			end
		end

		function GetFocusDistance(cameraFrame)
			local znear = 0.1
			local viewport = Camera.ViewportSize
			local projy = 2*math.tan(cameraFov/2)
			local projx = viewport.x/viewport.y*projy
			local fx = cameraFrame.rightVector
			local fy = cameraFrame.upVector
			local fz = cameraFrame.lookVector

			local minVect = Vector3.new()
			local minDist = 512

			for x = 0, 1, 0.5 do
				for y = 0, 1, 0.5 do
					local cx = (x - 0.5)*projx
					local cy = (y - 0.5)*projy
					local offset = fx*cx - fy*cy + fz
					local origin = cameraFrame.p + offset*znear
					local _, hit = workspace:FindPartOnRay(Ray.new(origin, offset.unit*minDist))
					local dist = (hit - origin).magnitude
					if minDist > dist then
						minDist = dist
						minVect = offset.unit
					end
				end
			end

			return fz:Dot(minVect)*minDist
		end

		local function StepFreecam(dt)
			local vel = velSpring:Update(dt, Input.Vel(dt))
			local pan = panSpring:Update(dt, Input.Pan(dt))

			local zoomFactor = math.sqrt(math.tan(math.rad(70/2))/math.tan(math.rad(cameraFov/2)))

			cameraRot = cameraRot + pan*Vector2.new(0.75, 1)*8*(dt/zoomFactor)
			cameraRot = Vector2.new(math.clamp(cameraRot.x, -math.rad(90), math.rad(90)), cameraRot.y%(2*math.pi))

			local cameraCFrame = CFrame.new(cameraPos)*CFrame.fromOrientation(cameraRot.x, cameraRot.y, 0)*CFrame.new(vel*Vector3.new(1, 1, 1)*64*dt)
			cameraPos = cameraCFrame.p

			Camera.CFrame = cameraCFrame
			Camera.Focus = cameraCFrame*CFrame.new(0, 0, -GetFocusDistance(cameraCFrame))
			Camera.FieldOfView = cameraFov
		end

		local PlayerState = {} do
			mouseBehavior = ""
			mouseIconEnabled = ""
			cameraType = ""
			cameraFocus = ""
			cameraCFrame = ""
			cameraFieldOfView = ""

			function PlayerState.Push()
				cameraFieldOfView = Camera.FieldOfView
				Camera.FieldOfView = 70

				cameraType = Camera.CameraType
				Camera.CameraType = Enum.CameraType.Custom

				cameraCFrame = Camera.CFrame
				cameraFocus = Camera.Focus

				mouseIconEnabled = srv.UserInputService.MouseIconEnabled
				srv.UserInputService.MouseIconEnabled = true

				mouseBehavior = srv.UserInputService.MouseBehavior
				srv.UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			function PlayerState.Pop()
				Camera.FieldOfView = 70

				Camera.CameraType = cameraType
				cameraType = nil

				Camera.CFrame = cameraCFrame
				cameraCFrame = nil

				Camera.Focus = cameraFocus
				cameraFocus = nil

				srv.UserInputService.MouseIconEnabled = mouseIconEnabled
				mouseIconEnabled = nil

				srv.UserInputService.MouseBehavior = mouseBehavior
				mouseBehavior = nil
			end
		end

		function StartFreecam(pos)
			if fcRunning then
				StopFreecam()
			end
			local cameraCFrame = workspace.Camera.CFrame
			if pos then
				cameraCFrame = pos
			end
			cameraRot = Vector2.new()
			cameraPos = cameraCFrame.p
			cameraFov = workspace.Camera.FieldOfView

			velSpring:Reset(Vector3.new())
			panSpring:Reset(Vector2.new())

			PlayerState.Push()
			game:GetService("RunService"):BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)
			Input.StartCapture()
			fcRunning = true
		end

		function StopFreecam()
			if not fcRunning then return end
			Input.StopCapture()
			game:GetService("RunService"):UnbindFromRenderStep("Freecam")
			PlayerState.Pop()
			workspace.Camera.FieldOfView = 70
			fcRunning = false
		end
	end
	
	function cmds.freecam(args)
		StartFreecam()
	end
	
	function cmds.unfreecam(args)
		StopFreecam()
	end
	
	function cmds.freecamspeed(args)
		local FCspeed = args[1] or 1
		if typeof(tonumber(FCspeed))=='number'then
			NAV_KEYBOARD_SPEED = Vector3.new(FCspeed, FCspeed, FCspeed)
		end
	end
	
	function cmds.gotocamera(args)
		local p = funcs.findplayer(args[1])or lplr
		if p then
			StartFreecam(getRoot(p.Character).CFrame)
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
							for __,s in next, v[2]do
								if string.find(_..' ',box.Text:sub(1,_:len()))or string.find(s..' ',box.Text:sub(1,_:len()+1+s:len()))then
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
									lab.Text = "   "..v[4]
									x = x+1
								end
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
		if m~='' then
			local tokens = funcs.split(m)
			local cmd = tokens[1]:sub(1)
			local args = {select(2, unpack(tokens))}
			exeCmd(cmd, args)
		end
	end

	function Died()
		discon(_G.spxadmin.ccs.died)
		_G.spxadmin.ccs.died = nil
		repeat wait() until lplr.Character~=nil and getHum(lplr.Character)
		_G.spxadmin.ccs.died = con(getHum(lplr.Character).Died,Died)
	end

	-- Initialize
	do
		coroutine.resume(coroutine.create(function()
			cmdHandler = {
				commands = {
					[4] = 'commands/cmds',
					[1] = "Show commands list",
					[2] = {'cmds'},
					[3] = cmds.commands,
				},
				rfly = {
					[4] = 'rfly',
					[1] = "Enable/disable fly",
					[2] = {},
					[3] = cmds.rfly,
				},
				rflyspeed = {
					[4] = 'rflyspeed/rfs <speed>',
					[1] = "Change fly speed",
					[2] = {'rfs'},
					[3] = cmds.rflyspeed,
				},
				rejoin = {
					[4] = 'rejoin/rj',
					[1] = "Reconnect to the server",
					[2] = {'rj'},
					[3] = cmds.rejoin,
				},
				rfling = {
					[4] = 'rfling',
					[1] = "Enabled/disable fling  [only with fly]",
					[2] = {},
					[3] = cmds.rfling,
				},
				view = {
					[4] = 'view/spectate/spec [user]',
					[1] = "Spectate the player",
					[2] = {'spectate','spec'},
					[3] = cmds.view,
				},
				unview = {
					[4] = 'unview/unspectate/unspec',
					[1] = "Stop spectate",
					[2] = {'unspectate','unspec'},
					[3] = cmds.unview,
				},
				sync = {
					[4] = 'sync [user]',
					[1] = "Copy player character",
					[2] = {},
					[3] = cmds.sync,
				},
				teleport = {
					[4] = 'teleport/to/tp [user]',
					[1] = "Teleport to player",
					[2] = {'to','tp'},
					[3] = cmds.teleport,
				},
				prefix = {
					[4] = 'prefix/p [prefix]',
					[1] = "Set commands prefix",
					[2] = {'p'},
					[3] = cmds.prefix,
				},
				music = {
					[4] = 'music/mus <Id>',
					[1] = "Fires music remote",
					[2] = {'mus'},
					[3] = cmds.music,
				},
				earrape = {
					[4] = 'errape',
					[1] = "Do your ears bloody ;D",
					[2] = {},
					[3] = cmds.earrape,
				},
				bang = {
					[4] = 'bang [user] <speed>',
					[1] = "Bang someone",
					[2] = {},
					[3] = cmds.bang,
				},
				unbang = {
					[4] = 'unbang',
					[1] = "Stop banging",
					[2] = {},
					[3] = cmds.unbang,
				},
				servercrash = {
					[4] = 'servercrash/sc',
					[1] = "Attempt to crash server",
					[2] = {'sc'},
					[3] = cmds.servercrash,
				},
				antikick = {
					[4] = 'antikick/akk <false/true>',
					[1] = "Disable/Enable Anti-Kick",
					[2] = {'akk'},
					[3] = cmds.antikick,
				},
				antirejoin = {
					[4] = 'antirejoin/arj <false/true>',
					[1] = "Disable/Enable Anti-Rejoin",
					[2] = {'arj'},
					[3] = cmds.antirejoin,
				},
				shiftlock = {
					[4] = 'shiftlock/sfl <false/true>',
					[1] = "Disable/Enable shiftlock",
					[2] = {'sfl'},
					[3] = cmds.shiftlock,
				},
				cmdboxkey = {
					[4] = 'cmdboxkey [KEY]',
					[1] = "Set command box key",
					[2] = {},
					[3] = cmds.cmdboxkey,
				},
				flykey = {
					[4] = 'flykey [KEY]',
					[1] = "Set RFly key",
					[2] = {},
					[3] = cmds.flykey,
				},
				mutesounds = {
					[4] = 'mutesounds/ms',
					[1] = "Disable all sounds in game",
					[2] = {'ms'},
					[3] = cmds.mutesounds,
				},
				unmutesounds = {
					[4] = 'unmutesounds/ums',
					[1] = "Enable all sounds in game",
					[2] = {'ums'},
					[3] = cmds.unmutesounds,
				},
				antifling = {
					[4] = 'antifling/af <false/true>',
					[1] = "Disable/Enable Anti-Fling",
					[2] = {'af'},
					[3] = cmds.antifling,
				},
				respawn = {
					[4] = 'respawn/rs',
					[1] = "Respawn character",
					[2] = {'rs'},
					[3] = cmds.respawn,
				},
				headsit = {
					[4] = 'headsit [user]',
					[1] = "Sit on player head",
					[2] = {},
					[3] = cmds.headsit,
				},
				whisper = {
					[4] = 'whisper/pm [user] [message]',
					[1] = "Send PM message to user",
					[2] = {'pm'},
					[3] = cmds.whisper,
				},
				nofog = {
					[4] = 'nofog',
					[1] = "Remove Lighting FOG",
					[2] = {},
					[3] = cmds.nofog,
				},
				clearnilinstances = {
					[4] = 'clearnilinstances/cni',
					[1] = "Clear all what in NIL",
					[2] = {'cni'},
					[3] = cmds.clearnilinstances,
				},
				remove1stperson = {
					[4] = 'remove1stperson/r1p',
					[1] = "Remove first person limits",
					[2] = {'r1p'},
					[3] = cmds.remove1stperson,
				},
				follow = {
					[4] = 'follow [user]',
					[1] = "Follow[1] player",
					[2] = {},
					[3] = cmds.follow,
				},
				unfollow = {
					[4] = 'unfollow',
					[1] = "Stop following",
					[2] = {},
					[3] = cmds.unfollow,
				},
				message = {
					[4] = 'message/msg [message]',
					[1] = "Send message to chat",
					[2] = {'msg'},
					[3] = cmds.message,
				},
				follow2 = {
					[4] = 'follow2 [user]',
					[1] = "Follow[2] player",
					[2] = {},
					[3] = cmds.follow2,
				},
				audiologger = {
					[4] = 'audiologger/alogger',
					[1] = "Launchs Audio Logger from IY ;)",
					[2] = {'alogger'},
					[3] = cmds.audiologger,
				},
				sit = {
					[4] = 'sit',
					[1] = "Make you sit down",
					[2] = {},
					[3] = cmds.sit,
				},
				lay = {
					[4] = 'lay',
					[1] = "Make you lay down",
					[2] = {},
					[3] = cmds.lay,
				},
				freecam = {
					[4] = 'freecam/fc',
					[1] = "Turns freecam on",
					[2] = {'fc'},
					[3] = cmds.freecam,
				},
				unfreecam = {
					[4] = 'unfreecam/unfc',
					[1] = "Turns freecam off",
					[2] = {'unfc'},
					[3] = cmds.unfreecam,
				},
				freecamspeed = {
					[4] = 'freecamspeed/fcs <speed>',
					[1] = "Changes freecam speed",
					[2] = {'fcs'},
					[3] = cmds.freecamspeed,
				},
				gotocamera = {
					[4] = 'gotocamera/tocam [user]',
					[1] = "Turns your camera pos to someone camera pos",
					[2] = {'tocam'},
					[3] = cmds.gotocamera,
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
		repeat wait() until lplr.Character~=nil and getHum(lplr.Character)
		_G.spxadmin.ccs.died = con(getHum(lplr.Character).Died,Died)
	end)
end
