local startTick = tick()

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/cueshut/saves/main/octohook%20ui%20lib"))({cheatname = "", gamename = ""})
library:init()

local menu = library.NewWindow({title = "Omega Hub"..", ".."Rushpoint", size = UDim2.new(0, 500, 0.7, 20.7)})

---Tabs
local HomeTab = menu:AddTab("Combat")

local AimingTab = menu:AddTab("Visuals")

local BlantantTab = menu:AddTab("Miscellaneous")

local VisualsTab = menu:AddTab("Settings")

local SettingsTab = library:CreateSettingsTab(menu)

---Sections
local MiscellaneousTab = MiscellaneousTab:AddSection("Test", 1)

local MiscellaneousTab2 = MiscellaneousTab:AddSection("Test", 2)

---Separators
local Test = MiscellaneousTab:AddSection("Section", 2)

MiscellaneousTab:AddSeparator({text = "Separator"})

MiscellaneousTab:AddBox({text = "Box", flag = ""})

---Functions
MiscellaneousTab:AddToggle(
   {
       text = "Toggle",
       flag = "",
       callback = function(bool)
           if bool then
               print("Toggle")
           else
               print("Untoggle")
           end
       end
   }
)

MiscellaneousTab:AddButton(
   {
       text = "Button",
       confirm = false,
       callback = function()
           Print("Button")
       end
   }
)

MiscellaneousTab:AddBind(
   {
       text = "Keybind",
       flag = "",
       nomouse = true,
       noindicator = true,
       bind = Enum.KeyCode.BackSlash,
       callback = function()
           Print("666")
       end
   }
)

MiscellaneousTab:AddButton(
   {
       text = "Notification Sucess",
       callback = function()
           if res.Success then
               library:SendNotification(library.cheatname .. " | asss", 3)
           end
       end
   }
)

MiscellaneousTab:AddButton(
   {
       text = "Notification Error",
       callback = function()
           if res.Error then
               library:SendNotification(library.cheatname .. " | ass!", 3)
           end
       end
   }
)

MiscellaneousTab:AddSlider({text = " Slider", flag = '"', suffix = "%", min = 0, max = 100, increment = .1})

MiscellaneousTab:AddColor(
   {
       text = "Color",
       flag = "",
       callback = function()
       end
   }
)

MiscellaneousTab:AddList(
   {
       text = "List",
       flag = "",
       values = themeStrings,
       callback = function()
       end
   }
)
-- Watermark
do
    if not IonHub_User then
        getgenv().IonHub_User = {
            UID = 0, 
            User = "admin"
        }
    end
    self.watermark = {
        objects = {};
        text = {
            {self.cheatname, true},
            {("%s (uid %s)"):format(IonHub_User.User, tostring(IonHub_User.UID)), false},
            {self.gamename, true},
            {'0 fps', true},
            {'0ms', true},
            {'00:00:00', true},
            {'M, D, Y', true},
        };
        lock = 'custom';
        position = newUDim2(0,0,0,0);
        refreshrate = 25;
    }

    function self.watermark:Update()
        self.objects.background.Visible = library.flags.watermark_enabled
        if library.flags.watermark_enabled then
            local date = {os.date('%b',os.time()), os.date('%d',os.time()), os.date('%Y',os.time())}
            local daySuffix = math.floor(date[2]%10)
            date[2] = date[2]..(daySuffix == 1 and 'st' or daySuffix == 2 and 'nd' or daySuffix == 3 and 'rd' or 'th')

            self.text[4][1] = library.stats.fps..' fps'
            self.text[5][1] = floor(library.stats.ping)..'ms'
            self.text[6][1] = os.date('%X', os.time())
            self.text[7][1] = table.concat(date, ', ')

            local text = {};
            for _,v in next, self.text do
                if v[2] then
                    table.insert(text, v[1]);
                end
            end

            self.objects.text.Text = table.concat(text,' | ')
            self.objects.background.Size = newUDim2(0, self.objects.text.TextBounds.X + 10, 0, 17)

            local size = self.objects.background.Object.Size;
            local screensize = workspace.CurrentCamera.ViewportSize;

            self.position = (
                self.lock == 'Top Right' and newUDim2(0, screensize.X - size.X - 15, 0, 15) or
                self.lock == 'Top Left' and newUDim2(0, 15, 0, 15) or
                self.lock == 'Bottom Right' and newUDim2(0, screensize.X - size.X - 15, 0, screensize.Y - size.Y - 15) or
                self.lock == 'Bottom Left' and newUDim2(0, 15, 0, screensize.Y - size.Y - 15) or
                self.lock == 'Top' and newUDim2(0, screensize.X / 2 - size.X / 2, 0, 15) or
                newUDim2(library.flags.watermark_x / 100, 0, library.flags.watermark_y / 100, 0)
            )

            self.objects.background.Position = self.position
        end
    end

    do
        local objs = self.watermark.objects;
        local z = self.zindexOrder.watermark;
        
        objs.background = utility:Draw('Square', {
            Visible = false;
            Size = newUDim2(0, 200, 0, 17);
            Position = newUDim2(0,800,0,100);
            ThemeColor = 'Background';
            ZIndex = z;
        })

        objs.border1 = utility:Draw('Square', {
            Size = newUDim2(1,2,1,2);
            Position = newUDim2(0,-1,0,-1);
            ThemeColor = 'Border 2';
            Parent = objs.background;
            ZIndex = z-1;
        })

        objs.border2 = utility:Draw('Square', {
            Size = newUDim2(1,2,1,2);
            Position = newUDim2(0,-1,0,-1);
            ThemeColor = 'Border 3';
            Parent = objs.border1;
            ZIndex = z-2;
        })
        
        objs.topbar = utility:Draw('Square', {
            Size = newUDim2(1,0,0,1);
            ThemeColor = 'Accent';
            ZIndex = z+1;
            Parent = objs.background;
        })

        objs.text = utility:Draw('Text', {
            Position = newUDim2(.5,0,0,2);
            ThemeColor = 'Primary Text';
            Text = 'Watermark Text';
            Size = 13;
            Font = 2;
            ZIndex = z+1;
            Outline = true;
            Center = true;
            Parent = objs.background;
        })

    end
end

local lasttick = tick();
utility:Connection(runservice.RenderStepped, function(step)
    library.stats.fps = floor(1/step)
    library.stats.ping = stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    library.stats.sendkbps = stats.DataSendKbps
    library.stats.receivekbps = stats.DataReceiveKbps

    if (tick()-lasttick)*1000 > library.watermark.refreshrate then
        lasttick = tick()
        library.watermark:Update()
    end
end)
