----------------
--- PROGRAMS ---
----------------
local terminal = "kitty"
local fileManager = "thunar"
local menu = "wofi -n"
local mainMod = "SUPER"

----------------
--- MONITORS ---
----------------
hl.monitor({
  output = "DP-3",
  mode = "2560x1440@165",
  position = "0x0",
  scale = 1,
  vrr = 3,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@60",
  position = "-1920x360",
  scale = 1,
})

-- Catch all
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})


-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

-- NVIDIA
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Toolkit / Wayland hints
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Cursor
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "12")

-- Terminal (used by some apps to spawn terminals)
hl.env("TERMINAL", "kitty")

-----------------
--- AUTOSTART ---
-----------------
hl.on("hyprland.start", function()
  hl.exec_cmd("hypridle")
  hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
  hl.exec_cmd("waybar")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("bash -c 'awww img $(cat ~/.cache/wal/wal)'")
  hl.exec_cmd("swaync")
  hl.exec_cmd("pypr")
  hl.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0")
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)


--------------------
---- CONFIG --------
--------------------
hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
  cursor = {
    no_hardware_cursors = true,
  },
  general = {
    gaps_in          = 2,
    gaps_out         = 10,
    border_size      = 0,
    -- border colors kept here in case you bump border_size later
    -- col_active_border   = walColors.color9,
    -- col_inactive_border = walColors.color5,
    resize_on_border = true,
    allow_tearing    = false,
    layout           = "dwindle",
  },
  decoration = {
    rounding         = 10,
    active_opacity   = 0.78,
    inactive_opacity = 0.70,
    blur             = {
      enabled           = true,
      size              = 3,
      passes            = 5,
      new_optimizations = true,
      ignore_opacity    = true,
      xray              = false,
      popups            = true,
    },
    shadow           = {
      enabled      = true,
      range        = 15,
      render_power = 5,
      color        = "rgba(0,0,0,.5)",
    },
  },
  dwindle = {
    preserve_split = true,
  },
  input = {
    kb_layout      = "us",
    follow_mouse   = 1,
    sensitivity    = 0.4,
    force_no_accel = true,
  },
  misc = {
    disable_hyprland_logo = true,
    focus_on_activate     = true,
  },
})
--------------------
---- BEZIERS -------
--------------------
hl.curve("fluid", { type = "bezier", points = { { 0.15, 0.85 }, { 0.25, 1 } } })
hl.curve("snappy", { type = "bezier", points = { { 0.3, 1 }, { 0.4, 1 } } })

--------------------
---- ANIMATIONS ----
--------------------
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "fluid", style = "popin 5%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "snappy" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "snappy" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.7, bezier = "snappy", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "fluid", style = "slidefadevert -35%" })
hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "snappy", style = "popin 70%" })

--------------------
---- LAYER RULES ---
--------------------
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "waybar" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })

--------------------
---- BINDS ---------
--------------------

-- Screenshots
hl.bind(mainMod .. " + Home", hl.dsp.exec_cmd("hyprshot -m region -o ~/Screenshots/"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m region -o ~/Screenshots/"))
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m window -o ~/Screenshots/"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("hyprshot -m active -m output -o ~/Screenshots/"))

-- Apps
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mainMod .. " + B", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Focus (full direction names required: left/right/up/down)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind("ALT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("ALT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("ALT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("ALT + down", hl.dsp.window.move({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- pypr scratchpads
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("pypr toggle music"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("pypr toggle taskbar"))

-- Wallpaper
--hl.bind("ALT + W", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/wallpaper.sh"))

-- Volume
hl.bind(mainMod .. " + EQUAL", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind(mainMod .. " + MINUS", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true })

-- Media keys
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Misc
hl.bind(mainMod .. " + l", hl.dsp.exec_cmd("~/.local/share/quickshell-lockscreen/lock.sh"))
-- Exit: prefer hyprshutdown if installed, fall back to hl.dsp.exit()
-- (wiki notes uwsm users should avoid exit() directly; this pattern is from the upstream example)
hl.bind(mainMod .. " + M",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind("ALT + TAB", hl.dsp.exec_cmd("wlogout -b 2"))
hl.bind("ALT + B", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/waybar/scripts/select.sh"))
hl.bind("ALT + r", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/swaync/refresh.sh"))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
