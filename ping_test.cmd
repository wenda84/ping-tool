@echo off
title ������ͨ����
@REM color 02 

@REM ʹ��UTF-8�Ļ�������this_dayȡֵ�ͺ����ڲ�һ���ˣ����Ա��ļ�ʹ��GBK�����ʽ��
chcp 936 >nul 2>nul

@REM =========================================  ʹ��˵�� begin  =========================================
REM ADDR        ---- ��ʾ��Ҫping�ĵ�ַ,
REM DO_FAIL     ---- ʧ��ʱҪ�������飬������Ϊһ�����ļ���ַ����pingʧ�ܿ��Դ�
REM DELAY       ---- ping�ļ��
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
    if %DELAY% NEQ 0  (
        timeout /nobreak /t %DELAY% 
    )    
    goto begin
    
