@echo off
setlocal enabledelayedexpansion


@REM this code need to install package who change the app_package_name inside tha app to work correctly !!!

rem Read environment variables from GBSystem_Build_Apk.env file
for /f "tokens=1,* delims==" %%a in (GBSystem_Build_Apk.env) do (
    set "%%a=%%b"
)

rem Loop through the configurations and build each app
for /l %%i in (1, 1, 1) do (
    echo ---------------!App%%i_APP_NAME!------------------
    set "APP_NUMBER=!App%%i_APP_NUMBER!"
rem Loop clients list
for /l %%j in (0, 1, 9) do (
    set "API_URL=!Client%%j_URL!"
    set "S19=!Client%%j_S19!" 
 

    set "APP_NAME=!App%%i_APP_NAME!"
    set "PROJ_NAME=!App%%i_PROJ_NAME!"

    set "APP_NAME="!APP_NAME!_!Client%%j_Name!""
    set "PROJ_NAME="!PROJ_NAME!_!Client%%j_Name!""
    set "PACKAGE_NAME="com.bmsoft.!APP_NAME!""

    set "TOPIC_NAME=!Client%%j_Topic!"
    

echo APP_NAME = !APP_NAME! 
echo API_URL =!API_URL! 
echo S19 =!S19!
echo Package = !PACKAGE_NAME!
@REM com.bmsoft.!APP_NAME!


	
	cmd /c ""E:\flutter_projects\portail_salarie\fnr.exe" --cl --dir "E:\flutter_projects\portail_salarie\android\app\src\main" --fileMask "AndroidManifest.xml" --excludeFileMask "*.dll, *.exe" --includeSubDirectories --find "Manifiest_application_Label" --replace "!PROJ_NAME!""
	
    rem Change Package name
    rem cmd /c "flutter pub run change_app_package_name:main com.bmsoft.!APP_NAME!"

    rem Build the app
    cmd /c "flutter build apk --release --build-name=1.0.3 --build-number=2 --dart-define=APP_NUMBER=!APP_NUMBER! --dart-define=API_URL=!API_URL! --dart-define=S19=!S19! --dart-define=APP_NAME=!APP_NAME! --dart-define=TOPIC_NAME=!TOPIC_NAME!"

    rem Move the generated APK file to the destination folder
    move E:\flutter_projects\portail_salarie\build\app\outputs\flutter-apk\app-release.apk E:\flutter_projects\NEW_RELEASE\!APP_NAME!.apk
	
	cmd /c ""E:\flutter_projects\portail_salarie\fnr.exe" --cl --dir "E:\flutter_projects\portail_salarie\android\app\src\main" --fileMask "AndroidManifest.xml" --excludeFileMask "*.dll, *.exe" --includeSubDirectories --find "!PROJ_NAME!" --replace "Manifiest_application_Label""
)

)

pause


@REM @echo off
@REM setlocal enabledelayedexpansion

@REM rem Read environment variables from GBSystem_Build_Apk.env file
@REM for /f "tokens=1,* delims==" %%a in (GBSystem_Build_Apk.env) do (
@REM     set "%%a=%%b"
@REM )

@REM rem Check if a command-line argument was provided
@REM if "%1"=="" (
@REM     echo Please specify the client number to build the app , ex : client1 , client2 ... .
@REM     exit /b
@REM )

@REM rem Select the app based on the command-line argument
@REM if "%1"=="client1" (
@REM     set "APP_NUMBER=!App1_APP_NUMBER!"
@REM     set "API_URL=!App1_API_URL!"
@REM     set "S19=!App1_S19!"
@REM ) else if "%1"=="client2" (
@REM     set "APP_NUMBER=!App2_APP_NUMBER!"
@REM     set "API_URL=!App2_API_URL!"
@REM     set "S19=!App2_S19!"
@REM     echo !S19!
@REM     echo !API_URL!
@REM     echo !APP_NUMBER!   
@REM ) else if "%1"=="client3" (
@REM     set "APP_NUMBER=!App3_APP_NUMBER!"
@REM     set "API_URL=!App3_API_URL!"
@REM     set "S19=!App3_S19!"
@REM ) else (
@REM     echo Invalid client selection.
@REM     exit /b
@REM )

@REM rem Build the selected app
@REM cmd /c "flutter build apk --release --build-name=1.0.1+1 --build-number=2 --dart-define=APP_NUMBER=!APP_NUMBER! --dart-define=API_URL=!API_URL! --dart-define=S19=!S19!"
@REM pause
@REM move D:\prjcts_flutter\gbs_new_project_last\build\app\outputs\apk\release\app-release.apk D:\prjcts_flutter\GBSystem\000_Release
@REM pause
@REM ren  D:\prjcts_flutter\GBSystem\000_Release\app-release.apk brinks_bm_ps1.apk
@REM pause

@REM endlocal
