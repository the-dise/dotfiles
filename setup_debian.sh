#!/bin/bash

sudo apt install curl zsh git htop tmux vim 

[[ ! $SHELL =~ "zsh" ]] && chsh -s `which zsh`