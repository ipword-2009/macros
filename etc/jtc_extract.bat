@echo off
rem �o�͌��ʂ��S�ĕ\������Ă��܂��̂ŁA�܂�echo��off�ɂ��Ă���

rem ���ϐ����V�X�e���̂��̂Ƃ��Ԃ邩������Ȃ��̂ŏ����Ă���
setlocal

rem ���̈�s�������Ă����ƁAfor���[�v�̒��ł��ϐ��̒l�̕ω���ێ��ł���B
setlocal enabledelayedexpansion

rem set /p INP="JTC�t�H���_�̃t���p�X�i�t�H���_�̈ʒu�j����͂��Ă��������B>"
rem echo �t�H���_�p�X�́A%INP%�ł��B
rem pause

rem �Ώۃf�B���N�g�����h���b�O&�h���b�v���Ď��s
echo �f�B���N�g�����́u%~p1�v�ł��B

dir
pause

rem *******************************************************
rem tif�t�@�C��(000003�`)�����ׂď��ɕۑ�
rem *******************************************************
cd %~p1
md tifs
set destpath=%~p1tifs\

rem �ύX��t�@�C�����ԍ�
set num=1

rem JTC�|��Ώۂ̃t�@�C��(000003�`)�̌���
for /r %%f in (000003.tif, 000004.tif, 000005.tif, 000006.tif, 000007.tif, 000008.tif, 000009.tif, 000010.tif) do (

	rem �Ώۃt�@�C�������邩����A���݂���t�@�C���̂ݏ�������
	if exist %%f (
		rem �t���p�X�ŕϐ��Ɋi�[����Ă��������@"�t�@�C����"�A"�f�B���N�g����"�݂̂ɂ���
		set fullpath=%%f
		set filename=%%~nf
		set dirname=%%~pf
		call :PROCESS1

	)
)

rem *******************************************************
rem PDFtoData�ŕϊ�����f�[�^���o
rem *******************************************************

rem JTC�|��Ώۂ̃t�@�C��(000003�`)��ۑ�����t�H���_���쐬
cd %~p1
md data
set destpath=%~dp1data\

rem �t�@�C�����̍Ō�ɂ���ԍ�
set num3=0
set num4=0
set num5=0
set num6=0
set num7=0
set num8=0
set num9=0
set num10=0
set suffix="000"

rem JTC�|��Ώۂ̃t�@�C��(000003�`)�̌���
for /r %%f in (000003.tif, 000004.tif, 000005.tif, 000006.tif, 000007.tif, 000008.tif, 000009.tif, 000010.tif) do (

	set dirpath=%%~dpf

	rem data�t�H���_�̓R�s�[�����f�[�^�Ȃ̂Ō������Ȃ�

	if not !dirpath!==!destpath! (


		rem �Ώۃt�@�C�������邩����A���݂���t�@�C���̂ݏ�������
		if exist %%f (
			rem �t���p�X�ŕϐ��Ɋi�[����Ă��������@"�t�@�C����"�A"�f�B���N�g����"�݂̂ɂ���
			set fullpath=%%f
			set filename=%%~nf
			set dirname=%%~pf			
			call :PROCESS2

		)
	)
)

start "" "C:\Program Files (x86)\CrossLanguage\PDFtoData2\PDF2Data2.exe"

goto :eof

rem *******************************************************
rem �e�T�u���[�`��
rem *******************************************************

:PROCESS1
	rem�@�Ώ�fif�t�@�C�����R�s�[
	copy !fullpath! tifs

	rem�@�R�s�[�����t�@�C���̖��O��ύX�iex. 0000003->1.tif�j
	ren  !destpath!!filename!.tif %num%.tif

	set /a num=!num!+1


goto :eof



:PROCESS2
	set newpath=!fullpath!

	if exist data\!filename!.tif (
		if !filename!==000003 (
			rem �t�@�C�����̍Ō�ɂ���ԍ����C���N�������g
			set /a num3=!num3!+1
			call :PROCESS3 !num3!
		)
		if !filename!==000004 (
			set /a num4=!num4!+1
			call :PROCESS3 !num4!
		)
		if !filename!==000005 (
			set /a num5=!num5!+1
			call :PROCESS3 !num5!
		)
		if !filename!==000006 (
			set /a num6=!num6!+1
			call :PROCESS3 !num6!
		)
		if !filename!==000007 (
			set /a num7=!num7!+1
			call :PROCESS3 !num7!
		)
		if !filename!==000008 (
			set /a num8=!num8!+1
			call :PROCESS3 !num8!
		)
		if !filename!==000009 (
			set /a num9=!num9!+1
			call :PROCESS3 !num9!
		)
		if !filename!==000010 (
			set /a num10=!num10!+1
			call :PROCESS3 !num10!
		)

	)

	copy !dirpath!!filename!*.tif data

goto :eof


:PROCESS3
	set /a suffnum=%1
	rem �t�@�C�����̓Y������ݒ�
	if !suffnum! lss 10 (
		set suffix="000"
	) else (
		if !suffnum! lss 100 (
			set suffix="00"
		) else (
			set suffix="0"
		)
	)

	rem�@���t�@�C������ύX
	ren  !fullpath! !filename!_%suffix%%1.tif

goto :eof


