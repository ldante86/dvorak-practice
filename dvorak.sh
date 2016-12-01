#!/bin/bash -
#
# SCRIPT: dvorak.sh
# AUTHOR: Luciano D. Cecere
# DATE: 12/01/2016-02:14:20 AM
########################################################################
#
# dvorak.sh - Practice typing on the Dvorak keyboard.
# Copyright (C) 2016 Luciano D. Cecere <ldante86@aol.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
########################################################################

PROGRAM="${0##*/}"

keyboard="\
QlpoOTFBWSZTWaciU8wAAIT/gH0QAQBQh//vP////ioFXAUwANqBzTGpggaYCA9IaNMDQamTyage
oc0xMBGmBGEYAAAAmEYCQqnpE0aANANAADQAaYmRmpoXATM9xhpsKUQnFQZ954qhgJsSG0Zcn0ia
gQAy67WKAn2bd2/hxDCaE+FAhmqEXyMlhbRVjJfeYpcMmPLfL7wLB6pKNCXjSPH+WLOKqxaYCwiV
qAlkqgi20wQ2NsTdQCYJtJRIabQ5AUYlNFisIUkYQhCgBRoAuswYT9Nt5qFeIrrLebaNnNQz3Ygb
BWWiNAtxkraJ/i7kinChIU5Ep5g="

usage="
$PROGRAM [-h] [-x]
	-h show this help
	-x don't show the keyboard
"

qwerty_upper=(
	Q W E R T Y U I O P \{ \} \|
	A S D F G H J K L : \"
	Z X C V B N M \< \> ?
)

qwerty_lower=(
	q w e r t y u i o p \[ \] \\
	a s d f g h j k l \; \'
	z x c v b n m , . /
)

dvorak_upper=(
	\" \< \> P Y F G C R L ? + \|
	A O E U I D H T N S _
	: Q J K X B M W V Z
)

dvorak_lower=(
	\' , . p y f g c r l / = \\
	a o e u i d h t n s -
	\; q j k x b m w v z
)

_print_keyboard()
{
	echo "$keyboard" | base64 -d | bzcat
}

_get_key()
{
	if [ -z "$1" ]; then
		echo -n " "
		return
	fi

	for ((i=0; i<${#qwerty_lower[@]}; i++))
	do
		if [ "$1" = "${qwerty_lower[i]}" ]; then
			echo -n "${dvorak_lower[i]}"
			return
		fi
	done

	for ((i=0; i<${#qwerty_upper[@]}; i++))
	do
		if [ "$1" = "${qwerty_upper[i]}" ]; then
			echo -n "${dvorak_upper[i]}"
			return
		fi
	done

	# non-charted characters pass through.
	echo -n "$1"
}

case "$1" in
	'')
		true
		;;
	-x)
		_print_keyboard() { :; }
		;;
	-h|*)
		echo "$usage"
		_print_keyboard
		exit
		;;
esac

clear

_print_keyboard
echo
echo -n ": "

while read -srn1 char
do
	_get_key "$char"
done
