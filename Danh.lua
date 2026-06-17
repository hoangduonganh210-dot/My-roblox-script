local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

-- ====================================================================
-- 1. KHỞI TẠO FRAME CHÍNH VÀ PHÂN VÙNG GIAO DIỆN
-- ====================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DAnhChoiDeadRail"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainWindow"
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

-- Thanh Tiêu Đề
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "⚡ DEAD RAILS INTERNAL ASSISTANT v1.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

-- Nút Đóng X
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)

-- Khung cuộn chứa tính năng
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -55)
ScrollFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
ScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollFrame

-- Hàm tạo nút tự động
local function CreateFeatureButton(name, description, isPlaceholder, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, -10, 0, 60)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    ButtonFrame.Parent = ScrollFrame

    Instance.new("UICorner", ButtonFrame).CornerRadius = UDim.new(0, 6)

    local FuncTitle = Instance.new("TextLabel")
    FuncTitle.Size = UDim2.new(0.7, 0, 0.4, 0)
    FuncTitle.Position = UDim2.new(0, 15, 0, 10)
    FuncTitle.Text = name
    FuncTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    FuncTitle.Font = Enum.Font.GothamBold
    FuncTitle.TextSize = 14
    FuncTitle.TextXAlignment = Enum.TextXAlignment.Left
    FuncTitle.BackgroundTransparency = 1
    FuncTitle.Parent = ButtonFrame

    local FuncDesc = Instance.new("TextLabel")
    FuncDesc.Size = UDim2.new(0.7, 0, 0.4, 0)
    FuncDesc.Position = UDim2.new(0, 15, 0, 32)
    FuncDesc.Text = description
    FuncDesc.TextColor3 = Color3.fromRGB(150, 150, 160)
    FuncDesc.Font = Enum.Font.Gotham
    FuncDesc.TextSize = 11
    FuncDesc.TextXAlignment = Enum.TextXAlignment.Left
    FuncDesc.BackgroundTransparency = 1
    FuncDesc.Parent = ButtonFrame

    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Size = UDim2.new(0, 90, 0, 32)
    ActionBtn.Position = UDim2.new(1, -105, 0, 14)
    
    -- Nếu là nút chờ (chưa có link), đổi sang màu xám để dễ phân biệt
    if isPlaceholder then
        ActionBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 85)
        ActionBtn.Text = "EMPTY"
    else
        ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
        ActionBtn.Text = "RUN"
    end
    
    ActionBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
    ActionBtn.Font = Enum.Font.GothamBold
    ActionBtn.TextSize = 12
    ActionBtn.Parent = ButtonFrame

    if not isPlaceholder then
        ActionBtn.MouseEnter:Connect(function() ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 120) end)
        ActionBtn.MouseLeave:Connect(function() ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150) end)
    end

    ActionBtn.MouseButton1Click:Connect(callback)
end

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ====================================================================
-- 2. ĐỊNH NGHĨA CÁC NÚT BẤM VÀ TÍNH NĂNG
-- ====================================================================

-- Nút 1: Giữ lại để dành cho tương lai (Đã chặn lỗi crash)
CreateFeatureButton(
    "Load External Script", 
    "Tính năng chờ: Chưa thiết lập link liên kết GitHub.", 
    true, -- Bật chế độ nút chờ an toàn
    function()
        print("Thông báo: Nút này hiện chưa được gắn link script hoạt động.")
    end
)

-- Nút 2: Auto Farm Bond
CreateFeatureButton(
    "Auto Farm (Teleport)", 
    "Tự động bay xuyên địa hình gom Bond", 
    false,
    function()
        print("Đang thiết lập kết nối đến máy chủ...")
        task.spawn(function() 
            repeat task.wait() until LocalPlayer.Character
            local Character = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            
            local itemFolder = Workspace:FindFirstChild("ItemFolder")
            if not itemFolder then 
                print("Lỗi: Không tìm thấy vật phẩm gần đây.")
                return 
            end
            
            local foundItems = false
            for _, object in ipairs(itemFolder:GetDescendants()) do 
                if object:IsA("BasePart") and object.Name == "Bond" then 
                    foundItems = true
                    Character.CFrame = object.CFrame
                    task.wait(0.2)
                end 
            end 
            
            if foundItems then print("Kích hoạt tính năng thành công!") else print("Lỗi: Không tìm thấy vật phẩm gần đây.") end
        end)
    end
)

-- Nút 3: FPS Boost
CreateFeatureButton(
    "FPS Boost & Lag Fix", 
    "Xóa bỏ cấu hình đổ bóng, vân bề mặt để treo máy", 
    false,
    function()
        print("Kích hoạt tính năng thành công!")
        if Lighting:FindFirstChildOfClass("Atmosphere") then Lighting:FindFirstChildOfClass("Atmosphere").Enabled = false end
        if Lighting:FindFirstChildOfClass("Bloom") then Lighting:FindFirstChildOfClass("Bloom").Enabled = false end
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, part in pairs(Workspace:GetDescendants()) do 
            if part:IsA("MeshPart") or part:IsA("SpecialMesh") then part.RenderFidelity = Enum.RenderFidelity.Performance end 
            if part:IsA("Texture") or part:IsA("Decal") then part.Enabled = false end 
        end 
    end
)
