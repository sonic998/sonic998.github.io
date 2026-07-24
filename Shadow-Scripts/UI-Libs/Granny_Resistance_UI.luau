local lib = {}

function lib:CreateWindow(titleee)
	local Resistance = Instance.new("ScreenGui")
	local Header = Instance.new("Frame")
	local MainFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Background = Instance.new("ImageLabel")
	local title = Instance.new("TextLabel")
	local icon = Instance.new("ImageButton")
	local icondrag = Instance.new("ImageButton")
	local Minmize = Instance.new("TextButton")
	local Close = Instance.new("TextButton")
	local Back = Instance.new("TextButton")
	local TabsContainer = Instance.new("ScrollingFrame")

	Resistance.Name = "Granny"
	Resistance.ResetOnSpawn = false
	
	if get_hidden_gui or gethui then
        local hiddenUI = get_hidden_gui or gethui
        Resistance.Parent = hiddenUI()
    elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
        syn.protect_gui(Resistance)
        Resistance.Parent = game:GetService("CoreGui")
    else
        Resistance.Parent = game:GetService("CoreGui")
    end

	Header.Name = "Header"
	Header.Parent = Resistance
	Header.BackgroundColor3 = Color3.fromRGB(85, 200, 0)
	Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Header.BorderSizePixel = 0
	Header.Position = UDim2.new(0, 0, 0, 0)
	Header.Size = UDim2.new(0, 585, 0, 47)
	Header.Active = true
	Header.Visible = false

	Instance.new("UICorner", Header)
	
	local input = game:GetService("UserInputService")
	
	local dragging = false
    local dragInput, mousePos, framePos

    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = Header.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            Header.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = Header
	MainFrame.BackgroundColor3 = Color3.fromRGB(85, 170, 0)
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.new(-0.000402727688, 0, 0.997459888, 0)
	MainFrame.Size = UDim2.new(0, 585, 0, 0)
	MainFrame.ClipsDescendants = true

	Instance.new("UICorner", MainFrame)

	Background.Name = "Background"
	Background.Parent = MainFrame
	Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Background.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Background.BorderSizePixel = 0
	Background.Position = UDim2.new(0.000402727688, 0, 0.00317106163, 0)
	Background.Size = UDim2.new(0, 585, 0, 0)
	Background.Image = "http://www.roblox.com/asset/?id=121491507211166"

	Instance.new("UICorner", Background)

	title.Name = "title"
	title.Parent = Header
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1.000
	title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	title.BorderSizePixel = 0
	title.Position = UDim2.new(0.116, 0,0, 0)
	title.Size = UDim2.new(0, 356, 0, 50)
	title.Font = Enum.Font.SourceSansBold
	title.Text = titleee
	title.TextColor3 = Color3.fromRGB(0, 0, 0)
	title.TextScaled = true
	title.TextSize = 14.000
	title.TextWrapped = true

	icon.Name = "icon"
	icon.Parent = Header
	icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon.BackgroundTransparency = 1.000
	icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	icon.BorderSizePixel = 0
	icon.Position = UDim2.new(0, 0, 0.0425531901, 0)
	icon.Size = UDim2.new(0, 68, 0, 46)
	icon.Image = "rbxassetid://103033128787441"
	icon.MouseButton1Click:Connect(function()
	Header.Visible = false
	icondrag.Visible = true
	end)
	
	icondrag.Name = "icondrag"
	icondrag.Parent = Resistance
	icondrag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icondrag.BackgroundTransparency = 1.000
	icondrag.BorderColor3 = Color3.fromRGB(0, 0, 0)
	icondrag.BorderSizePixel = 0
	icondrag.Position = UDim2.new(0, 0, 0, 0)
	icondrag.Size = UDim2.new(0, 68, 0, 46)
	icondrag.Image = "rbxassetid://103033128787441"
	icondrag.Visible = true
	icondrag.MouseButton1Click:Connect(function()
	Header.Visible = true
	icondrag.Visible = false
	end)
	
	local input = game:GetService("UserInputService")
	
	local dragging = false
    local dragInput, mousePos, framePos

    icondrag.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = icondrag.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    icondrag.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            icondrag.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

	Minmize.Name = "Minmize"
	Minmize.Parent = Header
	Minmize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Minmize.BackgroundTransparency = 1.000
	Minmize.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Minmize.BorderSizePixel = 0
	Minmize.Position = UDim2.new(0.822222233, 0, 0.0425531901, 0)
	Minmize.Size = UDim2.new(0, 56, 0, 48)
	Minmize.Font = Enum.Font.SourceSansBold
	Minmize.Text = "-"
	Minmize.TextColor3 = Color3.fromRGB(0, 0, 0)
	Minmize.TextScaled = true
	Minmize.TextSize = 14.000
	Minmize.TextWrapped = true
	local toggle = false
	Minmize.MouseButton1Click:Connect(function()
		if toggle == false then
			game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 585, 0, 250)}):Play()
			game:GetService("TweenService"):Create(Background, TweenInfo.new(0.2), {Size = UDim2.new(0, 585, 0, 252)}):Play()
			Back.Visible = getgenv().vis
		else
			game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 585, 0, 0)}):Play()
			game:GetService("TweenService"):Create(Background, TweenInfo.new(0.2), {Size = UDim2.new(0, 585, 0, 0)}):Play()
			Back.Visible = false
		end
		toggle = not toggle
	end)

	Back.Name = "Back"
	Back.Parent = Header
	Back.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Back.BackgroundTransparency = 1.000
	Back.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Back.BorderSizePixel = 0
	Back.Position = UDim2.new(0.73, 0, 0.0425531901, 0)
	Back.Size = UDim2.new(0, 56, 0, 48)
	Back.Font = Enum.Font.SourceSansBold
	Back.Text = "<"
	Back.TextColor3 = Color3.fromRGB(0, 0, 0)
	Back.TextScaled = true
	Back.TextSize = 14.000
	Back.TextWrapped = true
	Back.Visible = false

	Close.Name = "Close"
	Close.Parent = Header
	Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Close.BackgroundTransparency = 1.000
	Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Close.BorderSizePixel = 0
	Close.Position = UDim2.new(0.90427351, 0, 0.0425531901, 0)
	Close.Size = UDim2.new(0, 56, 0, 48)
	Close.Font = Enum.Font.SourceSansBold
	Close.Text = "X"
	Close.TextColor3 = Color3.fromRGB(0, 0, 0)
	Close.TextScaled = true
	Close.TextSize = 14.000
	Close.TextWrapped = true
	Close.MouseButton1Click:Connect(function()
		Resistance:Destroy()
	end)
	
	TabsContainer.Name = "TabContainer"
	TabsContainer.Parent = Background
	TabsContainer.Active = true
	TabsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabsContainer.BackgroundTransparency = 1.000
	TabsContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabsContainer.BorderSizePixel = 0
	TabsContainer.Position = UDim2.new(0.0153846154, 0, 0.0396600552, 0)
	TabsContainer.Size = UDim2.new(0, 567, 0, 329)
	TabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabsContainer.ClipsDescendants = true
	TabsContainer.ScrollingDirection = Enum.ScrollingDirection.Y
	TabsContainer.ScrollBarThickness = 5

	local Tabs = {}

	function Tabs:CreateTab(txtt)
		local Tab = Instance.new("TextButton")
		local Tablisting = Instance.new("UIListLayout")

		Tab.Name = txtt
		Tab.Parent = TabsContainer
		Tab.BackgroundColor3 = Color3.fromRGB(85, 170, 0)
		Tab.BackgroundTransparency = 0.500
		Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.BorderSizePixel = 0
		Tab.Size = UDim2.new(0, 549,0, 30)
		Tab.Font = Enum.Font.SourceSansBold
		Tab.Text = txtt
		Tab.TextColor3 = Color3.fromRGB(44, 255, 20)
		Tab.TextScaled = true
		Tab.TextSize = 14.000
		Tab.TextWrapped = true

		Instance.new("UICorner", Tab)

		Tablisting.Parent = TabsContainer
		Tablisting.SortOrder = Enum.SortOrder.LayoutOrder
		Tablisting.Padding = UDim.new(0, 5)
		Tablisting.Changed:Connect(function()
			TabsContainer.CanvasSize = UDim2.new(0, 0, 0, Tablisting.AbsoluteContentSize.Y)
		end)
		
		local SectionFolder = Instance.new("Folder")
		SectionFolder.Name = "SectionFolder"
	    SectionFolder.Parent = Background

		local Section = {}

		function Section:NewSection(titlee)
			local SectionContainer = Instance.new("ScrollingFrame")
			local SectionListing = Instance.new("UIListLayout")
			
			SectionContainer.Name = titlee
			SectionContainer.Parent = SectionFolder
			SectionContainer.Active = true
			SectionContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionContainer.BackgroundTransparency = 1.000
			SectionContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionContainer.BorderSizePixel = 0
			SectionContainer.Position = UDim2.new(0.0153846154, 0, 0.0396600552, 0)
			SectionContainer.Size = UDim2.new(0, 549,0, 255)
			SectionContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
			SectionContainer.Visible = false
			SectionContainer.ClipsDescendants = true
			SectionContainer.ScrollingDirection = Enum.ScrollingDirection.Y
	        SectionContainer.ScrollBarThickness = 5

			SectionListing.Parent = SectionContainer
			SectionListing.SortOrder = Enum.SortOrder.LayoutOrder
			SectionListing.Padding = UDim.new(0, 5)
			SectionListing.FillDirection = Enum.FillDirection.Vertical
			SectionListing:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				SectionContainer.CanvasSize = UDim2.new(0, 0, 0, SectionListing.AbsoluteContentSize.Y)
			end)
			
			SectionContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
	
			Tab.MouseButton1Click:Connect(function()
			for i,v in pairs(TabsContainer:GetChildren()) do
			if v:IsA("TextButton") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
			end
			end
			for i,v in pairs(SectionContainer:GetChildren()) do
			if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("Frame") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
			end
			end
			wait(0.2)
				TabsContainer.Visible = false
				SectionContainer.Visible = true
				getgenv().vis = true
				Back.Visible = true
				
				for i,v in pairs(SectionFolder:GetChildren()) do
			v.Visible = false
			end
			SectionContainer.Visible = true
			end)
			
			Back.MouseButton1Click:Connect(function()
			for i,v in pairs(TabsContainer:GetChildren()) do
			if v:IsA("TextButton") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
			end
			end
			for i,v in pairs(SectionContainer:GetChildren()) do
			if v:IsA("TextButton") or v:IsA("TextLabel")  or v:IsA("Frame") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
			end
			end
			wait(0.2)
				TabsContainer.Visible = true
				SectionContainer.Visible = false
				getgenv().vis = false
				Back.Visible = false
			end)

			local Elements = {}

			function Elements:NewButton(txt, callback)
				local NewButton = Instance.new("TextButton")
				callback = callback or function() end

				NewButton.Name = txt
				NewButton.Parent = SectionContainer
				NewButton.BackgroundColor3 = Color3.fromRGB(85, 170, 0)
				NewButton.BackgroundTransparency = 0.500
				NewButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NewButton.BorderSizePixel = 0
				NewButton.Size = UDim2.new(0, 548,0, 29)
				NewButton.Font = Enum.Font.SourceSansBold
				NewButton.Text = txt
				NewButton.TextColor3 = Color3.fromRGB(44, 255, 20)
				NewButton.TextScaled = true
				NewButton.TextSize = 14.000
				NewButton.TextWrapped = true
				NewButton.MouseButton1Click:Connect(function()
					pcall(callback)
				end)

				Instance.new("UICorner", NewButton)

			end
			
			function Elements:NewLabel(txt)
				local NewLabel = Instance.new("TextLabel")

				NewLabel.Name = txt
				NewLabel.Parent = SectionContainer
				NewLabel.BackgroundColor3 = Color3.fromRGB(85, 170, 0)
				NewLabel.BackgroundTransparency = 0.500
				NewLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NewLabel.BorderSizePixel = 0
				NewLabel.Size = UDim2.new(0, 548,0, 29)
				NewLabel.Font = Enum.Font.SourceSansBold
				NewLabel.Text = txt
				NewLabel.TextColor3 = Color3.fromRGB(44, 255, 20)
				NewLabel.TextScaled = true
				NewLabel.TextSize = 14.000
				NewLabel.TextWrapped = true

				Instance.new("UICorner", NewLabel)
			end
			
			function Elements:NewToggle(txt, callback)
				callback = callback or function() end
				local tog = {}
				
				local Toggle = Instance.new("Frame")
				local title = Instance.new("TextLabel")
				local togglebackgrond = Instance.new("Frame")
				local ToggleBtn = Instance.new("Frame")
				local click = Instance.new("TextButton")

				Toggle.Name = txt
				Toggle.Parent = SectionContainer
				Toggle.BackgroundColor3 = Color3.fromRGB(85, 170, 0)
				Toggle.BackgroundTransparency = 0.500
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(0, 549, 0, 30)

				title.Name = "title"
				title.Parent = Toggle
				title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				title.BackgroundTransparency = 1.000
				title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				title.BorderSizePixel = 0
				title.Position = UDim2.new(0.31693989, 0, 0, 0)
				title.Size = UDim2.new(0, 200, 0, 30)
				title.Font = Enum.Font.SourceSansBold
				title.Text = txt
				title.TextColor3 = Color3.fromRGB(44, 255, 20)
				title.TextScaled = true
				title.TextSize = 14.000
				title.TextWrapped = true

				togglebackgrond.Name = "togglebackgrond"
				togglebackgrond.Parent = Toggle
				togglebackgrond.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
				togglebackgrond.BorderColor3 = Color3.fromRGB(0, 0, 0)
				togglebackgrond.BorderSizePixel = 0
				togglebackgrond.Position = UDim2.new(0.843351424, 0, 0.173333734, 0)
				togglebackgrond.Size = UDim2.new(0, 57, 0, 18)

				Instance.new("UICorner", togglebackgrond).CornerRadius = UDim.new(1, 0)

				ToggleBtn.Name = "ToggleBtn"
				ToggleBtn.Parent = togglebackgrond
				ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleBtn.BorderSizePixel = 0
				ToggleBtn.Position = UDim2.new(0, 0, 0, 0)
				ToggleBtn.Size = UDim2.new(0, 18, 0, 18)

				Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
				
				click.Name = "click"
				click.Parent = Toggle
				click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				click.BackgroundTransparency = 1.000
				click.BorderColor3 = Color3.fromRGB(0, 0, 0)
				click.BorderSizePixel = 0
				click.Text = ""
				click.Position = UDim2.new(0, 0, 0, 0)
				click.Size = UDim2.new(0, 548, 0, 30)
				click.Font = Enum.Font.SourceSans
				click.TextColor3 = Color3.fromRGB(0, 0, 0)
				click.TextSize = 14.000
				local togglee = false
				click.MouseButton1Click:Connect(function()
					if togglee == false then
						game:GetService("TweenService"):Create(ToggleBtn, TweenInfo.new(0.2), {Position = UDim2.new(0.688, 0, 0, 0)}):Play()
						game:GetService("TweenService"):Create(togglebackgrond, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 203, 85)}):Play()
					else
						game:GetService("TweenService"):Create(ToggleBtn, TweenInfo.new(0.2), {Position = UDim2.new(0, 0,0, 0)}):Play()
						game:GetService("TweenService"):Create(togglebackgrond, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
					end
					togglee = not togglee
					pcall(callback, togglee)
				end)
				
				function tog:EnableToggle()
					game:GetService("TweenService"):Create(ToggleBtn, TweenInfo.new(0.2), {Position = UDim2.new(0.688, 0, 0, 0)}):Play()
					game:GetService("TweenService"):Create(togglebackgrond, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 203, 85)}):Play()
					pcall(callback, true)
					togglee = true
				end
				
				return tog
			end
			return Elements
		end
		return Section
	end
	return Tabs
end
return lib
