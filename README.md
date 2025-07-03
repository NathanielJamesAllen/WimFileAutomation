# WimFileAutomation  
Automates the process for capturing an image and exporting it.

Improvements
1. Fix $LASTERRORCODE
2. add log file for wim process
3. use start/sleep instead of pause
4. add a check that will only run if there is a driver or driverapps folder that has a memory greater than zero
5. Link to html document where the code can be copied and instructions are included
6. add part where if driverapps folder dne then run create dock wim
7. add error checking

Steps to create wim file:
1. Plug in flash drive with script.
2. Run script as admin.
3. Check C:\ for wim files and ensure that the file sizes are accurate.
