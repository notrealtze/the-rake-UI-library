local Window = {}
Window.__index = Window

function Window.new(title)
	local self = setmetatable({}, Window)
	self._order = 0

	local sg = Instance.new("ScreenGui")
	sg.IgnoreGuiInset = true
	sg.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
	sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	sg.ResetOnSpawn = false

	local pua = {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""}
	local scrambled = ""
	for i = 1, 12 do
		scrambled = scrambled .. pua[math.random(1, #pua)]
	end
	sg.Name = scrambled

	local protected = pcall(function()
		syn.protect_gui(sg)
		sg.Parent = game:GetService("CoreGui")
	end)

	if not protected then
		local ok = pcall(function()
			sg.Parent = gethui()
		end)
		if not ok then
			sg.Parent = game:GetService("CoreGui")
		end
	end

	local frame = Instance.new("Frame")
	frame.Parent = sg
	frame.BorderSizePixel = 3
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.ClipsDescendants = true
	frame.Size = UDim2.new(0.50457, 0, 0.78704, 0)
	frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame.BackgroundTransparency = 0.2

	local frameCorner = Instance.new("UICorner")
	frameCorner.Parent = frame
	frameCorner.CornerRadius = UDim.new(0, 3)

	local frameStroke = Instance.new("UIStroke")
	frameStroke.Parent = frame
	frameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	frameStroke.Thickness = 2
	frameStroke.Color = Color3.fromRGB(140, 140, 140)

	local frameGradient = Instance.new("UIGradient")
	frameGradient.Parent = frame
	frameGradient.Rotation = 90
	frameGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(118, 118, 118))
	}

	local frameAspect = Instance.new("UIAspectRatioConstraint")
	frameAspect.Parent = frame
	frameAspect.AspectRatio = 1.3

	local titleLbl = Instance.new("TextLabel")
	titleLbl.Parent = frame
	titleLbl.TextWrapped = true
	titleLbl.TextStrokeTransparency = 0
	titleLbl.BorderSizePixel = 0
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.TextScaled = true
	titleLbl.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
	titleLbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
	titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Size = UDim2.new(0.75449, 0, 0.07531, 0)
	titleLbl.Text = title or "window"
	titleLbl.Position = UDim2.new(0.02069, 0, 0.015, 0)

	local hideBtn = Instance.new("TextButton")
	hideBtn.Parent = frame
	hideBtn.TextWrapped = true
	hideBtn.SizeConstraint = Enum.SizeConstraint.RelativeYY
	hideBtn.BorderSizePixel = 0
	hideBtn.Modal = true
	hideBtn.TextScaled = true
	hideBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
	hideBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	hideBtn.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	hideBtn.ZIndex = 4
	hideBtn.AnchorPoint = Vector2.new(1, 0)
	hideBtn.BackgroundTransparency = 0.95
	hideBtn.Size = UDim2.new(0.06923, 0, 0.09, 0)
	hideBtn.Text = "X"
	hideBtn.Name = "HideButton"
	hideBtn.Position = UDim2.new(1, 0, 0, 0)
	Instance.new("UICorner").Parent = hideBtn

	local scroll = Instance.new("ScrollingFrame")
	scroll.Parent = frame
	scroll.Active = true
	scroll.ScrollingDirection = Enum.ScrollingDirection.Y
	scroll.BorderSizePixel = 0
	scroll.ElasticBehavior = Enum.ElasticBehavior.Always
	scroll.BackgroundTransparency = 1
	scroll.Size = UDim2.new(1, 0, 0.97899, 0)
	scroll.Position = UDim2.new(0.00452, 0, 0.11245, 0)
	scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

	local layout = Instance.new("UIListLayout")
	layout.Parent = scroll
	layout.Padding = UDim.new(0, 15)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	self._scroll = scroll
	self._visible = true

	hideBtn.MouseButton1Click:Connect(function()
		self._visible = not self._visible
		scroll.Visible = self._visible
		titleLbl.Visible = self._visible
		hideBtn.Text = self._visible and "X" or "+"
	end)

	return self
end

