# cpprunner.nvim

A lightweight, asynchronous C++ compiler and runner for Neovim. Inspired by classic IDE workflows (like Dev-C++), `cpprunner.nvim` lets you instantly compile and execute C++ source files with a single keybinding, displaying output inside an interactive Neovim terminal split with zero UI lag.

---

## Features

* **Asynchronous Compilation:** Leverages `vim.fn.jobstart` to compile in the background without blocking the Neovim editor interface.
* **Interactive Terminal Input:** Opens binaries in a Neovim `:terminal` buffer and enters Insert mode automatically, seamlessly handling `std::cin` inputs.
* **Smart Window Management:** Automatically closes previous execution splits to keep your workspace clean on repeat runs.
* **Cross-Platform:** Out-of-the-box support for Linux, macOS, and Windows binary extensions.
* **Highly Configurable:** Easily adjust compiler flags, standard targets, split window height, and shortcut bindings.

---

## Installation

Install using your preferred Neovim package manager.

### Using [`lazy.nvim`](https://github.com/folke/lazy.nvim)

```lua
{
  "chupacker/cpprunner.nvim",
  ft = { "cpp", "c" }, -- Lazy-load on C/C++ filetypes
  opts = {
    keymap = "<F11>",
    compiler = "g++",
    std = "c++17",
    extra_flags = "-Wall",
    split_height = 15,
  },
}
```

### Using Neovim Native Package Manager (`vim.pack`)

```lua
vim.pack.add({
  url = "https://github.com/chupacker/cpprunner.nvim",
})

require("cpprunner").setup({
  keymap = "<F11>",
})
```

### Using [`packer.nvim`](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "chupacker/cpprunner.nvim",
  config = function()
    require("cpprunner").setup()
  end
}
```

---

## Configuration

Call `require("cpprunner").setup(opts)` in your config. Below are the available configuration options along with their default values:

```lua
require("cpprunner").setup({
  -- Keymap to trigger compilation and execution (set to nil or false to disable)
  keymap = "<F11>",

  -- C++ compiler executable
  compiler = "g++",

  -- Target C++ standard flag
  std = "c++17",

  -- Additional flags passed directly to the compiler
  extra_flags = "-Wall",

  -- Height of the bottom split window running the interactive terminal
  split_height = 15,
})
```

---

## Usage

### Keybindings & Commands

* **`<F11>`** (Default): Saves the current file, compiles it asynchronously, and runs the output binary in a bottom terminal split.
* **`:CppRunner`**: Exists as a Neovim user command to trigger compilation and execution manually via the command line.

---

## License

MIT
