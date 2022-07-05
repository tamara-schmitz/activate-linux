% activate-linux(1) activate-linux 0.2
% MrGlockenspiel
% July 2022

# NAME
activate-linux - The "Activate Windows" watermark ported to Linux with cairo in C

# SYNOPSIS
**activate-linux** [*OPTION*]

# DESCRIPTION
**activate-linux** takes command line arguments for all customizable options. \
Scaling is used to display the message correctly on screens of different resolutions. 100% is based on 1080p. It also affects the offset from the corner of the screen so is not recommended to be changed unless you are not using a 1080p screen. \
Color is formatted in "r-g-b-a", with each number being a decimal from 0 to 1. Default is a light grey color.

# OPTIONS
**-h**
: Displays a friendly help message.

**-t** main-message
: Display a custom main message.

**-m** secondary-message
: Display a custom secondary message.

**-f** font
: Render text using a custom font.

**-b**
: Render text in a bold font.

**-i**
: Render text in an italic font.

**-c** r-g-b-a
: Render text in a custom colour with each being a floating point number from 0 to 1. Each colour component is separated by a dash.

**-x** width
: Set a custom overlay width in pixels.

**-y** height
: Set a custom overlay height in pixels.

**-s** scale
: Set a custom fractional scaling for the overlay. Default: 1.0

**-H** shift
: Shift the overlay horizontally by a positive or negative amount of pixels.

**-V** shift
: Shift the overlay vertically by a positive or negative amount of pixels.

**-w**
: Attempt to skip the desktop compositor.

**-d**
: Fork and run as a daemon.

**-v**
: Show verbose output including received X events.

# EXAMPLES
**activate-linux**
: Runs activate-linux without exiting back to shell. Can be exited using SIGTERM.

**activate-linux -d**
: Runs activate-linux and immediately returns to shell.

**activate-linux -c 0.5-0.2-0.2-0.6 -i**
: Runs activate-linux with a custom font colour and as italic.

**activate-linux -s 1.5 -H 15 -V -50**
: Runs activate-linux with a 1.5 scale shifted 15 pixels left and 50 pixels up.

# COPYRIGHT
Copyright © 2022 MrGlockenspiel.  License GPLv3: GNU GPL version 3 <https://gnu.org/licenses/gpl.html>.\
This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.

