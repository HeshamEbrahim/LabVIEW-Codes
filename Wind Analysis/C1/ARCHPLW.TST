!  Set active nodes
active_nodes 1
!  Copy archiving batch file to the nodes
send_to nodes ?:\OUT\SETUP\PLW\ARCHNDPL.BAT C:\BAT\ARCHNDPL.BAT
!  Execute archiving batch file on the nodes
pause BE SURE ARCHIVE DISK IS INSERTED IN EACH NODE
exebat nodes C:\BAT\ARCHNDPL.BAT
delay 150
!  End
pause NODE ARCHIVING COMPLETE
