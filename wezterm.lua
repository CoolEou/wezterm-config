-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
-- Window size(measured in characters):
config.initial_cols = 122
config.initial_rows = 27

-- Font:
config.font = wezterm.font("JetBrainsMono NFM")
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 11
config.line_height = 1

-- Tab bar:
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 1
-- config.use_fancy_tab_bar = false
-- config.enable_tab_bar = false 

config.window_frame = {
    -- The font used in the tab bar.
    font = wezterm.font { family = 'JetBrainsMono NFM', weight = 'Bold' },
    -- The size of the font in the tab bar.
    font_size = 12.5,
  }

wezterm.on("format-tab-title", function(tab)
    local title = tab.active_pane.title
    local max = 19
    local min = max

    if #title > max then
        title = title:sub(1, max - 1) .. "…"
    end
    
    if #title < min then
        title = title .. string.rep(" ", min - #title)
    end

    return {
        { Text = " " .. title .. " " }
    }
end)

-- Colors:
-- config.color_scheme = 'Aci (Gogh)'
-- config.color_scheme = 'Arthur'
config.color_scheme = 'Catppuccin Mocha'

config.colors = {
    -- the background color of selected text
    selection_bg = "rgba(250, 179, 135, 0.95)",

    tab_bar = {
        background = "#11111b",
    
        active_tab = {
            bg_color = "#1e1e2e",
            fg_color = "#fab387",
        },
    
        inactive_tab = {
            bg_color = "#313244",
            fg_color = "#fab387",
        },
    
        inactive_tab_hover = {
            bg_color = "#181825",
            fg_color = "#fab387",
        },
    
        new_tab = {
            bg_color = "#313244",
            fg_color = "#fab387",
        },
    
        new_tab_hover = {
            bg_color = "#181825",
            fg_color = "#fab387",
        },
    },
}

config.integrated_title_button_color = "#fab387"
config.integrated_title_button_style = "Gnome"

-- Domains
config.exec_domains = {
    wezterm.exec_domain(
        "Powershell",   -- domain name
        function(cmd)             -- fixup function
            cmd.args = { 'powershell.exe', '-NoLogo' }
            return cmd
        end
    ),
    wezterm.exec_domain(
        "Command Promt",   -- domain name
        function(cmd)             -- fixup function
            cmd.args = { 'cmd.exe', '-NoLogo' }
            return cmd
        end
    ),
}

config.wsl_domains = {
    {
      name = "WSL:Bash",
      distribution = "Ubuntu", -- Replace with your actual WSL distro name
      default_cwd = "~",
      default_prog = { "bash", "-l" },
    },
    {
      name = "WSL:Zsh",
      distribution = "Ubuntu",
      default_cwd = "~",
      default_prog = { "zsh", "-l" },
    },
}

-- Key Binds:
config.keys = {
    {
        -- Choose and open new tab
        key = "d",
        mods = "CTRL",
        action = wezterm.action.ShowLauncherArgs {
            flags = "DOMAINS",
        },
    },
    {
        -- Open a new Powershell tab
        key = "1",
        mods = "CTRL|ALT",
        action = wezterm.action.SpawnTab { DomainName = "Powershell", },
    },
    {
        -- Open a new Command Promt tab
        key = "2",
        mods = "CTRL|ALT",
        action = wezterm.action.SpawnTab { DomainName = "Command Promt", },
    },
    {
        -- Open a new WSL:Ubuntu tab
        key = "3",
        mods = "CTRL|ALT",
        action = wezterm.action.SpawnTab { DomainName = "WSL:Ubuntu", },
    },
    {
        -- Copy
        key = 'c',
        mods = 'CTRL',
        action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
    },
    {
        -- Paste
        key = "v",
        mods = "CTRL",
        action = wezterm.action.PasteFrom 'Clipboard',
    },
}

-- Misc:
-- config.default_domain = 'Powershell'
config.default_domain = 'WSL:Zsh'
config.enable_scroll_bar = true

-- Finally, return the configuration to wezterm:
return config