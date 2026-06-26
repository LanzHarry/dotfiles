-- initialise pack changed checks before any plugins are required
require("core.pack_changed")

-- plugins that other plugins depend on
require("plugins.git_plugins") -- first to give git deps to mini plugins like statusline
require("plugins.mini") -- second to give icons (mock web devicons) to plugins like telescope

-- other plugins do not need synchronous requirements
require("plugins.colourscheme")
require("plugins.completion")
require("plugins.format")
require("plugins.lint")
require("plugins.lsp_config")
require("plugins.telescope")
require("plugins.treesitter")
