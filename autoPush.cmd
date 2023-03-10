@echo off
title Github循环发布
@REM color 02 

@REM 使用UTF-8的话，下面this_day取值就和现在不一样了，所以本文件使用GBK编码格式。
chcp 936 >nul 2>nul

@REM =========================================  使用说明 begin  =========================================
REM DO_CMD      ---- 表示要执行的命令
REM DO_FAIL     ---- 失败时要做的事情，比如设为一音乐文件地址，如需要则可以打开
REM DELAY       ---- 命令执行的间隔
REM LOG_ENABLE  ---- 是否产生本地日志
set DO_CMD=git push
@REM set DO_FAIL=D:\TEMP\music\bg.mp3
set DELAY=1
set LOG_ENABLE=0
@REM =========================================  使用说明 end =========================================

@REM 这三行代码使命令会在后台运行，需要时可以打开
@REM if "%1"=="hide" goto CmdBegin
@REM start mshta vbscript:createobject("wscript.shell").run("""%~0"" hide",0)(window.close)&&exit
@REM :CmdBegin

:begin
    @REM 取日期放在begin后面，虽然效率低了点，但在脚本连续运行时，可支持跨天日志分包
    set this_day=%date:~0,4%_%date:~5,2%_%date:~8,2%

    echo ===================== 开始执行 %DO_CMD% ...... =====================
    %DO_CMD% >nul 2>nul
    if %ERRORLEVEL% EQU 0  (
        goto good 
    )^
    else (
        goto error 
    )

:error
    echo 唔... %DO_CMD%执行失败
    if %LOG_ENABLE% NEQ 0  (
        echo %time%: your cmd "%DO_CMD%" runfailed, ERRORLEVEL=%ERRORLEVEL% >> "cmd_%this_day%.log" 
    )    
    @REM %DO_FAIL%
    goto loop

:good
    echo 耶! 执行成功!.
    if %LOG_ENABLE% NEQ 0  (
      echo %time%: your cmd "%DO_CMD%" run successful. >> "cmd_%this_day%.log" )
    goto end  

:loop
    if %DELAY% NEQ 0  (
        timeout /nobreak /t %DELAY% 
    )
    goto begin
    
:end
    pause
