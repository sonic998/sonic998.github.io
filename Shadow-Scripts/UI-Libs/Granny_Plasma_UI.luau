local lib = {}

function lib:CreateWindow(titleee)
	local PlasmaUI = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIGradient = Instance.new("UIGradient")
	local TabsSection = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local TabsContainer = Instance.new("ScrollingFrame")
	local UIGradient_2 = Instance.new("UIGradient")
	local Header = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local title = Instance.new("TextLabel")
	local close = Instance.new("ImageButton")
	local min = Instance.new("ImageButton")
	local UIGradient_3 = Instance.new("UIGradient")
	local Section = Instance.new("Frame")
	local UIGradient_4 = Instance.new("UIGradient")
	local ArrowVisible = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local TabList = Instance.new("UIListLayout")

	PlasmaUI.Name = "PlasmaUI"
	PlasmaUI.ResetOnSpawn = false

    if get_hidden_gui or gethui then
        local hiddenUI = get_hidden_gui or gethui
        PlasmaUI.Parent = hiddenUI()
    elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
        syn.protect_gui(PlasmaUI)
        PlasmaUI.Parent = game:GetService("CoreGui")
    else
        PlasmaUI.Parent = game:GetService("CoreGui")
    end

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = PlasmaUI
	MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.new(0.298850566, 0, 0.191139236, 0)
	MainFrame.Size = UDim2.new(0, 559, 0, 336)

	UICorner.Parent = MainFrame

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 127)), ColorSequenceKeypoint.new(0.37, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 85, 255))}
	UIGradient.Rotation = 45
	UIGradient.Parent = MainFrame

	TabsSection.Name = "TabsSection"
	TabsSection.Parent = MainFrame
	TabsSection.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
	TabsSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabsSection.BorderSizePixel = 0
	TabsSection.Position = UDim2.new(0.0483005382, 0, 0.032738097, 0)

	UICorner_2.Parent = TabsSection

	TabsContainer.Name = "TabsContainer"
	TabsContainer.Parent = TabsSection
	TabsContainer.Active = true
	TabsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabsContainer.BackgroundTransparency = 1.000
	TabsContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabsContainer.BorderSizePixel = 0
	TabsContainer.Position = UDim2.new(0.0599999987, 0, 0.0293159615, 0)
	TabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabsContainer.ScrollBarThickness = 5

	TabList.Parent = TabsContainer
	TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabList.SortOrder = Enum.SortOrder.LayoutOrder
	TabList.Padding = UDim.new(0, 5)
	TabList.Changed:Connect(function()
		TabsContainer.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y)
	end)


	UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 127)), ColorSequenceKeypoint.new(0.37, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 85, 255))}
	UIGradient_2.Rotation = 45
	UIGradient_2.Parent = TabsSection

	Header.Name = "Header"
	Header.Parent = PlasmaUI
	Header.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
	Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Header.BorderSizePixel = 0
	Header.Position = UDim2.new(0.298850566, 0, 0.131139236, 0)
	Header.Size = UDim2.new(0, 559, 0, 45)

	local input = game:GetService("UserInputService")

	local dragging = false
    local dragInput, mousePos, framePos

    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = MainFrame.Position

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
            MainFrame.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

	UICorner_4.Parent = Header

	title.Name = "title"
	title.Parent = Header
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1.000
	title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	title.BorderSizePixel = 0
	title.Position = UDim2.new(0.320214659, 0, 0.13333334, 0)
	title.Size = UDim2.new(0, 200, 0, 33)
	title.Font = Enum.Font.SourceSans
	title.Text = titleee
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextScaled = true
	title.TextSize = 14.000
	title.TextWrapped = true

	close.Name = "close"
	close.Parent = Header
	close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	close.BackgroundTransparency = 1.000
	close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	close.BorderSizePixel = 0
	close.Position = UDim2.new(0.919499218, 0, 0, 0)
	close.Size = UDim2.new(0, 45, 0, 39)
	close.Image = "rbxassetid://6031094678"
	close.MouseButton1Down:Connect(function()
		PlasmaUI:Destroy()
	end)

	min.Name = "min"
	min.Parent = Header
	min.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	min.BackgroundTransparency = 1.000
	min.BorderColor3 = Color3.fromRGB(0, 0, 0)
	min.BorderSizePixel = 0
	min.Position = UDim2.new(0.822898149, 0, 0, 0)
	min.Size = UDim2.new(0, 45, 0, 39)
	min.Image = "rbxassetid://6035067836"

	UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 127)), ColorSequenceKeypoint.new(0.37, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 85, 255))}
	UIGradient_3.Rotation = 45
	UIGradient_3.Parent = Header

	Section.Name = "Section"
	Section.Parent = MainFrame
	Section.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
	Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Section.BorderSizePixel = 0
	Section.Position = UDim2.new(0.0590000004, 0, 0.0329999998, 0)
	Section.Size = UDim2.new(0, 510, 0, 307)

	UICorner_5.Parent = Section

	UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 127)), ColorSequenceKeypoint.new(0.37, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 85, 255))}
	UIGradient_4.Rotation = 45
	UIGradient_4.Parent = Section

	ArrowVisible.Name = "ArrowVisible"
	ArrowVisible.Parent = MainFrame
	ArrowVisible.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ArrowVisible.BackgroundTransparency = 1.000
	ArrowVisible.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ArrowVisible.BorderSizePixel = 0
	ArrowVisible.Position = UDim2.new(0, 0, 0.032738097, 0)
	ArrowVisible.Size = UDim2.new(0, 27, 0, 307)
	
	local function Dynamic_colors(frame)
	local uiGradient = frame:WaitForChild("UIGradient")
	local runService = game:GetService("RunService")

	local WAVE_SPEED = 1.5
	local ROTATION_SPEED = 45
	local WAVE_TIGHTNESS = 4

	local purple = Color3.fromRGB(140, 20, 255)
	local blue = Color3.fromRGB(20, 150, 255)

	runService.RenderStepped:Connect(function(deltaTime)
		local clock = os.clock()

		local currentRotation = uiGradient.Rotation
		uiGradient.Rotation = (currentRotation + (ROTATION_SPEED * deltaTime)) % 360

		local t = clock * WAVE_SPEED

		local point1 = (math.sin(t) + 1) / 2
		local point2 = (math.sin(t + math.pi/WAVE_TIGHTNESS) + 1) / 2
		local point3 = (math.sin(t + (math.pi/WAVE_TIGHTNESS) * 2) + 1) / 2

		local p1 = math.min(point1, point2, point3)
		local p3 = math.max(point1, point2, point3)
		local p2 = (point1 + point2 + point3) - p1 - p3

		p1 = math.clamp(p1, 0, 0.99)
		p2 = math.clamp(p2, p1 + 0.001, 0.999)
		p3 = math.clamp(p3, p2 + 0.001, 1)

		uiGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, purple),
			ColorSequenceKeypoint.new(p1, blue),
			ColorSequenceKeypoint.new(p2, purple),
			ColorSequenceKeypoint.new(p3, blue),
			ColorSequenceKeypoint.new(1, purple)
		})
	end)
	end
	
	Dynamic_colors(Section)
	Dynamic_colors(Header)
	Dynamic_colors(TabsSection)
	Dynamic_colors(MainFrame)

	local Tabs = {}

	function Tabs:CreateTab(name)
		local TabButton = Instance.new("TextButton")
		local UICorner_3 = Instance.new("UICorner")

		TabButton.Parent = TabsContainer
		TabButton.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Position = UDim2.new(0.0340909101, 0, 0.0137457047, 0)
		TabButton.Size = UDim2.new(0, 82, 0, 36)
		TabButton.Font = Enum.Font.SourceSans
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextScaled = true
		TabButton.TextSize = 14.000
		TabButton.TextWrapped = true
		TabButton.Text = name

		UICorner_3.Parent = TabButton

		local Sections = {}

		function Sections:NewSection(name)
			local SectionContainer = Instance.new("ScrollingFrame")
			local SectionList = Instance.new("UIListLayout")

			SectionContainer.Name = name
			SectionContainer.Parent = Section
			SectionContainer.Active = true
			SectionContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionContainer.BackgroundTransparency = 1.000
			SectionContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionContainer.BorderSizePixel = 0
			SectionContainer.Position = UDim2.new(0.0235035624, 0, 0.0293159615, 0)
			SectionContainer.Size = UDim2.new(0, 483, 0, 291)
			SectionContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
			SectionContainer.ScrollBarThickness = 5

			SectionList.Parent = SectionContainer
			SectionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
			SectionList.SortOrder = Enum.SortOrder.LayoutOrder
			SectionList.Padding = UDim.new(0, 5)
			SectionList.Changed:Connect(function()
				SectionContainer.CanvasSize = UDim2.new(0, 0, 0, SectionList.AbsoluteContentSize.Y)
			end)

			TabButton.MouseButton1Click:Connect(function()
				for i,v in next, Section:GetChildren() do
					if v:IsA("ScrollingFrame") then
						v.Visible = false
					end
				end
				SectionContainer.Visible = true
			end)

				for i,v in next, Section:GetChildren() do
					if v:IsA("ScrollingFrame") then
						v.Visible = false
					end
				end
				SectionContainer.Visible = true

			ArrowVisible.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(Section, TweenInfo.new(0.2), {Size = UDim2.new(0, 411,0, 307)}):Play()
				game:GetService("TweenService"):Create(Section, TweenInfo.new(0.2), {Position = UDim2.new(0.24, 0,0.033, 0)}):Play()
				game:GetService("TweenService"):Create(SectionContainer, TweenInfo.new(0.2), {Size = UDim2.new(0, 395,0, 291)}):Play()
				game:GetService("TweenService"):Create(SectionContainer, TweenInfo.new(0.2), {Position = UDim2.new(0.024, 0,0.029, 0)}):Play()
				game:GetService("TweenService"):Create(TabsSection, TweenInfo.new(0.2), {Position = UDim2.new(0.048, 0,0.033, 0)}):Play()
				game:GetService("TweenService"):Create(TabsSection, TweenInfo.new(0.2), {Size = UDim2.new(0, 100,0, 307)}):Play()
				game:GetService("TweenService"):Create(TabsContainer, TweenInfo.new(0.2), {Position = UDim2.new(0.06, 0,0.029, 0)}):Play()
				game:GetService("TweenService"):Create(TabsContainer, TweenInfo.new(0.2), {Size = UDim2.new(0, 88,0, 291)}):Play()

				for i,v in pairs(SectionContainer:GetChildren()) do
					if v:IsA("Frame") then
						v.Size = UDim2.new(0, 387,0, 44)
					end
					if v:IsA("TextButton") then
						v.Size = UDim2.new(0, 387,0, 44)
					end
					if v:IsA("TextLabel") then
						v.Size = UDim2.new(0, 387,0, 44)
					end
				end
			end)

			TabsSection.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(Section, TweenInfo.new(0.2), {Size = UDim2.new(0, 510,0, 307)}):Play()
				game:GetService("TweenService"):Create(Section, TweenInfo.new(0.2), {Position = UDim2.new(0.059, 0,0.033, 0)}):Play()
				game:GetService("TweenService"):Create(SectionContainer, TweenInfo.new(0.2), {Size = UDim2.new(0, 483,0, 291)}):Play()
				game:GetService("TweenService"):Create(SectionContainer, TweenInfo.new(0.2), {Position = UDim2.new(0.024, 0,0.029, 0)}):Play()
				game:GetService("TweenService"):Create(TabsSection, TweenInfo.new(0.2), {Size = UDim2.new(0, 0,0, 0)}):Play()
				game:GetService("TweenService"):Create(TabsContainer, TweenInfo.new(0.2), {Size = UDim2.new(0, 0,0, 0)}):Play()
				for i,v in pairs(SectionContainer:GetChildren()) do
					if v:IsA("Frame") then
						v.Size = UDim2.new(0, 473,0, 44)
					end
					if v:IsA("TextButton") then
						v.Size = UDim2.new(0, 473,0, 44)
					end
					if v:IsA("TextLabel") then
						v.Size = UDim2.new(0, 473,0, 44)
					end
				end
			end)

			local Elements = {}

			function Elements:NewButton(name, callback)
				local Button = Instance.new("TextButton")
				local UICorner_6 = Instance.new("UICorner")

				callback = callback or function() end

				Button.Name = "Button"
				Button.Parent = SectionContainer
				Button.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Position = UDim2.new(0, 0, 0, 0)
				Button.Size = UDim2.new(0, 473, 0, 44)
				Button.Font = Enum.Font.SourceSans
				Button.TextColor3 = Color3.fromRGB(255, 255, 255)
				Button.TextScaled = true
				Button.TextSize = 14.000
				Button.TextWrapped = true
				Button.Text = name
				Button.MouseButton1Click:Connect(function()
					callback()
				end)

				UICorner_6.Parent = Button
			end

			function Elements:NewLabel(name)
				local Label = Instance.new("TextLabel")
				local UICorner_6 = Instance.new("UICorner")

				Label.Name = "Label"
				Label.Parent = SectionContainer
				Label.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
				Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Label.BorderSizePixel = 0
				Label.Position = UDim2.new(0, 0, 0, 0)
				Label.Size = UDim2.new(0, 473, 0, 44)
				Label.Font = Enum.Font.SourceSans
				Label.TextColor3 = Color3.fromRGB(255, 255, 255)
				Label.TextScaled = true
				Label.TextSize = 14.000
				Label.TextWrapped = true
				Label.Text = name

				UICorner_6.Parent = Label
			end

			function Elements:NewInput(name, callback)
				callback = callback or function() end
				local InputBox = Instance.new("Frame")
				local UICorner_10 = Instance.new("UICorner")
				local title_3 = Instance.new("TextLabel")
				local TextBox = Instance.new("TextBox")
				local UICorner_11 = Instance.new("UICorner")

				InputBox.Name = "InputBox"
				InputBox.Parent = SectionContainer
				InputBox.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
				InputBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InputBox.BorderSizePixel = 0
				InputBox.Position = UDim2.new(0.638, 0,0.136, 0)
				InputBox.Size = UDim2.new(0, 473, 0, 44)

				UICorner_10.Parent = InputBox

				title_3.Name = "title"
				title_3.Parent = InputBox
				title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				title_3.BackgroundTransparency = 1.000
				title_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				title_3.BorderSizePixel = 0
				title_3.Position = UDim2.new(0, 0,0.136, 0)
				title_3.Size = UDim2.new(0, 95, 0, 31)
				title_3.Font = Enum.Font.SourceSans
				title_3.Text = name
				title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				title_3.TextScaled = true
				title_3.TextSize = 14.000
				title_3.TextWrapped = true

				TextBox.Parent = InputBox
				TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.BorderSizePixel = 0
				TextBox.Position = UDim2.new(0.34, 0,0.227, 0)
				TextBox.Size = UDim2.new(0, 135, 0, 31)
				TextBox.ClearTextOnFocus = false
				TextBox.Font = Enum.Font.SourceSans
				TextBox.Text = ""
				TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.TextScaled = true
				TextBox.TextSize = 14.000
				TextBox.TextWrapped = true
				TextBox.FocusLost:Connect(function()
					pcall(callback, TextBox.Text)
				end)

				UICorner_11.Parent = TextBox
			end

			function Elements:NewSlider(name, callback)
				callback = callback or function() end
				local Slider = Instance.new("Frame")
				local UICorner_12 = Instance.new("UICorner")
				local title_4 = Instance.new("TextLabel")
				local Slider_2 = Instance.new("Frame")
				local Fill = Instance.new("Frame")
				local UICorner_13 = Instance.new("UICorner")
				local Trigger = Instance.new("TextButton")
				local UICorner_14 = Instance.new("UICorner")
				local CountLabel = Instance.new("TextLabel")

				Slider.Name = "Slider"
				Slider.Parent = SectionContainer
				Slider.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.Position = UDim2.new(0.579, 0,0.142, 0)
				Slider.Size = UDim2.new(0, 473, 0, 44)

				UICorner_12.Parent = Slider

				title_4.Name = "title"
				title_4.Parent = Slider
				title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				title_4.BackgroundTransparency = 1.000
				title_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				title_4.BorderSizePixel = 0
				title_4.Position = UDim2.new(0, 0,0.136, 0)
				title_4.Size = UDim2.new(0, 93, 0, 31)
				title_4.Font = Enum.Font.SourceSans
				title_4.Text = name
				title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
				title_4.TextScaled = true
				title_4.TextSize = 14.000
				title_4.TextWrapped = true

				Slider_2.Name = "Slider"
				Slider_2.Parent = Slider
				Slider_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider_2.BorderSizePixel = 0
				Slider_2.Position = UDim2.new(0.34, 0,0.142, 0)
				Slider_2.Size = UDim2.new(0, 146, 0, 30)

				Fill.Name = "Fill"
				Fill.Parent = Slider_2
				Fill.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
				Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Fill.BorderSizePixel = 0

				UICorner_13.Parent = Fill

				Trigger.Name = "Trigger"
				Trigger.Parent = Slider_2
				Trigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Trigger.BackgroundTransparency = 1.000
				Trigger.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Trigger.BorderSizePixel = 0
				Trigger.Size = UDim2.new(0, 145, 0, 30)
				Trigger.Font = Enum.Font.SourceSans
				Trigger.Text = ""
				Trigger.TextColor3 = Color3.fromRGB(0, 0, 0)
				Trigger.TextSize = 14.000

				UICorner_14.Parent = Slider_2

				CountLabel.Name = "CountLabel"
				CountLabel.Parent = Slider_2
				CountLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				CountLabel.BackgroundTransparency = 1.000
				CountLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				CountLabel.BorderSizePixel = 0
				CountLabel.Size = UDim2.new(0, 146, 0, 31)
				CountLabel.Font = Enum.Font.SourceSans
				CountLabel.Text = "100"
				CountLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
				CountLabel.TextScaled = true
				CountLabel.TextSize = 14.000
				CountLabel.TextWrapped = true

				local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
				local Slider = Slider_2
				local Fill = Fill
				local Trigger = Trigger
				_G.OutputValue = 0
				local OutputLabel = CountLabel

				local MaxValue = 0.7 or 70/100
				local StartingValue = 0.4 or 40/100

				Fill.Size = UDim2.fromScale(_G.OutputValue,1)
				OutputLabel.Text = tostring(math.round(_G.OutputValue*100))

				local TweenService = game:GetService("TweenService")
				local TweenStyle = TweenInfo.new(0.25, Enum.EasingStyle.Exponential)

				local function UpdateSlider()
					local output = math.clamp(((Vector2.new(Mouse.X,Mouse.Y) - Slider.AbsolutePosition)/Slider.AbsoluteSize).X,0,1)

					local outputClamped = StartingValue + (output*(MaxValue-StartingValue))

					if _G.OutputValue ~= outputClamped then
						TweenService:Create(Fill,TweenStyle,{Size = UDim2.fromScale(output,1)}):Play()
					end

					_G.OutputValue = outputClamped
					OutputLabel.Text = tostring(math.round(Fill.Size.X.Scale*100))
					print(tostring(math.round(Fill.Size.X.Scale*100)))
				end

				Fill:GetPropertyChangedSignal("Size"):Connect(function()
					OutputLabel.Text = tostring(math.round(Fill.Size.X.Scale*100))
					print(tostring(math.round(Fill.Size.X.Scale*100)))
				end)

				local sliderActive = false

				local function ActivateSlider()
					sliderActive = true
					while sliderActive do
						UpdateSlider()
						task.wait()
					end
				end

				Trigger.MouseButton1Down:Connect(ActivateSlider)

				game:GetService("UserInputService").InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						sliderActive = false
					end
				end)
			end
			function Elements:NewToggle(name, callback)
			local tog = {}
				callback = callback or function() end

				local Toggle = Instance.new("Frame")
				local title_2 = Instance.new("TextLabel")
				local UICorner_7 = Instance.new("UICorner")
				local ToggleFrame = Instance.new("Frame")
				local UICorner_8 = Instance.new("UICorner")
				local ToggleIcon = Instance.new("Frame")
				local UICorner_9 = Instance.new("UICorner")
				local click = Instance.new("TextButton")

				Toggle.Name = name
				Toggle.Parent = SectionContainer
				Toggle.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0.0124223605, 0, 0.185567006, 0)
				Toggle.Size = UDim2.new(0, 473, 0, 44)

				title_2.Name = "title"
				title_2.Parent = Toggle
				title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				title_2.BackgroundTransparency = 1.000
				title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				title_2.BorderSizePixel = 0
				title_2.Position = UDim2.new(0, 0,0.136, 0)
				title_2.Size = UDim2.new(0, 93, 0, 31)
				title_2.Font = Enum.Font.SourceSans
				title_2.Text = name
				title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				title_2.TextScaled = true
				title_2.TextSize = 14.000
				title_2.TextWrapped = true

				UICorner_7.Parent = Toggle

				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = Toggle
				ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleFrame.BorderSizePixel = 0
				ToggleFrame.Position = UDim2.new(0.416, 0,0.227, 0)
				ToggleFrame.Size = UDim2.new(0, 80, 0, 27)

				UICorner_8.CornerRadius = UDim.new(1, 0)
				UICorner_8.Parent = ToggleFrame

				ToggleIcon.Name = "ToggleIcon"
				ToggleIcon.Parent = ToggleFrame
				ToggleIcon.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
				ToggleIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleIcon.BorderSizePixel = 0
				ToggleIcon.Size = UDim2.new(0, 26, 0, 27)

				UICorner_9.CornerRadius = UDim.new(1, 0)
				UICorner_9.Parent = ToggleIcon

				click.Name = "click"
				click.Parent = Toggle
				click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				click.BackgroundTransparency = 1.000
				click.BorderColor3 = Color3.fromRGB(0, 0, 0)
				click.BorderSizePixel = 0
				click.Size = UDim2.new(0, 473, 0, 44)
				click.Font = Enum.Font.SourceSans
				click.Text = ""
				click.TextColor3 = Color3.fromRGB(0, 0, 0)
				click.TextSize = 14.000
				local togglee = false
				click.MouseButton1Click:Connect(function()
					if not togglee then
						game:GetService("TweenService"):Create(ToggleIcon, TweenInfo.new(0.2), {Position = UDim2.new(0.675, 0,0, 0)}):Play()
						game:GetService("TweenService"):Create(ToggleIcon, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0,255,0)}):Play()
					else
						game:GetService("TweenService"):Create(ToggleIcon, TweenInfo.new(0.2), {Position = UDim2.new(0,0,0,0)}):Play()
						game:GetService("TweenService"):Create(ToggleIcon, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255,0,0)}):Play()
					end
					togglee = not togglee
					pcall(callback, togglee)
				end)
				function tog:EnableToggle()
						game:GetService("TweenService"):Create(ToggleIcon, TweenInfo.new(0.2), {Position = UDim2.new(0.675, 0,0, 0)}):Play()
						game:GetService("TweenService"):Create(ToggleIcon, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0,255,0)}):Play()
					pcall(callback, true)
					togglee = true
				end

				return tog
			end
			return Elements
		end
		return Sections
	end
	return Tabs
end
return lib
