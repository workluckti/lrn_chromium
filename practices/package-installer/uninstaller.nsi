;安装包 解压空白
!system '>blank set/p=MSCF<nul'
!packhdr temp.dat 'cmd /c Copy /b temp.dat /b +blank&&del blank'

;定义变量
; Var MSG     ;MSG变量必须定义，而且在最前面，否则WndProc::onCallback不工作，插件中需要这个消息变量,用于记录消息信息
; Var Dialog  ;Dialog变量也需要定义
; Var installPath ;保持安装路径

; Var UNINSTALL_PROG
; Var OLD_VER
; Var OLD_PATH

; 安装程序初始定义常量
!define PRODUCT_NAME "program"
!define PRODUCT_VERSION "1.0.0.0"
!define PRODUCT_PUBLISHER "program"
!define MAIN_APP_NAME "program.exe"
!define PRODUCT_NAME_EN "program"
; !define PRO_SERVICE_NAME "FxCloudService"
!define PRODUCT_WEB_SITE "http://www.program.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\${MAIN_APP_NAME}"
!define PRODUCT_AUTORUN_KEY "Software\Microsoft\Windows\CurrentVersion\Run"
!define UNINST_ROOT "Software\Microsoft\Windows\CurrentVersion\Uninstall"
!define PRODUCT_UNINST_KEY "${UNINST_ROOT}\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
; !define MUI_ICON "Icon\Setup.ico"
!define MUI_UNICON "Icon\Uninstall.ico"
!define MUI_UI "ui\mod.exe"

;刷新关联图标
!define SHCNE_ASSOCCHANGED 0x08000000
!define SHCNF_IDLIST 0
; 安装不需要重启
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
; 设置文件覆盖标记
SetOverwrite on
; 设置压缩选项
SetCompress auto
; 选择压缩方式
;SetCompressor /SOLID lzma
SetCompressor lzma
SetCompressorDictSize 32
; 设置数据块优化
SetDatablockOptimize on
; 设置在数据中写入文件时间
SetDateSave on

; 是否允许安装在根目录下
AllowRootDirInstall false

XPStyle on
;应用程序显示名字
Name "${PRODUCT_NAME}"
;应用程序输出文件名
OutFile "${PRODUCT_NAME}_${PRODUCT_VERSION}.exe"
;安装路径
!define INST_PATH "$PROGRAMFILES\${PRODUCT_NAME_EN}"
InstallDir "${INST_PATH}"
InstallDirRegKey "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_UNINST_KEY}" "UninstallString"

ShowInstDetails nevershow ;设置是否显示安装详细信息。
ShowUninstDetails nevershow ;设置是否显示删除详细信息。

;文件版本声明-开始
VIProductVersion ${PRODUCT_VERSION}
VIAddVersionKey /LANG=2052 "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "Comments" "${PRODUCT_WEB_SITE}"
VIAddVersionKey /LANG=2052 "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=2052 "LegalTrademarks" "program"
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright (c) program"
VIAddVersionKey /LANG=2052 "FileDescription" "${PRODUCT_NAME} Install"
VIAddVersionKey /LANG=2052 "FileVersion" ${PRODUCT_VERSION}
;文件版本声明-结束

;引入的头文件
!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
; !include "LoadRTF.nsh"
!include "FileFunc.nsh"
!include "WordFunc.nsh"


; !macro DelFileByLog LogFile
;   IfFileExists `${LogFile}` 0 +4
;     Push `${LogFile}`
;     Call un.DelFileByLog
;     Delete `${LogFile}`
; !macroend

;!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
;自定义页面
;Page custom Page1Load Page1Leave
;!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPageShow
;!insertmacro MUI_PAGE_INSTFILES
;安装完成页面
;Page custom FinishPageLoad ""
;这个不要删除，否则自动跳转出问题
;Page custom Page4Load ""

;卸载过程页面
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;安装界面包含的语言设置 
!insertmacro MUI_LANGUAGE "TradChinese"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"

