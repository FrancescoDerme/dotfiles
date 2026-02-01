## Vanilla

### Settings

- The leader is spacebar
- `&` is `^` for concordance with american keyboards
- Arrow keys are deactivated

### Normal mode

- `:` enter command mode
- `h`, `j`, `k`, `l` the basic movement keys, to be chained with numbers
- `zz` center the view
- `w` and `W`, `b` and `B`, `e` and `E` move to the next word, the previous word or the end of the next word. The upper case variants ignore every delimiter that isn't whitespace. Also to be chained with numbers
- `^` and `$` move to the first non-whitespace character and last character of a line
- `f` and `F`, `t` and `T` jump to the next occurrence of a character or right beore it, with uppercase variants going backwards
- `%` go the the "partner" of the current character, e.g. the partner parenthesis
- `ctrl + o` and `ctrl + i` jump in the jumplist
- `g;` and `g,` jump to older or newer positions the changelist
- `/` and `?` search forward and backward. `n` and `N` jump to next and previous occurrences, `ctrl+l` to clears the highlighted search terms
- `H`, `M`, `L` top, mid and bottom of the current viewport
- `{` and `}` go to next and previous paragraphs
- `gg` and `G` go to first and last line of a buffer
- `alt + direction` switch focus among open buffers
- `u` undo
- `ctrl + r` redo
- `ctrl + u` and `ctrl + d` scroll up and down (not a recommended way to move in a buffer)
- `<Tab>` manage tabs and splits
- `p` paste, `"0p` paste from register 0
- `cc` delete the contents of the current line without removing the line itself and enter insert mode
- `d` delete
- `D` delete from cursor to end of line
- `y` yoink

### Command mode

- `w` write a buffer
- `q` quit a buffer
- `5` go to line 5
- `a` reference every buffer
- `!` apply the command with force
- `%` apply the command to the whole buffer
- `-` reference the system clipboard instead of neovim's internal one
- `term` open a terminal window inside neovim

### Visual and visual block modes

- `ctrl + v` enter visual block mode
- `g + ctrl + a` add 1 to the highlighted text. If several lines are highlighted, each will be incermented by an additional unit

## Plugins

### Autopairs

Automatically closes pairs of caracthers like parenthesis, type the closing character to move outside.

### Competitest

Compiling, running against testcases and downloading problems or contests.

- `<leader>ca` add testcase
- `<leader>ce` edit testcase
- `<leader>cr` run testcases
- `<leader>cs` show competitest ui
- `<leader>crt` receive testcases
- `<leader>crp` receive problem (source file is automatically created along with testcases)
- `<leader>crc` receive contest (make sure to be on the homepage of the contest, not of a single problem)

Inside competitest's ui:

- `R` run again the selected testcase
- `ctrl + r` run again all testcases
- `K` kill the process associated with a testcase
- `ctrl + k` kill all the processes associated with testcases
- `i` or `I` view input in a bigger window
- `a` or `A` view expected output in a bigger window
- `o` or `O` view stdout in a bigger window
- `e` or `E` view stderr in a bigger window
- `d` or `D` toggle diff view between actual and expected output

### Lualine

Status bar.

### Neotree

File tree.

- `<leader>e` toggle filetree to the left
- `a` or `A` to create a new file or directory from within the filetree
- `s` to open a file in split view
- `r` to rename a file

### Telescope

Search files and in files.

- `<leader>ff` find files in the current directory
- `<leader>fd` find in files
- `<leader>fb` find in the current buffer

### Tokyonight

Color theme.

### Treesitter

Syntax highlighting.

- `ctrl + space` select the next node or increment selection
- `backspace` decrement selection

### Whichkey

Show possible ways to complete commands that one has started typing.

### Oil

File explorer that allows editing the filesystem like a normal vim buffer. To open a directory from command line use `nvim .`, then `enter` to open a file/directory or `-` to go up a directory. Write the buffer to apply.

- `<leader>oe` or `:Oil` open the oil file explorer in the current directory
- `<leader>of` or `:Oil --float` open the oil file explorer in a floting window in the current directory

### Flash

Navigate code with search labels.

- `s` activate flash to jump around
- `S` activate flash + treesitter to select portions of text quickly
  `s` and `S` work in normal, visual and operator pending mode.

`/` and `?` are enhanced with jump labels. `f`, `F`, `t` and `T` motions allow searching a single caracther, then one can repeat the motion with `f`, `t`, or go to the previous match with `F`, `T`. Any highlights clear automatically when moving, changing buffers or pressing `esc`.

### Treesitter-textobjects

Syntax-aware select, move, and swap.

- `<leader>snp` swap next parameters
- `<leader>snd` swap next function definitions
- `<leader>spp` swap previous parameters
- `<leader>spd` swap previous function definitions

Type `]` to go to the next occurrence of a text-object, `[` to go to the previous one, the next caracther specifies which text-object to look for. Type `v` (visual), `d` (delete), `c` (change) or `y` (yoink) to start a command that interacts with a certain portion of text, the next caracther specifies wether to select the inner or the outer part of a text-object, the last caracther specifies what text-object to select.

### Code-runner

Run code.

- `<leader>r` run code

### Mason

Packet manager for LSP servers, linters and formatters.

- `:Mason` open the Mason UI

### Conform

Formatting.

- `<leader>p` make pretty

### Demicolon

Makes comma and semiclon uniformely repat moves across plugins.

## Notes

### To do

Update docs with the new plugins and the new hotkeys (for example the lsp setup is poorely documented as of now)
Make / and ? repetable with ; and , instead of n and N, then update docs for ? and /

### Not-to-do

There is no smooth scrolling plugin since one shouldn't scroll to move.
There is no bufferline since one shouldn't think about buffers as they're just caches and use splits and tabs instead.
There is no tabline since one shouldn't move through tabs by selecting them.

### Intresting plugins to check out

Grug-far.nvim (find and replace)
harpoon (switch quickly between buffers)
aerial.nvim (outline window)
persistence.nvim (save sessions)
snacks.nvim (a lot of stuff, among these there are debug utilities, git utilities)
todo-comments.nvim (use comments as anchors)
trouble (list of diagnostics)
gitsigns (buffer integration for git)
