@echo off
REM Script para ejecutar ff

REM Rutas de archivos
set FF_EXEC=..\..\FFv2.3-exe\ff.exe
set DOMAIN_FILE=domainExtension3.pddl
set PROBLEM_FILE=genProblemExt3.pddl
set OUTPUT_FILE=resultado.txt

REM Ejecución
echo Ejecutando el planificador...
%FF_EXEC% -o "%DOMAIN_FILE%" -f "%PROBLEM_FILE%" > "%OUTPUT_FILE%"

echo Comando ejecutado. El resultado se ha guardado en "%OUTPUT_FILE%".
pause