LangString MSG_NOW_UNINSTALLING ${LANG_SIMPCHINESE}  "正在卸载" 
LangString MSG_NOW_UNINSTALLING ${LANG_ENGLISH}  "Uninstalling"
LangString MSG_NOW_UNINSTALLING ${LANG_TRADCHINESE}  "正在解除安裝" 

LangString MSG_NDELETE_USER_DATA ${LANG_SIMPCHINESE}  "是否完全删除用户数据?" 
LangString MSG_NDELETE_USER_DATA ${LANG_ENGLISH}  "Do you want to permanently delete your data?"
LangString MSG_NDELETE_USER_DATA ${LANG_TRADCHINESE}  "是否完全刪除用戶數據?"  

LangString MSG_UNINSTALLER_DETECTED ${LANG_SIMPCHINESE}  "卸载程序检测到" 
LangString MSG_UNINSTALLER_DETECTED ${LANG_ENGLISH}  ""
LangString MSG_UNINSTALLER_DETECTED ${LANG_TRADCHINESE}  "解除安裝程序檢測到"

LangString MSG_IS_RUNNING ${LANG_SIMPCHINESE}  "正在运行,"
LangString MSG_IS_RUNNING ${LANG_ENGLISH}  "is running,"
LangString MSG_IS_RUNNING ${LANG_TRADCHINESE}  "正在運行," 

LangString MSG_CLOSE_BEFORE_UNINSTALLING ${LANG_SIMPCHINESE}  "请关闭之后再卸载!"
LangString MSG_CLOSE_BEFORE_UNINSTALLING ${LANG_ENGLISH}  "Please close the program before uninstallation!"
LangString MSG_CLOSE_BEFORE_UNINSTALLING ${LANG_TRADCHINESE}  "請關閉之後再解除安裝!"

;激活安装日志记录，该日志文件将会作为卸载文件的依据(注意，本区段必须放置在所有区段之前)
Section "-LogSetOn"
  LogSet on
SectionEnd

Section RegistKeys
	WriteUninstaller "F:\chromium-package\uninstaller\bin\uninst.exe" ;生成卸载文件
SectionEnd

