@echo off
chcp 65001
cd /d D:\project\elearning\elearningserver\python
set LOG="%~dp0run_log.txt"

echo ================================== >>%LOG%
echo Start Time: %date% %time% >>%LOG%
C:\Users\Administrator\AppData\Local\Programs\Python\Python310\python.exe autoCheckPlace.py >>%LOG% 2>&1
echo End Time: %date% %time% >>%LOG%
