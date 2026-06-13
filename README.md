# Window

A lightweight Luau UI library for Roblox executors. Built on the **heaven.lol** visual style — dark semi-transparent window, green accents, Gotham font, rounded corners.

---

## Loading

```lua
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/notrealtze/the-rake-UI-library/refs/heads/main/Window.lua"))()
```

---

## Creating a Window

```lua
local win = Window.new("My Script")
```

`Window.new(title: string)` creates and renders the GUI immediately. The **X** button in the top-right collapses and expands the window at runtime.

---

## Components

### Toggle

```lua
local toggle = win:AddToggle(label, default, callback)
```

| Parameter  | Type       | Description                              |
|------------|------------|------------------------------------------|
| `label`    | `string`   | Text shown on the left side of the row   |
| `default`  | `boolean`  | Initial state (`true` = ON)              |
| `callback` | `function` | Called with `(state: boolean)` on change |

**Returns** a controller table:

```lua
toggle.GetState()      -- returns current boolean
toggle.SetState(bool)  -- sets state and fires callback
```

**Example:**

```lua
local motionBlur = win:AddToggle("MOTION BLUR", true, function(state)
    print("Motion Blur:", state)
end)
```

---

### Button

```lua
win:AddButton(label, callback)
```

| Parameter  | Type       | Description              |
|------------|------------|--------------------------|
| `label`    | `string`   | Text shown on the left   |
| `callback` | `function` | Called with no arguments |

**Example:**

```lua
win:AddButton("TELEPORT HOME", function()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
end)
```

---

### TextBox

```lua
local box = win:AddTextBox(label, placeholder, callback)
```

| Parameter     | Type       | Description                                        |
|---------------|------------|----------------------------------------------------|
| `label`       | `string`   | Text shown on the left side                        |
| `placeholder` | `string`   | Grey hint text shown when the box is empty         |
| `callback`    | `function` | Called with `(text: string)` when Enter is pressed |

**Returns** a controller table:

```lua
box.GetText()      -- returns current string
box.SetText(str)   -- sets the TextBox value
```

**Example:**

```lua
local walkInput = win:AddTextBox("WALK SPEED", "16", function(value)
    local speed = tonumber(value)
    if speed then
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end)
```

---

### Label

```lua
win:AddLabel(text)
```

A read-only text row — useful for section headers or status messages.

**Example:**

```lua
win:AddLabel("-- MOVEMENT --")
```

---

## Utility Methods

```lua
win:SetVisible(bool)  -- show or hide the entire GUI
win:Destroy()         -- remove the GUI entirely
```

---

## Full Example Script

```lua
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/notrealtze/the-rake-UI-library/refs/heads/main/Window.lua"))()

local win = Window.new("heaven.lol")

win:AddLabel("-- VISUALS --")

win:AddToggle("MOTION BLUR", false, function(state)
    -- motion blur logic
end)

win:AddLabel("-- MOVEMENT --")

win:AddToggle("SPEEDY BOOTS", false, function(state)
    local humanoid = game:GetService("Players").LocalPlayer.Character
        and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = state and 50 or 16
    end
end)

win:AddTextBox("WALK SPEED", "16", function(value)
    local speed = tonumber(value)
    local humanoid = game:GetService("Players").LocalPlayer.Character
        and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if speed and humanoid then
        humanoid.WalkSpeed = speed
    end
end)

win:AddButton("RESET CHARACTER", function()
    game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 0
end)
```

---

## Notes

- All components use `LayoutOrder` internally — do not assign it manually to child instances.
- `Window.new` parents the ScreenGui to `CoreGui` via `syn.protect_gui` if available, then `gethui()`, then raw `CoreGui` as a final fallback. The ScreenGui is assigned a randomised name using Unicode private-use area characters to prevent detection via `FindFirstChild`.
- The **X** / **+** toggle in the window header is always present and cannot be removed.
- `TextBox` callback fires only on **Enter** (`FocusLost` with `enterPressed = true`). Blurring without pressing Enter does not trigger it.