Section Uninstall
	DetailPrint "$(MSG_NOW_UNINSTALLING)${PRODUCT_NAME}..."

    ReadRegStr $0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}" "Path";
    ; ${IF} $0 != ""
    ;     ; 调用宏只根据安装日志卸载安装程序自己安装过的文件
    ;     !insertmacro DelFileByLog "$0\install.log"
    ;     Delete "$0\uninst.exe"
    ; ${ENDIF}

	DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}"
	DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
	DeleteRegValue HKCU "${PRODUCT_AUTORUN_KEY}" "${MAIN_APP_NAME}"
	Delete "$QUICKLAUNCH\${PRODUCT_NAME}.lnk"
	Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
	Delete "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
	Delete "$SMPROGRAMS\${PRODUCT_NAME}\卸载${PRODUCT_NAME}.lnk"

  DeleteRegValue ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\.htm\OpenWithProgIds" "programHTM"
  DeleteRegValue ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\.html\OpenWithProgIds" "programHTM"
  DeleteRegValue ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\.pdf\OpenWithProgids" "programHTM"
  DeleteRegValue ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\.shtml\OpenWithProgids" "programHTM"
  DeleteRegValue ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\.svg\OpenWithProgIds" "programHTM"
  DeleteRegValue ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\.webp\OpenWithProgids" "programHTM"
  DeleteRegValue ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\.xht\OpenWithProgIds" "programHTM"
  DeleteRegValue ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\.xhtml\OpenWithProgIds" "programHTM"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\programHTM"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Clients\StartMenuInternet\program"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\program"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\program"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "SOFTWARE\Classes\Applications\program.exe"
  
  DeleteRegValue "HKCU" "SOFTWARE\Classes\.htm\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCU" "SOFTWARE\Classes\.html\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCU" "SOFTWARE\Classes\.pdf\OpenWithProgids" "programHTM"
  DeleteRegValue "HKCU" "SOFTWARE\Classes\.shtml\OpenWithProgids" "programHTM"
  DeleteRegValue "HKCU" "SOFTWARE\Classes\.svg\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCU" "SOFTWARE\Classes\.webp\OpenWithProgids" "programHTM"
  DeleteRegValue "HKCU" "SOFTWARE\Classes\.xht\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCU" "SOFTWARE\Classes\.xhtml\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCU" "Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "programHTM_.htm"
  DeleteRegValue "HKCU" "Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "programHTM_.html"
  DeleteRegValue "HKCU" "Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "programHTM_http"
  DeleteRegValue "HKCU" "Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "programHTM_https"
  DeleteRegKey "HKCU" "SOFTWARE\Classes\programHTM"
  DeleteRegKey "HKCU" "SOFTWARE\program"
  DeleteRegKey "HKCU" "SOFTWARE\Clients\StartMenuInternet\program"
  DeleteRegKey "HKCU" "SOFTWARE\Clients\StartMenuInternet\programHTM"
  
  DeleteRegValue "HKCR" ".htm\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCR" ".html\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCR" ".pdf\OpenWithProgids" "programHTM"
  DeleteRegValue "HKCR" ".shtml\OpenWithProgids" "programHTM"
  DeleteRegValue "HKCR" ".svg\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCR" ".webp\OpenWithProgids" "programHTM"
  DeleteRegValue "HKCR" ".xht\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCR" ".xhtml\OpenWithProgIds" "programHTM"
  DeleteRegKey "HKCR" "SOFTWARE\programHTM"
  DeleteRegValue "HKCR" "SOFTWARE\Classes\.htm\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCR" "SOFTWARE\Classes\.html\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCR" "SOFTWARE\Classes\.pdf\OpenWithProgids" "programHTM"
  DeleteRegValue "HKCR" "SOFTWARE\Classes\.shtml\OpenWithProgids" "programHTM"
  DeleteRegValue "HKCR" "SOFTWARE\Classes\.svg\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCR" "SOFTWARE\Classes\.webp\OpenWithProgids" "programHTM"
  DeleteRegValue "HKCR" "SOFTWARE\Classes\.xht\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKCR" "SOFTWARE\Classes\.xhtml\OpenWithProgIds" "programHTM"
  DeleteRegKey "HKCR" "SOFTWARE\Classes\programHTM"
  DeleteRegKey "HKCR" "program"

  DeleteRegKey "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\Software\program"
  DeleteRegKey "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\Software\Classes\programHTM"
  DeleteRegKey "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\Software\Clients\StartMenuInternet\program"
  DeleteRegKey "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\Software\Clients\StartMenuInternet\programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "programHTM_.htm"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "programHTM_.html"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "programHTM_http"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "programHTM_https"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\SOFTWARE\Classes\.htm\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\SOFTWARE\Classes\.html\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\SOFTWARE\Classes\.pdf\OpenWithProgids" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\SOFTWARE\Classes\.shtml\OpenWithProgids" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\SOFTWARE\Classes\.svg\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\SOFTWARE\Classes\.webp\OpenWithProgids" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\SOFTWARE\Classes\.xht\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001\SOFTWARE\Classes\.xhtml\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001_Classes\.htm\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001_Classes\.html\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001_Classes\.pdf\OpenWithProgids" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001_Classes\.shtml\OpenWithProgids" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001_Classes\.svg\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001_Classes\.webp\OpenWithProgids" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001_Classes\.xht\OpenWithProgIds" "programHTM"
  DeleteRegValue "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001_Classes\.xhtml\OpenWithProgIds" "programHTM"
  DeleteRegKey "HKU" "S-1-5-21-1306127416-1047410242-701397205-1001_Classes\programHTM"


  #卸载服务
  ; SimpleSC::StopService "${PRO_SERVICE_NAME}" 0 5
  ; SimpleSC::RemoveService "${PRO_SERVICE_NAME}"

  MessageBox MB_YESNO  "$(MSG_NDELETE_USER_DATA)" IDNO +2
  RMDir /r "$LOCALAPPDATA\${PRODUCT_NAME_EN}"
	
  RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
    
	;delete 
	RMDir /r "$0"

	SetAutoClose true
