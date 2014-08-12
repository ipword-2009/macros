@echo off
rem 出力結果が全て表示されてしまうので、まずechoをoffにしておく

rem 環境変数がシステムのものとかぶるかもしれないので書いておく
setlocal

rem *********************************************************************
rem 翻訳準備
rem まずオンライン辞書（熟考、memsource、英辞郎、Weblio）を一気に開く
rem 次に、C:\Translation\mng2.txtに登録した原文、訳文、
rem PDIC、Logophileを一気に開く
rem *********************************************************************

start "" "C:\software\uwsc48b\UWSC.exe" "C:\software\uwsc48b\onlineDics.UWS"

pause

start "" "C:\Program Files (x86)\Hidemaru\Hidemaru.exe" "/xC:\Users\mk\macros\start_trans.mac"
