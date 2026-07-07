## Dave's Dotfiles

Using [Gnu Stow](https://www.gnu.org/software/stow/_) for handling the dotfiles. This means all the files are contained in a `.dotfiles` folder in the home directory. Stow then creates symlinks to the files in the home directory, so they're picked up by the programs that use them.

## Quick start

(in the home directory)
`git clone git@github.com:GingaNinja/dotfiles.git .dotfiles`

and then for each 
