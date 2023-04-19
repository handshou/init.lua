# init.lua for NVIM

Prereq: Install `ripgrep`

## Commands

C-e : Harpoon 

C-w : Window cmds HJKL left/bottom/top/right S split-hor V split-vert W switch Q quit 

LDR (leader) : space 

LDR-u : undo tree 

LDR-pv : netrw 

LDR-pf : project files 

LDR-ps : search files 

LDR-gs : GIT STATUS 

LDR-s : search and replace word under cursor 

LDR-x : executable chmod +x and run file 

LDR-f : format 

LDR LDR : so / source 

LDR-zz : zen-mode

LDR-zZ : super-zen-mode

C-p : git search files 

---

C-f : find project file (not working, check if tmux install missing?) 

C-a-L : return to previous place 

## Fugitive menu

LDR-p : push

LDR-P : pull —rebase

LDR-t : push -u origin

## Netrw menu
 
d to create directory 

% to create new file 

D to delete 
 
## In command mode 
 
:Ex explorer pane 

:lua ColorMyPencils() 

:PackerSync 

:ls list all buffers 

:so reload source 

:TSPlaygroundToggle AST inside editor from treesitter 

## Generic Vim 

C-a-1 : increment 1 after cursor 

C-x-1 : decrement 1 after cursor 

---

1-j : move cursor 1 row down 

1-k : move cursor 1 row up 

