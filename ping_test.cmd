@echo off
title ������ͨ����
@REM color 02

@REM =========================================  ʹ��˵�� begin  =========================================
REM ADDR        ---- ��ʾ��Ҫping�ĵ�ַ,
REM DELAY       ---- ping�ļ��
REM DO_FAIL     ---- ʧ��ʱҪ�������飬������Ϊһ�����ļ���ַ����pingʧ�ܿ��Դ�
set ADDR=www.baidu.com
set DO_FAIL=D:\TEMP\music\bg.mp3
set DELAY=3
@REM =========================================  ʹ��˵�� end =========================================

@REM �����д���ʹ������ں�̨���У���Ҫʱ���Դ�
@REM if "%1"=="hide" goto CmdBegin
@REM start mshta vbscript:createobject("wscript.shell").run("""%~0"" hide",0)(window.close)&&exit
@REM :CmdBegin

:begin
    @REM ȡ���ڷ���begin���棬��ȻЧ�ʵ��˵㣬���ڽű���������ʱ����֧�ֿ�����־�ְ�
    set this_day=%date:~0,4%_%date:~5,2%_%date:~8,2%

    echo ===================== ��ʼ����,����ping %ADDR%...... =====================
    ping %ADDR% -n 1 -l 32 >nul 2>nul
    if %ERRORLEVEL% EQU 0  (
        goto good 
    )^
    else (
        goto error 
    )

:error
    echo ��----%ADDR% ���ܷ���! %DELAY%��������һ�γ���
    echo %time% ping %ADDR% failed,ERRORLEVEL=%ERRORLEVEL% >> "ping_test_%this_day%.log"
    @REM %DO_FAIL%
    goto finish

:good
    echo Ү! %ADDR% ���Է���! %DELAY%��������һ�γ���.
    echo %time% ping %ADDR% successful >> "ping_test_%this_day%.log" 
    goto finish  

:finish
    timeout /nobreak /t %DELAY% 
    goto begin