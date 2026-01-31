1. The leader is spacebar.
2. '&' is '^' for concordance with american keyboards.
3. Arrow keys are deactivated.

NORMAL MODE

1.  : -> enter command mode.
1.  h, j, k, l: the basic movement keys, to be chained with numbers
1.  zz -> center the view.
1.  w and W, b and B, e and E: move to the next word, the previous word or the end of the next word.
    The upper case variants ignore every delimiter that isn't whitespace. Also to be chained with numbers.
1.  ^ and $: move to the first non-whitespace character and last character of a line.
1.  f and F, t and T: jump to the next occurrence of a character or right beore it, with uppercase variants going backwards.
1.  %: go the the "partner" of the current character, e.g. the partner parenthesis.
1.  ctrl + o and ctrl + i: jump in the jumplist.
1.  g; and g,: jump to older or newer positions the changelist.
1.  / and ?: search forward and backward. n and N jump to next and previous occurrences, ctrl+l to clears the highlighted search terms.
1.  H, M, L: top, mid and bottom of the current viewport.
1.  { and }: next and previous paragraphs.
1.  gg and G: first and last line of a buffer.
1.  alt + direction: switch focus among open buffers.
1.  u: undo
1.  ctrl + r: redo
1.  ctrl + u / ctrl + d: scroll up and down (not a recommended way to move around a buffer).
1.  <Tab>: manage tabs and splits, gt -> goto next tab,
1.  p, "0p:paste, paste from register 0.
1.  cc -> delete the contents of the current line without removing the line itself and enter insert mode.
1.  d -> delete.
1.  D -> delete from cursor to end of line.
1.  y -> yoink.

COMMAND MODE
Every command is prefixed by ':'.

1.  w -> write a buffer.
2.  q -> quit a buffer.
3.  5 -> go to line 5.
4.  a -> reference every buffer.
5.  ! -> apply the command with force.
6.  % -> apply the command to the whole buffer.
7.  - -> reference the system clipboard instead of neovim's internal one.
8.  term -> open a terminal window inside neovim.

VISUAL AND VISUAL BLOCK MODE

1.  ctrl + v: enter visual block mode.
2.  g + ctrl + a: add 1 to the highlighted text. If several lines are highlighted, each will be incermented by an additional unit.

PLUGINS

1.  Autopairs: automatically closes pairs of caracthers like parenthesis, type the closing character to move outside.
2.  Competitest: compiling, running against testcases and downloading problems or contests.
    <leder>ca: add testcase,
    <leader>ce: edit testcase,
    <leader>cr: run testcases,
    <leader>cs: show competitest ui,
    <leader>crt: receive testcases,
    <leader>crp: receive problem (source file is automatically created along with testcases),
    <leader>crc: receive contest (make sure to be on the homepage of the contest, not of a single problem).
    Inside competitest's ui:
    R: run again the selected testcase,
    ctrl + r: run again all testcases,
    K: kill the process associated with a testcase,
    ctrl + k: kill all the processes associated with testcases,
    i or I: view input in a bigger window,
    a or A: view expected output in a bigger window,
    o or O: view stdout in a bigger window,
    e or E: view stderr in a bigger window,
    d or D: toggle diff view between actual and expected output.
3.  Lualine: status bar.
4.  Neotree: file tree.
    <leader>e: toggle filetree to the left.
    a or A to create a new file or directory from within the filetree.
    s to open a file in split view.
    r to rename a file.
5.  Telescope: search files and in files.
    <leader>ff: find files in the current directory,
    <leader>fd: find in files,
    <leader>fb: find in the current buffer.
6.  Tokyonight: color theme.
7.  Treesitter: syntax highlighting.
    ctrl + space: select the next node or increment selection,
    backspace: decrement selection.
8.  Whichkey: show possible ways to complete commands that one has started typing.
9.  Oil: file explorer that allow editing the filesystem like a normal vim buffer.
    To open a directory from command line use "nvim .", then enter to open a file/directory or - to go up a directory.
    :w to actually perform the actions.
    <leader>oe: open the oil file explorer in the current directory,
    <leader>of: open the oil file explorer in a floting window in the current directory,
    :Oil: open the oil file explorer,
    :Oil --float: open the oil file explorer in a floating window.
10. Flash: navigate code with search labels.
    s: activate flash to jump around.
    S: activate flash + treesitter to select portions of text quickly.
    s and S work in normal, visual and operator pending mode.
    / and ? are enhanced with jump labels.
    f, F, t and T motions allow searching a single caracther, then one can repeat the motion with f, t, or go to the previous match with F, T.
    Any highlights clear automatically when moving, changing buffers or pressing esc.
11. Treesitter-textobjects: syntax-aware select, move, and swap.
    <leader>snp: swap next parameters,
    <leader>snd: swap next function definitions,
    <leader>spp: swap previous parameters,
    <leader>spd: swap previous function definitions.
    Type ] to go to the next occurrence of a text-object, [ to go to the previous one, the next caracther specifies which text-object to look for.
    Type v (visual), d (delete), c (change) or y (yoink) to start a command that interacts with a certain portion of text, the next caracther specifies wether to select the inner or the outer part of a text-object, the last caracther specifies what text-object to select.
12. Code-runner: run code and manage projects.
    <leader>r: run code.
13. Mason: packet manager for LSP servers, linters and formatters.
    cmake -S . -G "Unix Makefiles" -B cmake
    :Mason: open the Mason UI.
14. Conform: formatting.
    <leader>p: make pretty.
15. Nvim-lint: linting.
16. Demicolon: make comma and semiclon uniformely repat moves across plugins.
17. grug-far.nvim; find and replace!
    Still needs to be set up :(

TODO
Get Code-runner to work -> update docs
Make / and ? repetable with ; and , instead of n and N -> change docs for ? and / and potentially change docs for flash
Make , and ; work both for treesitter textobjects and flash (maybe use demicolon) -> change docs for both flash and ,/;, maybe also demicolon
Integrate flash in treesitter -> change docs for flash

NOTES ON PLUGINS
There is no smooth scrolling plugin since one shouldn't scroll to move.
There is no bufferline since one shouldn't think about buffers as they're just caches and use splits and tabs instead.
There is no tabline since one shouldn't move through buffers by selecting them.

INTRESTING PLUGINS TO CHECK OUT
harpoon (switch quickly between buffer)
aerial.nvim (outline window)
persistence.nvim (save sessions)
snacks.nvim (a lot of stuff, among these there are debug utilities, git utilities)
mason-lspconfig.nvim + nvim-lspconfig (autocomplete!)
todo-comments.nvim (use comments as anchors)
trouble (list of diagnostics)
gitsigns (buffer integration for git)
