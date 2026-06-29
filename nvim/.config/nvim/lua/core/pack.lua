-- initialise pack changed checks before any plugins are required
require("core.pack_changed")

-- plugins that other plugins depend on
require("plugins.treesitter") -- treesitter provides features to other plugins for AST/CST text analysis
require("plugins.git_plugins") -- for git integration into other plugins
require("plugins.mini") -- for icons (mock web devicons) provision to plugins like telescope

-- other plugins do not need synchronous requirements
require("plugins.colourscheme")
require("plugins.completion")
require("plugins.format")
require("plugins.lint")
require("plugins.lsp_config")
require("plugins.misc")
require("plugins.telescope")