function Window:AddToggle(labelText, default, callback)
	self._order += 1

	local row = Instance.new("Frame")
	row.Parent = self._scroll
	row.BorderSizePixel = 0
	row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	row.BackgroundTransparency = 0.95
	row.Size = UDim2.new(0, 436, 0, 36)
	row.LayoutOrder = self._order
	Instance.new("UICorner").Parent = row

	local divider = Instance.new("Frame")
	divider.Parent = row
	divider.BorderSizePixel = 0
	divider.BackgroundColor3 = Color3.fromRGB(88, 88, 88)
	divider.AnchorPoint = Vector2.new(0.5, 0.5)
	divider.Size = UDim2.new(0.00917, 0, 1.05556, 0)
	divider.Position = UDim2.new(0.5, 0, 0.5, 0)
	divider.BackgroundTransparency = 0.8

	local lbl = Instance.new("TextLabel")
	lbl.Parent = row
	lbl.TextWrapped = true
	lbl.TextStrokeTransparency = 0.5
	lbl.BorderSizePixel = 0
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextScaled = true
	lbl.BackgroundTransparency = 1
	lbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	lbl.AnchorPoint = Vector2.new(0, 0.5)
	lbl.Size = UDim2.new(1, 0, 0.7, 0)
	lbl.Position = UDim2.new(0.01147, 0, 0.5, 0)
	lbl.Text = labelText

	local state = default ~= false

	local btn = Instance.new("TextButton")
	btn.Parent = row
	btn.TextWrapped = true
	btn.TextStrokeTransparency = 0.5
	btn.BorderSizePixel = 0
	btn.TextScaled = true
	btn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	btn.AnchorPoint = Vector2.new(1, 0.5)
	btn.BackgroundTransparency = 0.5
	btn.Size = UDim2.new(0.16055, 0, 0.77778, 0)
	btn.Position = UDim2.new(0.98165, 0, 0.5, 0)
	btn.Text = state and "ON" or "OFF"
	btn.TextColor3 = state and Color3.fromRGB(118, 255, 112) or Color3.fromRGB(255, 80, 80)
	btn.BackgroundColor3 = state and Color3.fromRGB(118, 255, 112) or Color3.fromRGB(255, 80, 80)
	Instance.new("UICorner").Parent = btn

	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = state and "ON" or "OFF"
		btn.TextColor3 = state and Color3.fromRGB(118, 255, 112) or Color3.fromRGB(255, 80, 80)
		btn.BackgroundColor3 = state and Color3.fromRGB(118, 255, 112) or Color3.fromRGB(255, 80, 80)
		if callback then callback(state) end
	end)

	return {
		GetState = function() return state end,
		SetState = function(v)
			state = v
			btn.Text = state and "ON" or "OFF"
			btn.TextColor3 = state and Color3.fromRGB(118, 255, 112) or Color3.fromRGB(255, 80, 80)
			btn.BackgroundColor3 = state and Color3.fromRGB(118, 255, 112) or Color3.fromRGB(255, 80, 80)
			if callback then callback(state) end
		end
	}
end

function Window:AddButton(labelText, callback)
	self._order += 1

	local row = Instance.new("Frame")
	row.Parent = self._scroll
	row.BorderSizePixel = 0
	row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	row.BackgroundTransparency = 0.95
	row.Size = UDim2.new(0, 436, 0, 36)
	row.LayoutOrder = self._order
	Instance.new("UICorner").Parent = row

	local divider = Instance.new("Frame")
	divider.Parent = row
	divider.BorderSizePixel = 0
	divider.BackgroundColor3 = Color3.fromRGB(88, 88, 88)
	divider.AnchorPoint = Vector2.new(0.5, 0.5)
	divider.Size = UDim2.new(0.00917, 0, 1.05556, 0)
	divider.Position = UDim2.new(0.5, 0, 0.5, 0)
	divider.BackgroundTransparency = 0.8

	local lbl = Instance.new("TextLabel")
	lbl.Parent = row
	lbl.TextWrapped = true
	lbl.TextStrokeTransparency = 0.5
	lbl.BorderSizePixel = 0
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextScaled = true
	lbl.BackgroundTransparency = 1
	lbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	lbl.AnchorPoint = Vector2.new(0, 0.5)
	lbl.Size = UDim2.new(1, 0, 0.7, 0)
	lbl.Position = UDim2.new(0.01147, 0, 0.5, 0)
	lbl.Text = labelText

	local btn = Instance.new("ImageButton")
	btn.Parent = row
	btn.BorderSizePixel = 0
	btn.ScaleType = Enum.ScaleType.Crop
	btn.BackgroundTransparency = 0.5
	btn.BackgroundColor3 = Color3.fromRGB(118, 255, 112)
	btn.AnchorPoint = Vector2.new(1, 0.5)
	btn.Image = "rbxassetid://107092551835785"
	btn.Size = UDim2.new(0.09633, 0, 1.05556, 0)
	btn.Position = UDim2.new(0.98165, 0, 0.5, 0)
	Instance.new("UICorner").Parent = btn

	btn.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)