SectionEnd

Function un.onInit
  System::Call 'SHCore::SetProcessDpiAwareness(i 2)i.R0';解决win10对于高分屏缩放显示模糊问题
  ;InitPluginsDir ;初始化插件
  ;MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 '是否完全移除 ${PRODUCT_NAME},及其所有的组件?' IDYES +2
  ;Abort
  ;检测程序是否运行
  ;FindProcDLL::FindProc "${MAIN_APP_NAME}" ;检测的运行进程名称  64位无法检测
  killer::IsProcessRunning "${MAIN_APP_NAME}" ;检测的运行进程名称  
  Pop $R0
  IntCmp $R0 1 0 no_run
  MessageBox MB_ICONSTOP "$(MSG_UNINSTALLER_DETECTED) ${PRODUCT_NAME} $(MSG_IS_RUNNING) $(MSG_CLOSE_BEFORE_UNINSTALLING)"
  Quit
  no_run:
FunctionEnd


;以下是卸载程序通过安装日志卸载文件的专用函数，请不要随意修改
; Function un.DelFileByLog
;   Exch $R0
;   Push $R1
;   Push $R2
;   Push $R3
;   FileOpen $R0 $R0 r
;   ${Do}
; 	FileRead $R0 $R1
; 	${IfThen} $R1 == `` ${|} ${ExitDo} ${|}
; 	StrCpy $R1 $R1 -2
; 	StrCpy $R2 $R1 11
; 	StrCpy $R3 $R1 20
; 	${If} $R2 == "File: wrote"
; 	${OrIf} $R2 == "File: skipp"
; 	${OrIf} $R3 == "CreateShortCut: out:"
; 	${OrIf} $R3 == "created uninstaller:"
; 	  Push $R1
; 	  Push `"`
; 	  Call un.DelFileByLog.StrLoc
; 	  Pop $R2
; 	  ${If} $R2 != ""
; 		IntOp $R2 $R2 + 1
; 		StrCpy $R3 $R1 "" $R2
; 		Push $R3
; 		Push `"`
; 		Call un.DelFileByLog.StrLoc
; 		Pop $R2
; 		${If} $R2 != ""
; 		  StrCpy $R3 $R3 $R2
; 		  Delete /REBOOTOK $R3
; 		${EndIf}
; 	  ${EndIf}
; 	${EndIf}
; 	StrCpy $R2 $R1 7
; 	${If} $R2 == "Rename:"
; 	  Push $R1
; 	  Push "->"
; 	  Call un.DelFileByLog.StrLoc
; 	  Pop $R2
; 	  ${If} $R2 != ""
; 		IntOp $R2 $R2 + 2
; 		StrCpy $R3 $R1 "" $R2
; 		Delete /REBOOTOK $R3
; 	  ${EndIf}
; 	${EndIf}
;   ${Loop}
;   FileClose $R0
;   Pop $R3
;   Pop $R2
;   Pop $R1
;   Pop $R0
; FunctionEnd


; Function un.DelFileByLog.StrLoc
;   Exch $R0
;   Exch
;   Exch $R1
;   Push $R2
;   Push $R3
;   Push $R4
;   Push $R5
;   StrLen $R2 $R0
;   StrLen $R3 $R1
;   StrCpy $R4 0
;   ${Do}
; 	StrCpy $R5 $R1 $R2 $R4
; 	${If} $R5 == $R0
; 	${OrIf} $R4 = $R3
; 	  ${ExitDo}
; 	${EndIf}
; 	IntOp $R4 $R4 + 1
;   ${Loop}
;   ${If} $R4 = $R3
; 	StrCpy $R0 ""
;   ${Else}
; 	StrCpy $R0 $R4
;   ${EndIf}
;   Pop $R5
;   Pop $R4
;   Pop $R3
;   Pop $R2
;   Pop $R1
;   Exch $R0
; FunctionEnd




