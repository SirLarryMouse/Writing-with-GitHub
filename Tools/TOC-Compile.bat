@echo off

::Clear Table of Contents
break>0-TOC.md

::Add Heading
echo # Table of Contents >>0-TOC.md
echo. >>0-TOC.md

set curName=0-TOC.md

::Loop through all chapter files
set /a loopNo = 0
for %%a in ("*.md") do call :Write %%a
goto End

:Write
	::Display loop number
	echo loop %loopNo%
	
	::Set and display previous chapter
	set prevName=%curName%
	echo prev: %prevName%
	
	::Set file name
	set curName=%1
	echo curr: %curName%
	
	::Find and delete page nav links
	findstr /v /c:"\*\*" "%curName%" >tmpList.txt
	move /y tmpList.txt "%curName%" >nul
	
	::Begin Page Nav Links
	if %loopNo% gtr 0 echo **** >>%curName%
	
	::Add seperator to previous page
	if %loopNo% gtr 2 echo **-** >>%prevName%
	
	::Add link to current page on previous page
	if %loopNo% gtr 1 echo **[Next](%curName%)**>>%prevName%
	
	::Add link to previous page on current page
	if %loopNo% gtr 1 echo **[Previous](%prevName%)**>>%curName%
	
	::Set chapter title
	set curTitle=%curName:~0,-3%
	set curTitle=%curTitle:_= %
	set curTitle=%curTitle:-= - %
	echo titl: %curTitle%
	
	::Write link to TOC
	echo [Chapter %curTitle%](%curName%)>>0-TOC.md
	echo. >>0-TOC.md
	
	::Increment loop number
	set /a loopNo = %loopNo% + 1
	
	::Go back to loop
	goto :eof

:End

pause