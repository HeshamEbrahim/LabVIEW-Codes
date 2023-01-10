!  Set active SCAN nodes
active_nodes 12
!  Activate presures via calibrator/pressure distribution panel
!  Login to RAD initialize basic setup
rad_command 1 LOGIN 118
rad_command 1 LOGIN SUPER
rad_command 1 SET ECHO 1
rad_command 1 SET IFUSER 1
rad_command 1 SET ADTRIG 0
rad_command 1 SET SCANTRIG 0
rad_command 1 SET BINADDR 0 0.0.0.0
rad_command 1 SET IFC 62 0
rad_command 1 SET FORMAT 0
rad_command 1 SET TIMESTAMP 0
rad_command 1 SET TEMPPOLL 1
rad_command 1 SET EU 1
rad_command 1 SET ZC 1
rad_command 1 SET NETOUT 0
rad_command 1 SET FILEOUT 3
rad_command 1 TGRAD
rad_command 1 TEMP EU
execute nodes cd C:\1700149\PLW\3\SCAN
exebat nodes SCOPY D:\TUBELIBR\PLW\TUBEL072.TRF C:\1700149\PLW\3\INPUTS\TUBE.TRF
delay 150
!  Download linear combination matrix to the nodes
send_to 2 ?:\OUT\INPUTS\N0H00.MTX C:\1700149\PLW\3\INPUTS\COMBO.MTX
execute 2 set CRUNCH_MODE=VIRTUAL
!
!  Doing angle 10.00
!
!  Set Model Scale
pause CONFIRM MODEL SCALE AT 1:300
!  Set Test type
pause CONFIRM TEST TYPE  SUB
!  Set roughness coefficient alpha
pause SET ROUGHNESS COEFFICIENT ALPHA AT 0.25
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 10.00 degrees
!  Start fan
pause TURN CALIBRATOR AIR CYLINDER ON
pause START WIND TUNNEL FAN
!  Set fan speed
pause SET FAN SPEED AT  32.81 ft/sec
!  Setup for Calibration on nodes
!  Initialize RAD parameters for calibration
rad_command 1 SET PERIOD 31
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
rad_command 1 SET CHAN1 1-1..8-64
!  Set calib synch pulse frequency
!  Full calibration cycle
!  Calibrate RAD nodes
!  Set RAD in cal mode
rad_command 1 BANKB
!  Tell RAD numbe of master plains to calculte
rad_command 1 SET MPBS 8
!  Calibrate slot 0
calibrator_command ZO
delay 13000
calibrator_command_zv RP
calibrator_command GP 0.185
delay 13000
calibrator_command_pv RP
rad_command 1 CALINS <+CV> 1-1..8-64
!  Calibrate slot 1
calibrator_command ZO
delay 13000
calibrator_command_zv RP
calibrator_command GP 0.150
delay 13000
calibrator_command_pv RP
rad_command 1 CALINS <+CV> 1-1..8-64
!  Calibrate slot 2
calibrator_command ZO
delay 13000
calibrator_command_zv RP
calibrator_command GP 0.110
delay 13000
calibrator_command_pv RP
rad_command 1 CALINS <+CV> 1-1..8-64
!  Calibrate slot 3
calibrator_command ZO
delay 13000
calibrator_command_zv RP
calibrator_command GP 0.070
delay 13000
calibrator_command_pv RP
rad_command 1 CALINS <+CV> 1-1..8-64
!  Calibrate slot 4
calibrator_command ZO
delay 13000
calibrator_command_zv RP
delay 13000
calibrator_command_pv RP
rad_command 1 CALINS 0 1-1..8-64
!  Calibrate slot 5
calibrator_command ZO
delay 13000
calibrator_command_zv RP
calibrator_command GN 0.030
delay 13000
calibrator_command_pv RP
rad_command 1 CALINS <-CV> 1-1..8-64
!  Calibrate slot 6
calibrator_command ZO
delay 13000
calibrator_command_zv RP
calibrator_command GN 0.060
delay 13000
calibrator_command_pv RP
rad_command 1 CALINS <-CV> 1-1..8-64
!  Calibrate slot 7
calibrator_command ZO
delay 13000
calibrator_command_zv RP
calibrator_command GN 0.120
delay 13000
calibrator_command_pv RP
rad_command 1 CALINS <-CV> 1-1..8-64
!  Calibrate slot 8
calibrator_command ZO
delay 13000
calibrator_command_zv RP
calibrator_command GN 0.175
delay 13000
calibrator_command_pv RP
rad_command 1 CALINS <-CV> 1-1..8-64
!  Set Calibrator to Zero mode and fill master plaines and update zeros
calibrator_command ZO
delay 13000
rad_command 1 FILL
rad_command 1 CALZ ALL
!  Set RAD to default state
rad_command 1 DOUTPU
calibrator_command IC
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 010
delay 150
exebat nodes TSNAME 010
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.010
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.010
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 10
!
!  Doing angle 20.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 20.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 020
delay 150
exebat nodes TSNAME 020
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.020
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.020
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 20
!
!  Doing angle 30.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 30.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 030
delay 150
exebat nodes TSNAME 030
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.030
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.030
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 30
!
!  Doing angle 40.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 40.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 040
delay 150
exebat nodes TSNAME 040
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.040
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.040
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 40
!
!  Doing angle 50.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 50.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 050
delay 150
exebat nodes TSNAME 050
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.050
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.050
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 50
!
!  Doing angle 60.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 60.00 degrees
!  Setup for Calibration on nodes
!  Initialize RAD parameters for calibration
rad_command 1 SET PERIOD 31
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
rad_command 1 SET CHAN1 1-1..8-64
!  Set calib synch pulse frequency
!  Zero calibration cycle
!  Zero RAD nodes
calibrator_command ZO
delay 13000
rad_command 1 CALZ ALL
delay 13000
calibrator_command IC
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 060
delay 150
exebat nodes TSNAME 060
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.060
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.060
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 60
!
!  Doing angle 70.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 70.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 070
delay 150
exebat nodes TSNAME 070
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.070
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.070
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 70
!
!  Doing angle 80.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 80.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 080
delay 150
exebat nodes TSNAME 080
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.080
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.080
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 80
!
!  Doing angle 90.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 90.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 090
delay 150
exebat nodes TSNAME 090
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.090
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.090
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 90
!
!  Doing angle 100.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 100.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 100
delay 150
exebat nodes TSNAME 100
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.100
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.100
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 100
!
!  Doing angle 110.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 110.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 110
delay 150
exebat nodes TSNAME 110
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.110
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.110
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 110
!
!  Doing angle 120.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 120.00 degrees
!  Setup for Calibration on nodes
!  Initialize RAD parameters for calibration
rad_command 1 SET PERIOD 31
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
rad_command 1 SET CHAN1 1-1..8-64
!  Set calib synch pulse frequency
!  Zero calibration cycle
!  Zero RAD nodes
calibrator_command ZO
delay 13000
rad_command 1 CALZ ALL
delay 13000
calibrator_command IC
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 120
delay 150
exebat nodes TSNAME 120
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.120
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.120
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 120
!
!  Doing angle 130.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 130.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 130
delay 150
exebat nodes TSNAME 130
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.130
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.130
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 130
!
!  Doing angle 140.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 140.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 140
delay 150
exebat nodes TSNAME 140
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.140
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.140
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 140
!
!  Doing angle 150.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 150.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 150
delay 150
exebat nodes TSNAME 150
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.150
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.150
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 150
!
!  Doing angle 160.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 160.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 160
delay 150
exebat nodes TSNAME 160
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.160
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.160
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 160
!
!  Doing angle 170.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 170.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 170
delay 150
exebat nodes TSNAME 170
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.170
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.170
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 170
!
!  Doing angle 180.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 180.00 degrees
!  Setup for Calibration on nodes
!  Initialize RAD parameters for calibration
rad_command 1 SET PERIOD 31
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
rad_command 1 SET CHAN1 1-1..8-64
!  Set calib synch pulse frequency
!  Zero calibration cycle
!  Zero RAD nodes
calibrator_command ZO
delay 13000
rad_command 1 CALZ ALL
delay 13000
calibrator_command IC
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 180
delay 150
exebat nodes TSNAME 180
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.180
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.180
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 180
!
!  Doing angle 190.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 190.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 190
delay 150
exebat nodes TSNAME 190
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.190
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.190
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 190
!
!  Doing angle 200.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 200.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 200
delay 150
exebat nodes TSNAME 200
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.200
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.200
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 200
!
!  Doing angle 210.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 210.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 210
delay 150
exebat nodes TSNAME 210
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.210
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.210
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 210
!
!  Doing angle 220.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 220.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 220
delay 150
exebat nodes TSNAME 220
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.220
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.220
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 220
!
!  Doing angle 230.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 230.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 230
delay 150
exebat nodes TSNAME 230
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.230
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.230
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 230
!
!  Doing angle 240.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 240.00 degrees
!  Setup for Calibration on nodes
!  Initialize RAD parameters for calibration
rad_command 1 SET PERIOD 31
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
rad_command 1 SET CHAN1 1-1..8-64
!  Set calib synch pulse frequency
!  Zero calibration cycle
!  Zero RAD nodes
calibrator_command ZO
delay 13000
rad_command 1 CALZ ALL
delay 13000
calibrator_command IC
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 240
delay 150
exebat nodes TSNAME 240
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.240
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.240
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 240
!
!  Doing angle 250.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 250.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 250
delay 150
exebat nodes TSNAME 250
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.250
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.250
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 250
!
!  Doing angle 260.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 260.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 260
delay 150
exebat nodes TSNAME 260
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.260
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.260
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 260
!
!  Doing angle 270.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 270.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 270
delay 150
exebat nodes TSNAME 270
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.270
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.270
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 270
!
!  Doing angle 280.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 280.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 280
delay 150
exebat nodes TSNAME 280
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.280
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.280
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 280
!
!  Doing angle 290.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 290.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 290
delay 150
exebat nodes TSNAME 290
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.290
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.290
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 290
!
!  Doing angle 300.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 300.00 degrees
!  Setup for Calibration on nodes
!  Initialize RAD parameters for calibration
rad_command 1 SET PERIOD 31
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
rad_command 1 SET CHAN1 1-1..8-64
!  Set calib synch pulse frequency
!  Zero calibration cycle
!  Zero RAD nodes
calibrator_command ZO
delay 13000
rad_command 1 CALZ ALL
delay 13000
calibrator_command IC
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 300
delay 150
exebat nodes TSNAME 300
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.300
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.300
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 300
!
!  Doing angle 310.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 310.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 310
delay 150
exebat nodes TSNAME 310
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.310
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.310
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 310
!
!  Doing angle 320.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 320.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 320
delay 150
exebat nodes TSNAME 320
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.320
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.320
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 320
!
!  Doing angle 330.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 330.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 330
delay 150
exebat nodes TSNAME 330
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.330
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.330
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 330
!
!  Doing angle 340.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 340.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 340
delay 150
exebat nodes TSNAME 340
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.340
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.340
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 340
!
!  Doing angle 350.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 350.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 350
delay 150
exebat nodes TSNAME 350
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.350
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.350
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 350
!
!  Doing angle 360.00
!
!  Set turntable angle
pause SET TURNTABLE ANGLE AT 360.00 degrees
delay 150
!  Setup SCAN on nodes
!  Initialize RAD parameters for scan
rad_command 1 SET PERIOD 31
rad_command 1 SET FPS1 18432
rad_command 1 SET AVG1 1
rad_command 1 SET CHAN1 0
rad_command 1 SET SGENABLE1 1
send_to 2 ?:\OUT\INPUTS\N0H00.LST C:\1700149\PLW\3\INPUTS\N0H00.LST
exebat 2 MVTORAD C:\1700149\PLW\3\INPUTS\ N0H00.LST
rad_command 1 FILE N0H00.LST
!  Set scan synch pulse frequency
!  Perform SCAN
!  Perform scan on RAD nodes
rad_command 1 BANKA
delay 11000
rad_command 1 SCAN
!  Close off SCANS
rad_command 1 CLOSE
exebat 2 SMOVE "C:\Program Files\RAD\SN0118\SCAN0000.DAT" "C:\1700149\PLW\3\RAW\SCANDAT.000" 
rad_command 1 DOUTPU
!  Perform Analysis on All nodes
delay 150
exebat nodes C:\BAT\CRCHNDPL.BAT 360
delay 150
exebat nodes TSNAME 360
delay 150
!  Send analyzed data to SUpervisor node
receive_from 2 C:\1700149\PLW\3\CP\OUTCP.DAT ?:\IN\NODE1\CPINFO.360
receive_from 2 C:\1700149\PLW\3\RAW\SCANDAT.000 ?:\IN\NODE1\RAWSCAN.360
spawn_task C:\MASTER\BINRWDI\FILL.EXE 0 360
!  Stop fan
pause STOP WIND TUNNEL FAN
!  Finished hookup
pause HOOKUP #1 COMPLETE
pause PRESSURE COMBINATIONS TEST COMPLETE
!  De-Activate presures via calibrator/pressure distribution panel
calibrator_command ZO
delay 13000
calibrator_command IC
