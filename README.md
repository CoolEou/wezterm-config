# wezterm-config
For installation on windows, simply clone this repo to 
Users/{username}/.config/wezterm/

Also remember to install the JetBrainsMono NFM font: 
Download link: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
Nerd-font site: https://www.nerdfonts.com/

By default the default_domain is WSL:Zsh, so the terminal won't open if Zsh is not installed in WSL. To fix this, simply change the default_domain to e.g. WSL:Bash or powershell by commenting out the config.default_domain = 'WSL:Zsh' line and uncomment the preferred default domain.