@echo off

echo Please choose an option:
echo [1] Install and update packages and setup the computer, please not this needs to be ran as an admin.
echo [2] Check for updates
echo Enter your choice (1 or 2):

set /p choice=""

if "%choice%"=="1" goto install
if "%choice%"=="2" goto update

:install

set /p newname="Enter the new computer name: "

echo Renaming the computer...

wmic computersystem where name="%computername%" call rename name="%newname%"

@echo off
echo Installing and updating packages...

echo Installing/Updating Adobe Acrobat Reader 64-bit...
winget install -e --id Adobe.Acrobat.Reader.64-bit

echo Installing/Updating Belarc Advisor...
winget install -e --id Belarc.Advisor

echo Installing/Updating ONLYOFFICE Desktop Editors...
winget install -e --id ONLYOFFICE.DesktopEditors

echo Installing/Updating Microsoft OneDrive...
winget install -e --id Microsoft.OneDrive

echo Installing/Updating iLovePDF Desktop...
winget install -e --id iLovePDF.iLovePDFDesktop

echo Installing/Updating Sejda PDF Desktop...
winget install -e --id Sejda.PDFDesktop

echo Installing/Updating Mozilla Firefox...
winget install -e --id Mozilla.Firefox

echo Installing/Updating Hibbiki Chromium...
winget install -e --id Hibbiki.Chromium

echo Installing/Updating Notepad++...
winget install -e --id Notepad++.Notepad++

echo Installing/Updating Apache OpenOffice...
winget install -e --id Apache.OpenOffice

echo Installing/Updating Zoom...
winget install -e --id Zoom.Zoom

echo Installing/Updating Google Chrome...
winget install -e --id Google.Chrome

echo Installing/Updating WinDirStat...
winget install -e --id WinDirStat.WinDirStat

echo Installing/Updating 7zip...
winget install -e --id 7zip.7zip

echo Installing/Updating Everything...
winget install -e --id voidtools.Everything

echo Installing/Updating IrfanView...
winget install -e --id IrfanSkiljan.IrfanView

echo Installing/Updating Revo Uninstaller...
winget install -e --id RevoUninstaller.RevoUninstaller

echo Installing/Updating FastStone Viewer...
winget install -e --id FastStone.Viewer

echo Installing/Updating Glary Utilities...
winget install -e --id Glarysoft.GlaryUtilities

echo Installing/Updating VLC...
winget install -e --id VideoLAN.VLC

echo Installing/Updating Evernote...
winget install -e --id evernote.evernote

echo Installing/Updating Foxit PhantomPDF...
winget install -e --id Foxit.PhantomPDF

echo Installing/Updating Dropbox...
winget install -e --id Dropbox.Dropbox

echo Installing/Updating GIMP...
winget install -e --id GIMP.GIMP

echo Installing/Updating LibreOffice...
winget install -e --id TheDocumentFoundation.LibreOffice

echo Installing/Updating CDBurnerXP...
winget install -e --id Canneverbe.CDBurnerXP

echo Installing/Updating Paint.NET...
winget install -e --id dotPDNLLC.paintdotnet

echo Installing/Updating Google Earth Pro...
winget install -e --id Google.EarthPro

echo Checking for updates...
winget upgrade --all

echo All packages installed and updated successfully!

echo All packages installed and updated successfully!

echo Collecting system information...

set outputfile=%USERPROFILE%\Desktop\systeminfo.txt

echo Computer Name: %computername%
echo Computer Name: %computername% > %outputfile%

for /f "tokens=2 delims==" %%i in ('wmic computersystem get manufacturer /value') do set manufacturer=%%i
echo Manufacturer: %manufacturer%
echo Manufacturer: %manufacturer% >> %outputfile%

for /f "tokens=2 delims==" %%i in ('wmic computersystem get model /value') do set model=%%i
echo Model: %model%
echo Model: %model% >> %outputfile%

for /f "tokens=2 delims==" %%i in ('wmic cpu get Name /value') do set cpu=%%i
echo CPU: %cpu%
echo CPU: %cpu% >> %outputfile%

for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do set os=%%i
echo OS: %os%
echo OS: %os% >> %outputfile%

for /f "tokens=2 delims==" %%i in ('wmic logicaldisk where "drivetype=3" get size /value') do set disksize=%%i
echo Disk Size: %disksize%
echo Disk Size: %disksize% >> %outputfile%

for /f "tokens=2 delims==" %%i in ('wmic logicaldisk where "drivetype=3" get freespace /value') do set freediskspace=%%i
echo Free Disk Space: %freediskspace%
echo Free Disk Space: %freediskspace% >> %outputfile%

for /f "tokens=2 delims==" %%i in ('wmic computersystem get TotalPhysicalMemory /value') do set memory=%%i
set /a memoryMB=%memory% / 1048576
echo Memory: %memoryMB% MB
echo Memory: %memoryMB% MB >> %outputfile%

echo Custom power plan created with GUID: %GUID%

echo Setting screen saver timeout to 15 minutes (900 seconds)...
powercfg -setacvalueindex e73a048d-bf27-4f12-9731-8b2076e8891f 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 900

echo Setting sleep timeout to 5 hours (18000 seconds)...
powercfg -setacvalueindex e73a048d-bf27-4f12-9731-8b2076e8891f 238c9fa8-0aad-41ed-83f4-97be242c8f20 29f6c1db-86da-48c5-9fdb-f2b67b1f44da 18000

echo Setting system to never sleep when plugged into power...
powercfg -setacvalueindex e73a048d-bf27-4f12-9731-8b2076e8891f 238c9fa8-0aad-41ed-83f4-97be242c8f20 94ac6d29-73ce-41a6-809f-6363ba21b47e 0

echo Activating custom power plan...
powercfg -setactive e73a048d-bf27-4f12-9731-8b2076e8891f

echo Custom power plan applied successfully.

echo Disabling Xbox services...

echo Disabling Xbox Game Monitoring service...
sc query "XblGameSave" | find "RUNNING" >nul
if %errorlevel% == 0 (
    sc stop "XblGameSave"
)
sc config "XblGameSave" start= disabled

echo Disabling Xbox Live Auth Manager service...
sc query "XboxNetApiSvc" | find "RUNNING" >nul
if %errorlevel% == 0 (
    sc stop "XboxNetApiSvc"
)
sc config "XboxNetApiSvc" start= disabled

echo Disabling Xbox Live Game Save service...
sc query "XboxGipSvc" | find "RUNNING" >nul
if %errorlevel% == 0 (
    sc stop "XboxGipSvc"
)
sc config "XboxGipSvc" start= disabled

echo Xbox services have been disabled.

goto end

:update
echo Checking for updates...
winget upgrade --all
echo Updates checked successfully!
goto end

:end

echo The computer needs to be restarted to apply the new name and other power settings.

choice /C YN /M "Do you want to restart now? (Y/N)"

if %errorlevel% equ 1 (
  shutdown /r /t 0
) else (
  echo You can restart the computer later to apply the changes.
)