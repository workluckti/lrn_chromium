;��װ�� ��ѹ�հ�
!system '>blank set/p=MSCF<nul'
!packhdr temp.dat 'cmd /c Copy /b temp.dat /b +blank&&del blank'

;�������
; Var MSG     ;MSG�������붨�壬��������ǰ�棬����WndProc::onCallback���������������Ҫ�����Ϣ����,���ڼ�¼��Ϣ��Ϣ
; Var Dialog  ;Dialog����Ҳ��Ҫ����
; Var installPath ;���ְ�װ·��

; Var UNINSTALL_PROG
; Var OLD_VER
; Var OLD_PATH

; ��װ�����ʼ���峣��
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

;ˢ�¹���ͼ��
!define SHCNE_ASSOCCHANGED 0x08000000
!define SHCNF_IDLIST 0
; ��װ����Ҫ����
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
; �����ļ����Ǳ��
SetOverwrite on
; ����ѹ��ѡ��
SetCompress auto
; ѡ��ѹ����ʽ
;SetCompressor /SOLID lzma
SetCompressor lzma
SetCompressorDictSize 32
; �������ݿ��Ż�
SetDatablockOptimize on
; ������������д���ļ�ʱ��
SetDateSave on

; �Ƿ�����װ�ڸ�Ŀ¼��
AllowRootDirInstall false

XPStyle on
;Ӧ�ó�����ʾ����
Name "${PRODUCT_NAME}"
;Ӧ�ó�������ļ���
OutFile "${PRODUCT_NAME}_${PRODUCT_VERSION}.exe"
;��װ·��
!define INST_PATH "$PROGRAMFILES\${PRODUCT_NAME_EN}"
InstallDir "${INST_PATH}"
InstallDirRegKey "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_UNINST_KEY}" "UninstallString"

ShowInstDetails nevershow ;�����Ƿ���ʾ��װ��ϸ��Ϣ��
ShowUninstDetails nevershow ;�����Ƿ���ʾɾ����ϸ��Ϣ��

;�ļ��汾����-��ʼ
VIProductVersion ${PRODUCT_VERSION}
VIAddVersionKey /LANG=2052 "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "Comments" "${PRODUCT_WEB_SITE}"
VIAddVersionKey /LANG=2052 "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=2052 "LegalTrademarks" "program"
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright (c) program"
VIAddVersionKey /LANG=2052 "FileDescription" "${PRODUCT_NAME} Install"
VIAddVersionKey /LANG=2052 "FileVersion" ${PRODUCT_VERSION}
;�ļ��汾����-����

;�����ͷ�ļ�
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
;�Զ���ҳ��
;Page custom Page1Load Page1Leave
;!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPageShow
;!insertmacro MUI_PAGE_INSTFILES
;��װ���ҳ��
;Page custom FinishPageLoad ""
;�����Ҫɾ���������Զ���ת������
;Page custom Page4Load ""

;ж�ع���ҳ��
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;��װ����������������� 
!insertmacro MUI_LANGUAGE "TradChinese"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"

LangString MSG_NOW_UNINSTALLING ${LANG_SIMPCHINESE}  "����ж��" 
LangString MSG_NOW_UNINSTALLING ${LANG_ENGLISH}  "Uninstalling"
LangString MSG_NOW_UNINSTALLING ${LANG_TRADCHINESE}  "���ڽ�����b" 

LangString MSG_NDELETE_USER_DATA ${LANG_SIMPCHINESE}  "�Ƿ���ȫɾ���û�����?" 
LangString MSG_NDELETE_USER_DATA ${LANG_ENGLISH}  "Do you want to permanently delete your data?"
LangString MSG_NDELETE_USER_DATA ${LANG_TRADCHINESE}  "�Ƿ���ȫ�h���Ñ�����?"  

LangString MSG_UNINSTALLER_DETECTED ${LANG_SIMPCHINESE}  "ж�س����⵽" 
LangString MSG_UNINSTALLER_DETECTED ${LANG_ENGLISH}  ""
LangString MSG_UNINSTALLER_DETECTED ${LANG_TRADCHINESE}  "������b����z�y��"

LangString MSG_IS_RUNNING ${LANG_SIMPCHINESE}  "��������,"
LangString MSG_IS_RUNNING ${LANG_ENGLISH}  "is running,"
LangString MSG_IS_RUNNING ${LANG_TRADCHINESE}  "�����\��," 

LangString MSG_CLOSE_BEFORE_UNINSTALLING ${LANG_SIMPCHINESE}  "��ر�֮����ж��!"
LangString MSG_CLOSE_BEFORE_UNINSTALLING ${LANG_ENGLISH}  "Please close the program before uninstallation!"
LangString MSG_CLOSE_BEFORE_UNINSTALLING ${LANG_TRADCHINESE}  "Ո�P�]֮���ٽ�����b!"

;���װ��־��¼������־�ļ�������Ϊж���ļ�������(ע�⣬�����α����������������֮ǰ)
Section "-LogSetOn"
  LogSet on
SectionEnd

Section RegistKeys
	WriteUninstaller "F:\chromium-package\uninstaller\bin\uninst.exe" ;����ж���ļ�
SectionEnd

Section Uninstall
	DetailPrint "$(MSG_NOW_UNINSTALLING)${PRODUCT_NAME}..."

    ReadRegStr $0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}" "Path";
    ; ${IF} $0 != ""
    ;     ; ���ú�ֻ���ݰ�װ��־ж�ذ�װ�����Լ���װ�����ļ�
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
	Delete "$SMPROGRAMS\${PRODUCT_NAME}\ж��${PRODUCT_NAME}.lnk"

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


  #ж�ط���
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
  System::Call 'SHCore::SetProcessDpiAwareness(i 2)i.R0';���win10���ڸ߷���������ʾģ������
  ;InitPluginsDir ;��ʼ�����
  ;MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 '�Ƿ���ȫ�Ƴ� ${PRODUCT_NAME},�������е����?' IDYES +2
  ;Abort
  ;�������Ƿ�����
  ;FindProcDLL::FindProc "${MAIN_APP_NAME}" ;�������н�������  64λ�޷����
  killer::IsProcessRunning "${MAIN_APP_NAME}" ;�������н�������  
  Pop $R0
  IntCmp $R0 1 0 no_run
  MessageBox MB_ICONSTOP "$(MSG_UNINSTALLER_DETECTED) ${PRODUCT_NAME} $(MSG_IS_RUNNING) $(MSG_CLOSE_BEFORE_UNINSTALLING)"
  Quit
  no_run:
FunctionEnd


;������ж�س���ͨ����װ��־ж���ļ���ר�ú������벻Ҫ�����޸�
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




