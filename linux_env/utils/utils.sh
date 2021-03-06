#/bin/bash

set -o emacs

# npm
if which --skip-alias npm 2>/dev/null 1>/dev/null ; then
	alias cnpm="$(which --skip-alias npm) --registry=https://registry.npm.taobao.org \
		--cache=$HOME/.npm/.cache/cnpm \
		--disturl=https://npm.taobao.org/dist \
		--userconfig=$HOME/.cnpmrc"
fi

function enject_env() {
	gdb -batch -ex 'attach '$1 -ex 'call putenv ("'$2'")' -ex 'detach'; 
}


function tmux_renumber_windows() {
	local windows=$(tmux list-windows | awk -F: '{print $1}')
	local i=0
	local n
	for n in $windows 
	do
		if [ "$n" -ne "$i" ]
		then
			tmux move-window -s $n -t $i
		fi
		i=$((i+1))
	done
}

