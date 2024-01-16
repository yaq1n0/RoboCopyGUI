
# python wrapper for robocopy based backup solution
# robocopy documentation: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
# py-robocopy: https://pypi.org/project/py-robocopy/
# robocopy example: https://www.techrepublic.com/article/how-to-quickly-back-up-just-your-data-in-windows-10-with-robocopys-multi-threaded-feature/

from robocopy import robocopy

# list of top-level directories to be backed up from D: (local drive) to Z: (network drive)
dirs = [
"Backups", 
"Editing", 
"Lifting Videos", 
"NSFW", 
"Shadowplay Archive", 
"Soton_OneDrive_Backup"
]

source_drive = "D:\\"
destination_drive = "Z:\\"
for _dir in dirs: 
	source_folder = source_drive + _dir
	destination_folder = destination_drive + _dir
	options = "/mir /w:5 /mt:16 /tee /unilog+:\"robocopy_log.txt\""
	robocopy.copy(source_folder, destination_folder, options)
