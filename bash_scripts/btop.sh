#!/usr/bin/env bash
sleep 2
kitty @ launch --type=window --cwd=current
sleep 0.1
kitty @ send-text "btop\n"