end

function Window:AddTextBox(labelText, placeholder, callback)
	self._order += 1

	local row = Instance.new("Frame")
	row.Parent = self._scroll
	row.BorderSizePixel = 0
	row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	row.BackgroundTransparency = 0.95
	row.Size = UDim2.new(0, 436, 0, 36)
	row.LayoutOrder = self._order
	Instance.new("UICorner").Parent = row

	local divider = Instance.new("Frame")
	divider.Parent = row
	divider.BorderSizePixel = 0
	divider.BackgroundColor3 = Color3.fromRGB(88, 88, 88)
	divider.AnchorPoint = Vector2.new(0.5, 0.5)
	divider.Size = UDim2.new(0.00917, 0, 1.05556, 0)
	divider.Position = UDim2.new(0.5, 0, 0.5, 0)
	divider.BackgroundTransparency = 0.8

	local lbl = Instance.new("TextLabel")
	lbl.Parent = row
	lbl.TextWrapped = true
	lbl.TextStrokeTransparency = 0.5
	lbl.BorderSizePixel = 0
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextScaled = true
	lbl.BackgroundTransparency = 1
	lbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	lbl.AnchorPoint = Vector2.new(0, 0.5)
	lbl.Size = UDim2.new(1, 0, 0.7, 0)
	lbl.Position = UDim2.new(0.01147, 0, 0.5, 0)
	lbl.Text = labelText

	local tb = Instance.new("TextBox")
	tb.Parent = row
	tb.TextStrokeTransparency = 0.5
	tb.BorderSizePixel = 0
	tb.TextWrapped = true
	tb.TextSize = 18
	tb.TextColor3 = Color3.fromRGB(118, 255, 112)
	tb.BackgroundColor3 = Color3.fromRGB(118, 255, 112)
	tb.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	tb.AnchorPoint = Vector2.new(1, 0.5)
	tb.Size = UDim2.new(0.16055, 0, 0.77778, 0)
	tb.Position = UDim2.new(0.98165, 0, 0.5, 0)
	tb.BackgroundTransparency = 0.5
	tb.PlaceholderText = placeholder or ""
	tb.Text = ""
	Instance.new("UICorner").Parent = tb

	tb.FocusLost:Connect(function(enter)
		if enter and callback then callback(tb.Text) end
	end)

	return {
		GetText = function() return tb.Text end,
		SetText = function(v) tb.Text = v end
	}
end

function Window:AddLabel(text)
	self._order += 1

	local row = Instance.new("Frame")
	row.Parent = self._scroll
	row.BorderSizePixel = 0
	row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	row.BackgroundTransparency = 0.95
	row.Size = UDim2.new(0, 436, 0, 36)
	row.LayoutOrder = self._order
	Instance.new("UICorner").Parent = row

	local lbl = Instance.new("TextLabel")
	lbl.Parent = row
	lbl.TextWrapped = true
	lbl.TextStrokeTransparency = 0.5
	lbl.BorderSizePixel = 0
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextScaled = true
	lbl.BackgroundTransparency = 1
	lbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	lbl.AnchorPoint = Vector2.new(0, 0.5)
	lbl.Size = UDim2.new(1, 0, 0.7, 0)
	lbl.Position = UDim2.new(0.01147, 0, 0.5, 0)
	lbl.Text = text
end

function Window:SetVisible(v)
	self._scroll.Parent.Visible = v
end

function Window:Destroy()
	self._scroll.Parent.Parent:Destroy()
end

return Window
