@echo off
rem 出力結果が全て表示されてしまうので、まずechoをoffにしておく

rem 環境変数がシステムのものとかぶるかもしれないので書いておく
setlocal

rem この一行を書いておくと、forループの中でも変数の値の変化を保持できる。
setlocal enabledelayedexpansion

rem set /p INP="JTCフォルダのフルパス（フォルダの位置）を入力してください。>"
rem echo フォルダパスは、%INP%です。
rem pause

rem 対象ディレクトリをドラッグ&ドロップして実行
echo ディレクトリ名は「%~p1」です。

dir
pause

rem *******************************************************
rem tifファイル(000003～)をすべて順に保存
rem *******************************************************
cd %~p1
md tifs
set destpath=%~p1tifs\

rem 変更後ファイル名番号
set num=1

rem JTC翻訳対象のファイル(000003～)の検索
for /r %%f in (000003.tif, 000004.tif, 000005.tif, 000006.tif, 000007.tif, 000008.tif, 000009.tif, 000010.tif) do (

	rem 対象ファイルがあるか判定、存在するファイルのみ処理する
	if exist %%f (
		rem フルパスで変数に格納されていた物を　"ファイル名"、"ディレクトリ名"のみにする
		set fullpath=%%f
		set filename=%%~nf
		set dirname=%%~pf
		call :PROCESS1

	)
)

rem *******************************************************
rem PDFtoDataで変換するデータ抽出
rem *******************************************************

rem JTC翻訳対象のファイル(000003～)を保存するフォルダを作成
cd %~p1
md data
set destpath=%~dp1data\

rem ファイル名の最後につける番号
set num3=0
set num4=0
set num5=0
set num6=0
set num7=0
set num8=0
set num9=0
set num10=0
set suffix="000"

rem JTC翻訳対象のファイル(000003～)の検索
for /r %%f in (000003.tif, 000004.tif, 000005.tif, 000006.tif, 000007.tif, 000008.tif, 000009.tif, 000010.tif) do (

	set dirpath=%%~dpf

	rem dataフォルダはコピーしたデータなので検索しない

	if not !dirpath!==!destpath! (


		rem 対象ファイルがあるか判定、存在するファイルのみ処理する
		if exist %%f (
			rem フルパスで変数に格納されていた物を　"ファイル名"、"ディレクトリ名"のみにする
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
rem 各サブルーチン
rem *******************************************************

:PROCESS1
	rem　対象fifファイルをコピー
	copy !fullpath! tifs

	rem　コピーしたファイルの名前を変更（ex. 0000003->1.tif）
	ren  !destpath!!filename!.tif %num%.tif

	set /a num=!num!+1


goto :eof



:PROCESS2
	set newpath=!fullpath!

	if exist data\!filename!.tif (
		if !filename!==000003 (
			rem ファイル名の最後につける番号をインクリメント
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
	rem ファイル名の添え字を設定
	if !suffnum! lss 10 (
		set suffix="000"
	) else (
		if !suffnum! lss 100 (
			set suffix="00"
		) else (
			set suffix="0"
		)
	)

	rem　元ファイル名を変更
	ren  !fullpath! !filename!_%suffix%%1.tif

goto :eof


