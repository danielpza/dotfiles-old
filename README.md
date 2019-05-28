# My Dotfiles

## Installing components

Select one of [i3, *dwm*, bspwm]

Change the .stowrc target field then run:

``` sh
# stow [component]
stow base
stow dwm
```

## Installing [emacs doom](https://github.com/hlissner/doom-emacs)

- install emacs
- install emacs doom (`git clone https://github.com/hlissner/doom-emacs ~/.emacs.d`)
- install doom component (`stow doom`)
- do `.emacs.d/bin/doom refresh` (or `install`)

## Installing [dwm](https://dwm.suckless.org/)

``` sh
git clone https://github.com/danielpza/dwm.git
cd dwm
sudo make install
```

Then modify your .xinitrc or .xsession or an entry should appear in your session manager

### Installing [slstatus](https://tools.suckless.org/slstatus/)

```sh
git clone https://git.suckless.org/slstatus
# ... same as building dwm
```
