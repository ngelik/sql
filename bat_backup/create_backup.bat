@rem Список БД, которыйе необходимо забэкаписть, например DB_LIST=(DataBase1 DataBase2 DataBase3)
@set DB_LIST=(LabProject)

@rem Параметры подключения к СУБД
@set db_connect=-S SERVER\SQLEXPRESS

@rem ****************** Глобальные перменные, править не нужно ********************************

@set my_date=%DATE%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
@set LOGFILE="log_backup\%DB_LIST%.backup.%DATE%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%.log"
@set CURR_PATH=%~dp0

@rem ******************************************************************************************

@for %%i in %DB_LIST% do (
	call :run %%i
)
@EXIT /b

@rem ******************************************************************************************

:run
	@set db_name=%1%
	@set out_db_name=%db_name%%my_date%.bak
	@set full_path=%CURR_PATH%%out_db_name%
	
	@set backup_name='Full Backup of %db_name%'
	sqlcmd %db_connect% -i ceate_backup.sql >> %LOGFILE%	
	@zip.exe "%out_db_name%.zip" "%out_db_name%" -9 -m
@EXIT /b
