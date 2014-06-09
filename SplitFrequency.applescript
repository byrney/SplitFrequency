#!/usr/bin/osascript

# change a list of filenames to a string of escaped posix names
# that can be passed to the shell
on convert_args(argv)
	set args to ""
	repeat with i in argv
		set p to POSIX path of i
		set args to args & " " & quoted form of p
	end repeat
	return args
end convert_args

# find the script in the applcation package and execute it
on exec(args)
	set myPath to (POSIX path of(path to me))
	set scriptPath to (quoted form of (myPath & "Contents/Resources/Scripts/photo-splitfreq.sh"))
	do shell script "
	export PATH=$HOME/bin:/usr/local/bin:$PATH
	" & scriptPath & " " & args & " && rm " & args
end exec

# called when files are dropped on the app.
# convert to posix args and run the script
on open (file_list)
	set args to convert_args(file_list)
	exec(args)
end open

# called when the app is sarted witout any files
# prompt for input file and run as though it was dropped
on run {}
	set afile to choose file with prompt "Image to convert (it will be deleted)" of type {"public.jpeg"}
	open ({afile})
end run



