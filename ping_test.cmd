@echo off
title 网络连通测试
@REM color 02

@REM =========================================  使用说明 begin  =========================================
REM ADDR        ---- 表示需要ping的地址,
REM DELAY       ---- ping的间隔
REM DO_FAIL     ---- 失败时要做的事情，比如设为一音乐文件地址，则ping失败可以打开
set ADDR=www.baidu.com
set DO_FAIL=D:\TEMP\music\bg.mp3
set DELAY=3
@REM =========================================  使用说明 end =========================================

@REM 这三行代码使命令会在后台运行，需要时可以打开
@REM if "%1"=="hide" goto CmdBegin
@REM start mshta vbscript:createobject("wscript.shell").run("""%~0"" hide",0)(window.close)&&exit
@REM :CmdBegin

:begin
    @REM 取日期放在begin后面，虽然效率低了点，但在脚本连续运行时，可支持跨天日志分包
    set this_day=%date:~0,4%_%date:~5,2%_%date:~8,2%

    echo ===================== 开始测试,正在ping %ADDR%...... =====================
    ping %ADDR% -n 1 -l 32 >nul 2>nul
    if %ERRORLEVEL% EQU 0  (
        goto good 
    )^
    else (
        goto error 
    )

:error
    echo 唔----%ADDR% 不能访问! %DELAY%秒后进行下一次尝试
    echo %time% ping %ADDR% failed,ERRORLEVEL=%ERRORLEVEL% >> "ping_test_%this_day%.log"
    @REM %DO_FAIL%
    goto finish

:good
    echo 耶! %ADDR% 可以访问! %DELAY%秒后进行下一次尝试.
    echo %time% ping %ADDR% successful >> "ping_test_%this_day%.log" 
    goto finish  

:finish
    timeout /nobreak /t %DELAY% 
    goto begin