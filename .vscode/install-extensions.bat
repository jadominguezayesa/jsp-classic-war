@echo off
echo Installing VS Code extensions for Java web development...
echo.

REM Essential Java extensions
echo Installing Java Extension Pack...
code --install-extension vscjava.vscode-java-pack

echo Installing XML support...
code --install-extension redhat.vscode-xml

REM Recommended extensions  
echo Installing Auto Rename Tag...
code --install-extension formulahendry.auto-rename-tag

echo.
echo ✅ Extension installation completed!
echo 📝 Restart VS Code to ensure all extensions are loaded properly.
pause