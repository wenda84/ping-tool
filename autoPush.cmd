@echo off
title Githubѭ������
@REM color 02 

@REM ʹ��UTF-8�Ļ�������this_dayȡֵ�ͺ����ڲ�һ���ˣ����Ա��ļ�ʹ��GBK�����ʽ��
chcp 936 >nul 2>nul

@REM =========================================  ʹ��˵�� begin  =========================================
REM DO_CMD      ---- ��ʾҪִ�е�����
REM DO_FAIL     ---- ʧ��ʱҪ�������飬������Ϊһ�����ļ���ַ������Ҫ����Դ�
REM DELAY       ---- ����ִ�еļ��
REM LOG_ENABLE  ---- �Ƿ����������־
set DO_CMD=git push
@REM set DO_FAIL=D:\TEMP\music\bg.mp3
set DELAY=1
set LOG_ENABLE=0
@REM =========================================  ʹ��˵�� end =========================================

@REM �����д���ʹ������ں�̨���У���Ҫʱ���Դ�
@REM if "%1"=="hide" goto CmdBegin
@REM start mshta vbscript:createobject("wscript.shell").run("""%~0"" hide",0)(window.close)&&exit
@REM :CmdBegin

:begin
    @REM ȡ���ڷ���begin���棬��ȻЧ�ʵ��˵㣬���ڽű���������ʱ����֧�ֿ�����־�ְ�
    set this_day=%date:~0,4%_%date:~5,2%_%date:~8,2%

    echo ===================== ��ʼִ�� %DO_CMD% ...... =====================
    %DO_CMD% >nul 2>nul
    if %ERRORLEVEL% EQU 0  (
        goto good 
    )^
    else (
        goto error 
    )

:error
    echo ��... %DO_CMD%ִ��ʧ��
    if %LOG_ENABLE% NEQ 0  (
        echo %time%: your cmd "%DO_CMD%" runfailed, ERRORLEVEL=%ERRORLEVEL% >> "cmd_%this_day%.log" 
    )    
    @REM %DO_FAIL%
    goto loop

:good
    echo Ү! ִ�гɹ�!.
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
