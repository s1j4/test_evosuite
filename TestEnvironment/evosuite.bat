
rem Usage: <name of this script with extension> <path to project file> <path to config file> <rounds> <max_instances>
rem Ex: evosuite.bat projects.csv config.csv 1 2


@echo off

setlocal enabledelayedexpansion

rem Parameters
set "projects=%~1"
set "configurations=%~2"
set "rounds=%~3"
set "max_instances=%~4"

rem Constants
set /A MEMORY=2500

rem Variables
set count=0


IF EXIST "results" (
    echo results folder already exists
    exit /b 1
)


for /l %%i in (1,1,%rounds%) do (

    set round=%%i

    rem Loop over projects & classes
    for /f "skip=1 tokens=1,2 delims=," %%a in ('type "!projects!"') do (

        set project_name=%%a
        set class_name=%%b

        rem Loop over configurations
        for /f "skip=1 tokens=1,2 delims=," %%c in ('type "!configurations!"') do (
            
            rem Sets and removes double quotes from the config_name & config
            set config_name=%%c
            set config_name=!config_name:"=!
            set config=%%d
            set config=!config:"=!

            rem Removes semi colons from the config string
            set user_configuration=
            if defined config (
                for %%e in ("!config:;=" "!") do (
                    set user_configuration=!user_configuration! %%~e
                )
            )
            
            rem Waits untill running instances are less than max_instances
            echo Waiting to run class !class_name! with configuration !config_name!...
            call :try_again


            rem Executes the test generation for this class & configuration

            echo Running class !class_name! with configuration !config_name! in background.
            echo ---------------------------------------------------------------------------------

            start "EvosuiteTestGeneration" java ^
                -Xmx4G ^
                -jar evosuite-master-1.2.1-SNAPSHOT.jar ^
                -mem !MEMORY! ^
                -Dconfiguration_id=!config_name! ^
                -class !class_name! ^
                -target projects/!project_name!/!project_name:~2!.jar ^
                -Dreport_dir=results/!config_name!/!project_name!/!class_name!/reports/!round! ^
                -Dtest_dir=results/!config_name!/!project_name!/!class_name!/tests/!round! ^
                !user_configuration!           
        
        )
    )
)


echo Waiting for all proccesses to finish...
:wait_all
for /f "tokens=1" %%g in ('tasklist /fi "imagename eq java.exe" /fi "windowtitle eq EvosuiteTestGeneration" ^| find /i /c "java.exe"') do (
    set count=%%~g
)

if !count! == 0 (
    echo Giving extra time to finish up...
    timeout /t 10 /nobreak >nul
    echo All finished.
    exit /b
) else ( 
    timeout /t 3 /nobreak >nul
    goto wait_all
)


:try_again
for /f "tokens=1" %%f in ('tasklist /fi "imagename eq java.exe" /fi "windowtitle eq EvosuiteTestGeneration" ^| find /i /c "java.exe"') do (
    set count=%%~f
)
if !count! geq !max_instances! (
    timeout /t 3 /nobreak >nul
    goto try_again
)
goto :eof
            

endlocal
