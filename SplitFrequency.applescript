#!/usr/bin/osascript

on convert_args(argv)
	set args to ""
	repeat with i in argv
		set p to POSIX path of i
		set args to args & " " & quoted form of p
	end repeat
	return args
end convert_args

on exec(args)
	do shell script "
	export PATH=$HOME/bin:/usr/local/bin:$PATH
	$HOME/scripts/photo-splitfreq.sh " & args & " && rm " & args
end exec

on open (file_list)
	set args to convert_args(file_list)
	exec(args)
end open

on run {}
	set afile to choose file with prompt "Input image:" of type {"public.jpeg"}
	open ({afile})
end run


