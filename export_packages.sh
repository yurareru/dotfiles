#!/usr/bin/env bash

pacman -Qneq > pacman.list && echo "Saved: pacman.list"
pacman -Qmeq > aur.list && echo "Saved: aur.list"

