!  Set active HYSCAN nodes
active_nodes 12
!  Copy initialization batch file to the nodes
send_to nodes ?:\OUT\SETUP\PLW\INITNDPL.BAT C:\BAT\INITNDPL.BAT
!  Execute initialization batch file on the nodes
exebat nodes C:\BAT\INITNDPL.BAT
delay 150
!  Copy TUNNEL.CTL file to the nodes
send_to nodes ?:\OUT\INPUTS\TUNNEL.CTL C:\1700149\PLW\3\CTL\TUNNEL.CTL
!  Copy SETS.INF file to the nodes
send_to nodes ?:\OUT\INPUTS\SETS.INF C:\1700149\PLW\3\CTL\SETS.INF
!  Copy SCAN.DEF file to the nodes
send_to nodes ?:\OUT\INPUTS\SCAN.DEF C:\1700149\PLW\3\CTL\SCAN.DEF
!  Copy CRUNCH batch file to the nodes
send_to nodes ?:\OUT\SETUP\PLW\CRCHNDPL.BAT C:\BAT\CRCHNDPL.BAT
delay 150
!  End
pause SCAN NODE INITIALIZATION COMPLETE
