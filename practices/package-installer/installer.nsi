;��װ�� ��ѹ�հ�
!system '>blank set/p=MSCF<nul'
!packhdr temp.dat 'cmd /c Copy /b temp.dat /b +blank&&del blank'

;�������
Var MSG     ;MSG�������붨�壬��������ǰ�棬����WndProc::onCallback���������������Ҫ�����Ϣ����,���ڼ�¼��Ϣ��Ϣ
Var Dialog  ;Dialog����Ҳ��Ҫ����
Var installPath ;���ְ�װ·��
Var freeSpaceSize
Var freeSpaceUnit
Var bgImage ;����ͼ ����ť��ӰЧ��
Var imageHandle ;
Var bgImage1 ;����ͼ �ް�ť��ӰЧ��
Var imageHandle1 ;
Var imageHandle2 ;

Var rtfLicense ;RichEdit20A �ı���
Var btnLicenseBack ;�û�����Э�� ȷ�� ��ť
Var btnQuick ;���ٰ�װ
Var btnCustom ;�Զ��尲װ
Var btnInstallNow ;������װ
Var btnBack ;���� ��ť
Var btnMinimize ;��С����ť
Var btnClose ;�رհ�ť
Var btnEnd ;���ҳ��رհ�ť
Var btnBrowse ;��� ��ť
Var btnExpress ;�������� ��ť
Var txtInstDir ;��װĿ¼ �ı���
Var btnFinish ;��ɰ�װ ��ť
; Var progressText ;�����ı�

Var chkLicense ;�Ķ�ͬ��Э�鸴ѡ��
Var licenseLink ;Link Label
Var chkDesktopLnk ;�����ݷ�ʽ
Var chkDesktopLnkState
; Var chkAddQuickLaunch ;���ӵ�����������
; Var chkAddQuickLaunchState
Var chkStartUp ;�����Զ�����
Var chkStartUpState

Var UNINSTALL_PROG
Var OLD_VER
Var OLD_PATH

; ��װ�����ʼ���峣��
!define PRODUCT_VERSION "1.0.3.8"
!define PRODUCT_X86_X64_NAME "x86"
!define PRODUCT_NAME "program"
!define PRODUCT_PUBLISHER "program Limited"
!define MAIN_APP_NAME "program.exe"
!define PRODUCT_NAME_EN "program"
!define PRODUCT_NAME_EN_1 "program"
;!define PRO_SERVICE_EXE_NAME "wscloudsvr"
;!define PRO_OLD_SERVICE_NAME "FxCloudMonitor"
;!define PRO_SERVICE_NAME "FxCloudService"
!define PRODUCT_WEB_SITE "https://www.program.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\${MAIN_APP_NAME}"
!define PRODUCT_AUTORUN_KEY "Software\Microsoft\Windows\CurrentVersion\Run"
!define UNINST_ROOT "Software\Microsoft\Windows\CurrentVersion\Uninstall"
!define PRODUCT_UNINST_KEY "${UNINST_ROOT}\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define MUI_ICON "Icon\Setup.ico"
!define MUI_UNICON "Icon\Uninstall.ico"
!define MUI_UI "ui\mod.exe"
; !define NDP "dotNetFx40_Full_x86_x64" ;"NDP452-KB2901907-x86-x64-AllOS-ENU";����.NetFramework��װ�ļ�Ŀ¼����
; !define VC2013REDIST_X86_KEY "{5e4b593b-ca3c-429c-bc49-b51cbf46e72a}"

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
SetCompressor lzma
SetCompressorDictSize 32
; �������ݿ��Ż�
SetDatablockOptimize on
; ������������д���ļ�ʱ��
SetDateSave on

; �Ƿ�������װ�ڸ�Ŀ¼��
AllowRootDirInstall false

XPStyle on
;Ӧ�ó�����ʾ����
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
;Ӧ�ó�������ļ���
OutFile "..\build\${PRODUCT_NAME}_${PRODUCT_VERSION}_${PRODUCT_X86_X64_NAME}.exe"
;��װ·��
; !define INST_PATH "$PROGRAMFILES\${PRODUCT_NAME_EN}"
!define INST_PATH "$LOCALAPPDATA\${PRODUCT_NAME_EN}\Application"
InstallDir "${INST_PATH}"
InstallDirRegKey "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_UNINST_KEY}" "UninstallString"
;Request application privileges for Windows Vista
RequestExecutionLevel admin  ;����ԱȨ��

ShowInstDetails nevershow ;�����Ƿ���ʾ��װ��ϸ��Ϣ��
ShowUninstDetails nevershow ;�����Ƿ���ʾɾ����ϸ��Ϣ��

;�ļ��汾����-��ʼ
VIProductVersion ${PRODUCT_VERSION}
VIAddVersionKey /LANG=2052 "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "Comments" "${PRODUCT_WEB_SITE}"
VIAddVersionKey /LANG=2052 "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=2052 "LegalTrademarks" "program"
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright (c) Prussia Limited"
VIAddVersionKey /LANG=2052 "FileDescription" "${PRODUCT_NAME} Install"
VIAddVersionKey /LANG=2052 "FileVersion" ${PRODUCT_VERSION}
;�ļ��汾����-����

;�����ͷ�ļ�
!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "LoadRTF.nsh"
!include "FileFunc.nsh"
!include "WordFunc.nsh"
!include "stdutils.nsh"


!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
;�Զ���ҳ��
Page custom Page1Load Page1Leave
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPageShow
!insertmacro MUI_PAGE_INSTFILES
;��װ���ҳ��
Page custom FinishPageLoad ""
;�����Ҫɾ���������Զ���ת������
Page custom Page4Load ""

;ж�ع���ҳ��
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;��װ����������������� 
!insertmacro MUI_LANGUAGE "TradChinese"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"


;���ֵ�ǰϵͳ������
LangString MSG_SYSTEM_LANGUAGE ${LANG_SIMPCHINESE}  "0804" ;���ļ���
LangString MSG_SYSTEM_LANGUAGE ${LANG_ENGLISH}  "0409" ; Ӣ��
LangString MSG_SYSTEM_LANGUAGE ${LANG_TRADCHINESE}  "0404" ;���ķ���

; �Զ�������
LangString MSG_VC_LOAD ${LANG_SIMPCHINESE}  "���ڰ�װVS2017���п�..."
LangString MSG_VC_LOAD ${LANG_ENGLISH}  "Installing VS2017..."
LangString MSG_VC_LOAD ${LANG_TRADCHINESE}  "���ڰ��bVS2017�\�Ў�..."

LangString MSG_NOW_DEPLOYED ${LANG_SIMPCHINESE}  "���ڲ���"
LangString MSG_NOW_DEPLOYED ${LANG_ENGLISH}  "Deploying"
LangString MSG_NOW_DEPLOYED ${LANG_TRADCHINESE}  "���ڲ���" 

LangString MSG_NOW_INSTALLING ${LANG_SIMPCHINESE}  "���ڰ�װ"
LangString MSG_NOW_INSTALLING ${LANG_ENGLISH}  "Installing"
LangString MSG_NOW_INSTALLING ${LANG_TRADCHINESE}  "���ڰ��b"

LangString MSG_INSTALL_EXE_RUNNING ${LANG_SIMPCHINESE}  "��װ�����Ѿ�����!"
LangString MSG_INSTALL_EXE_RUNNING ${LANG_ENGLISH}  "The installation is in progress!"
LangString MSG_INSTALL_EXE_RUNNING ${LANG_TRADCHINESE}  "���b��ʽ�ѽ��\��!"

LangString MSG_SOFEWARE_AGREEMENT ${LANG_SIMPCHINESE}  "program�������ɼ�����Э��"
LangString MSG_SOFEWARE_AGREEMENT ${LANG_ENGLISH}  "Agreement on Software License and Service"
LangString MSG_SOFEWARE_AGREEMENT ${LANG_TRADCHINESE}  "programܛ�w�S�ɼ����Յf�h"

LangString MSG_READE_AGREE ${LANG_SIMPCHINESE}  "���Ķ���ͬ��"
LangString MSG_READE_AGREE ${LANG_ENGLISH}  "I have read and agree to"
LangString MSG_READE_AGREE ${LANG_TRADCHINESE}  "����x�Kͬ��"

LangString MSG_SURE_BUTTON ${LANG_SIMPCHINESE}  "ȷ��"
LangString MSG_SURE_BUTTON ${LANG_ENGLISH}  "Confirm"
LangString MSG_SURE_BUTTON ${LANG_TRADCHINESE}  "�_��"

LangString MSG_INSTALL_NOW ${LANG_SIMPCHINESE}  "������װ"
LangString MSG_INSTALL_NOW ${LANG_ENGLISH}  "Install Now"
LangString MSG_INSTALL_NOW ${LANG_TRADCHINESE}  "�������b"

LangString MSG_BACK_BUTTON ${LANG_SIMPCHINESE}  "����"
LangString MSG_BACK_BUTTON ${LANG_ENGLISH}  "Back"
LangString MSG_BACK_BUTTON ${LANG_TRADCHINESE}  "����"

LangString MSG_DESKTOP_LINK ${LANG_SIMPCHINESE}  "�����ݷ�ʽ"
LangString MSG_DESKTOP_LINK ${LANG_ENGLISH}  "Desktop Shortcut"
LangString MSG_DESKTOP_LINK ${LANG_TRADCHINESE}  "�����ݷ�ʽ"

LangString MSG_AUTO_START ${LANG_SIMPCHINESE}  "�����Զ�����"
LangString MSG_AUTO_START ${LANG_ENGLISH}  "Boot Start"
LangString MSG_AUTO_START ${LANG_TRADCHINESE}  "�_�C�Ԅӆ���"

LangString MSG_TO_VIEW ${LANG_SIMPCHINESE}  "���..."
LangString MSG_TO_VIEW ${LANG_ENGLISH}  "Browser..."
LangString MSG_TO_VIEW ${LANG_TRADCHINESE}  "�g�[..."

LangString MSG_QUIT_EXR ${LANG_SIMPCHINESE}  "��ȷ��Ҫ�˳�"
LangString MSG_QUIT_EXR ${LANG_ENGLISH}  "Are you sure to exit "
LangString MSG_QUIT_EXR ${LANG_TRADCHINESE}  "���_��Ҫ�˳�"

LangString MSG_INSTALL_EXE ${LANG_SIMPCHINESE}  "��װ����?"
LangString MSG_INSTALL_EXE ${LANG_ENGLISH}  "Install?"
LangString MSG_INSTALL_EXE ${LANG_TRADCHINESE}  "���b��ʽ?"

LangString MSG_DOWNLOAD_FAILED ${LANG_SIMPCHINESE}  "����ʧ��"
LangString MSG_DOWNLOAD_FAILED ${LANG_ENGLISH}  "Download failed"
LangString MSG_DOWNLOAD_FAILED ${LANG_TRADCHINESE}  "���dʧ��"

LangString MSG_UNINSTALL_RUNNING ${LANG_SIMPCHINESE}  "ж�س����Ѿ�������."
LangString MSG_UNINSTALL_RUNNING ${LANG_ENGLISH}  "The uninstallation is in progress."
LangString MSG_UNINSTALL_RUNNING ${LANG_TRADCHINESE}  "������b��ʽ�ѽ����\��."

LangString MSG_DETECTED ${LANG_SIMPCHINESE}  "��⵽"
LangString MSG_DETECTED ${LANG_ENGLISH}  " "
LangString MSG_DETECTED ${LANG_TRADCHINESE}  "�z�y��"

LangString MSG_IS_RUNNING ${LANG_SIMPCHINESE}  "��������, "
LangString MSG_IS_RUNNING ${LANG_ENGLISH}  "is running, "
LangString MSG_IS_RUNNING ${LANG_TRADCHINESE}  "�����\��, "

LangString MSG_CLOSE_AND_TRY ${LANG_SIMPCHINESE}  "���ȹرպ����ԣ����ߵ��ȡ���˳�!"
LangString MSG_CLOSE_AND_TRY ${LANG_ENGLISH}  "Please try again after closing the program, or click to exit!"
LangString MSG_CLOSE_AND_TRY ${LANG_TRADCHINESE}  "Ո���P�]����ԇ�������c��ȡ���˳�!"

LangString MSG_IS_DOWNLOADING ${LANG_SIMPCHINESE}  "��������"
LangString MSG_IS_DOWNLOADING ${LANG_ENGLISH}  "Downloading"
LangString MSG_IS_DOWNLOADING ${LANG_TRADCHINESE}  "�������d"

LangString MSG_ARE_CONNECTED ${LANG_SIMPCHINESE}  "��������"
LangString MSG_ARE_CONNECTED ${LANG_ENGLISH}  "Connecting"
LangString MSG_ARE_CONNECTED ${LANG_TRADCHINESE}  "�����B��"

LangString MSG_REMAINNING ${LANG_SIMPCHINESE}  "ʣ��"
LangString MSG_REMAINNING ${LANG_ENGLISH}  "in"
LangString MSG_REMAINNING ${LANG_TRADCHINESE}  "ʣ�N"

LangString MSG_THE_SECONDS ${LANG_SIMPCHINESE}  "��"
LangString MSG_THE_SECONDS ${LANG_ENGLISH}  "seconds"
LangString MSG_THE_SECONDS ${LANG_TRADCHINESE}  "��"

LangString MSG_THE_MINUTES ${LANG_SIMPCHINESE}  "����"
LangString MSG_THE_MINUTES ${LANG_ENGLISH}  "minutes"
LangString MSG_THE_MINUTES ${LANG_TRADCHINESE}  "���"

LangString MSG_THE_HOURS ${LANG_SIMPCHINESE}  "Сʱ"
LangString MSG_THE_HOURS ${LANG_ENGLISH}  "hours"
LangString MSG_THE_HOURS ${LANG_TRADCHINESE}  "С�r"

LangString MSG_HAS_COMPLETED ${LANG_SIMPCHINESE}  "�����"
LangString MSG_HAS_COMPLETED ${LANG_ENGLISH}  "Completed"
LangString MSG_HAS_COMPLETED ${LANG_TRADCHINESE}  "�����"

LangString MSG_THE_SIZE ${LANG_SIMPCHINESE}  "��С"
LangString MSG_THE_SIZE ${LANG_ENGLISH}  "Size"
LangString MSG_THE_SIZE ${LANG_TRADCHINESE}  "��С"

LangString MSG_THE_SPEED ${LANG_SIMPCHINESE}  "�ٶ�"
LangString MSG_THE_SPEED ${LANG_ENGLISH}  "speed"
LangString MSG_THE_SPEED ${LANG_TRADCHINESE}  "�ٶ�"

LangString MSG_INSTALL_DEFAULT ${LANG_SIMPCHINESE}  "���ڰ�װĬ������"
LangString MSG_INSTALL_DEFAULT ${LANG_ENGLISH}  "Installing default configurations"
LangString MSG_INSTALL_DEFAULT ${LANG_TRADCHINESE}  "���ڰ��bĬ�J����"

LangString MSG_INSTALL_DIR_NOT_EXIT ${LANG_SIMPCHINESE}  "��װĿ¼������,����������!"
LangString MSG_INSTALL_DIR_NOT_EXIT ${LANG_ENGLISH}  "The installation directory does not exist. Please reset the directory!"
LangString MSG_INSTALL_DIR_NOT_EXIT ${LANG_TRADCHINESE}  "���bĿ䛲�����,Ո�����O��!"

LangString MSG_INSTALL_SPACE_NOT_ENOUGH ${LANG_SIMPCHINESE}  "��װ���̿ռ䲻��,����������!"
LangString MSG_INSTALL_SPACE_NOT_ENOUGH ${LANG_ENGLISH}  "Insufficient disk space. Please reset the disk!"
LangString MSG_INSTALL_SPACE_NOT_ENOUGH ${LANG_TRADCHINESE}  "���b�ŵ����g����,Ո�����O��!"

LangString MSG_PLEASE_SELECT ${LANG_SIMPCHINESE}  "��ѡ��"
LangString MSG_PLEASE_SELECT ${LANG_ENGLISH}  "Please select"
LangString MSG_PLEASE_SELECT ${LANG_TRADCHINESE}  "Ո�x��"

LangString MSG_INSTALL_DIR ${LANG_SIMPCHINESE}  "��װĿ¼: "
LangString MSG_INSTALL_DIR ${LANG_ENGLISH}  "the installation directory: "
LangString MSG_INSTALL_DIR ${LANG_TRADCHINESE}  "���bĿ�: "

;���װ��־��¼������־�ļ�������Ϊж���ļ�������(ע�⣬�����α����������������֮ǰ)
Section "-LogSetOn"
  LogSet on
SectionEnd

;��װ�����ͳ�ʼ������
Section -Init
	nsisSlideshow::Show /NOUNLOAD /auto=$PLUGINSDIR\Slides.dat

    ; ���Ӷ������ļ��Ƿ���ڵ��ж�
	IfFileExists $LOCALAPPDATA\${PRODUCT_NAME}\programService\*.* programExist

	SetOutPath $LOCALAPPDATA
	SetDetailsPrint textonly
	; program Service ��ʼĬ������
	DetailPrint "$(MSG_INSTALL_DEFAULT)..."
	RMDir /r "$LOCALAPPDATA\${PRODUCT_NAME}\programService"
	File /r "initCfg\*"

programExist:
	SetOutPath $PLUGINSDIR
	SetDetailsPrint textonly
	; DetailPrint "���ڰ�װVS2017���п�..."
	DetailPrint "$(MSG_VC_LOAD)"
	SetDetailsPrint none
	File "vs\VC_redist.${PRODUCT_X86_X64_NAME}.exe"
	ExecWait '"$PLUGINSDIR\VC_redist.${PRODUCT_X86_X64_NAME}.exe" /q'
	Delete "$PLUGINSDIR\VC_redist.${PRODUCT_X86_X64_NAME}.exe"
	Call GetNetFrameworkVersion
	Pop $R1
	LogText "GetNetFrameworkVersion:$R1"
	${VersionCompare} "$R1" "4.6.01590" $R1 ;���Windowsϵͳδ��װ4.5.2
	${If} $R1 = 2 
		; SetDetailsPrint textonly
		; DetailPrint "׼����װ .NET Framework 4.6.2 ..."
		; SetDetailsPrint none
		; CreateDirectory "$PLUGINSDIR\${NDP}"
		; SetOutPath "$PLUGINSDIR\${NDP}"
		; SetOverwrite on
		; File /r "${NDP}\*.*"
		; Sleep 50
		; SetDetailsPrint textonly
		; DetailPrint "���ڰ�װ.NET Framework 4.6.2...������Ҫ������ʱ��..."
		; SetDetailsPrint none
		; Sleep 50
		; ExecWait '"$PLUGINSDIR\${NDP}\NDP462-KB3151800-x86-x64-AllOS-ENU.exe"  /q /norestart /ChainingPackage FullX64Bootstrapper' $R1
		; SetOutPath $INSTDIR
		Call DownloadNetFramework462
	${EndIf}
SectionEnd


;Section unService
;    SimpleSC::ExistsService "${PRO_OLD_SERVICE_NAME}"
;    Pop $0
;    ${If} $0 == 0
;        SimpleSC::StopService "${PRO_OLD_SERVICE_NAME}" 0 5
;        SimpleSC::RemoveService "${PRO_OLD_SERVICE_NAME}"
;    ${EndIf}
;
;    SimpleSC::ExistsService "${PRO_SERVICE_NAME}"
;    Pop $1
;    ${If} $1 == 0
;        SimpleSC::StopService "${PRO_SERVICE_NAME}" 0 5
;    ${EndIf}
;SectionEnd

Section InstallFiles
	SetDetailsPrint textonly
	DetailPrint "$(MSG_NOW_INSTALLING) ${PRODUCT_NAME}..."
	SetDetailsPrint none ;����ʾ��Ϣ
	nsisSlideshow::Show /NOUNLOAD /auto=$PLUGINSDIR\Slides.dat
	SetOutPath $INSTDIR
    AccessControl::GrantOnFile $INSTDIR "(BU)" "FullAccess"  ;�ļ���Ȩ������Ϊ��ȫ����
	SetOverwrite on
	File /r "bin\*.*"
	Sleep 50
	DetailPrint "$(MSG_NOW_DEPLOYED)${PRODUCT_NAME}..."
	SetOutPath "$INSTDIR\update"
	File /oname=7zr.exe "tools\7zr_${PRODUCT_X86_X64_NAME}.exe"
	File /oname=courgette.exe "tools\courgette_${PRODUCT_X86_X64_NAME}.exe"
	nsExec::Exec '"$INSTDIR\update\7zr.exe" x "$INSTDIR\update\program.7z" -o"$INSTDIR" -aoa'
	; Delete "$INSTDIR\7za.exe"
	; Nsis7z::Extract "$INSTDIR\program.7z" ;��ѹ��Ч
	Sleep 50
	nsisSlideshow::Stop
	SetAutoClose true
SectionEnd


;Section InstallService
;    ExecWait '$WINDIR\Microsoft.NET\Framework\v4.0.30319\installutil.exe "$INSTDIR\${PRO_SERVICE_EXE_NAME}.exe"'
;    DetailPrint "��������"
;    SimpleSC::StartService "${PRO_SERVICE_NAME}"
;SectionEnd

Section RegistKeys
	; WriteUninstaller "$INSTDIR\uninst.exe" ;����ж���ļ�
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\${MAIN_APP_NAME}"
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}" "Path" "$INSTDIR\"
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "${PRODUCT_NAME}"
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${MAIN_APP_NAME},0"
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}" 
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLUpdateInfo" "${PRODUCT_WEB_SITE}"


    WriteRegStr HKCR "${PRODUCT_NAME_EN_1}" "" "CE Protocol"  ;��ҳ�򿪳���ӿ�
    WriteRegStr HKCR "${PRODUCT_NAME_EN_1}" "URL Protocol" "$INSTDIR\${MAIN_APP_NAME}"
    WriteRegStr HKCR "${PRODUCT_NAME_EN_1}\DefauleIcon" "" "$INSTDIR\${MAIN_APP_NAME},1"
    WriteRegStr HKCR "${PRODUCT_NAME_EN_1}\shell" "" ""
    WriteRegStr HKCR "${PRODUCT_NAME_EN_1}\shell\open" "" ""
    WriteRegStr HKCR "${PRODUCT_NAME_EN_1}\shell\open\command" "" '"$INSTDIR\${MAIN_APP_NAME}" "%1"'
SectionEnd


Section CreateShorts
    ;SetShellVarContext current
    ;������ʼ�˵���ݷ�ʽ
    CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${MAIN_APP_NAME}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\ж��${PRODUCT_NAME}.lnk" "$INSTDIR\uninst.exe"
    SetOverwrite on
    ${If} $chkDesktopLnkState == ${BST_CHECKED}
		;���������ݷ�ʽ
		CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${MAIN_APP_NAME}"
	${Else}
		Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
    ${EndIf}
    ; ${If} $chkAddQuickLaunchState == ${BST_CHECKED}
    ;     ;���ӵ�����������
    ;     ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" "CurrentVersion"
    ;     ${if} $R0 >= 6.0
    ;         ${StdUtils.InvokeShellVerb} $0 "$INSTDIR" "${MAIN_APP_NAME}" ${StdUtils.Const.ShellVerb.PinToTaskbar}
    ;     ${else}
    ;         CreateShortCut "$QUICKLAUNCH\${PRODUCT_NAME}.lnk" "$INSTDIR\${MAIN_APP_NAME}"
    ;     ${Endif}
	; ${Else}
	; 	Delete "$QUICKLAUNCH\${PRODUCT_NAME}.lnk"
    ; ${EndIf}
	${If} $chkStartUpState == ${BST_CHECKED}
		;�����Զ�����
		WriteRegStr HKCU "${PRODUCT_AUTORUN_KEY}" "${PRODUCT_NAME_EN}" "$INSTDIR\${MAIN_APP_NAME}"
	${Else}
		DeleteRegValue HKCU "${PRODUCT_AUTORUN_KEY}" "${PRODUCT_NAME_EN}"
    ${EndIf}
    
    Call RefreshShellIcons
SectionEnd



Function .onInit
	
	InitPluginsDir ;��ʼ�����
	; System::Call 'SHCore::SetProcessDpiAwareness(i 2)i.R0';���win10���ڸ߷���������ʾģ������->����֮�����ı����󣬲��ֻ���
	StrCpy $chkDesktopLnkState ${BST_CHECKED}
    ; StrCpy $chkAddQuickLaunchState ${BST_UNCHECKED}
    StrCpy $chkStartUpState ${BST_UNCHECKED} ;��������Ĭ�ϲ���ѡ
	StrCpy $UNINSTALL_PROG ""

		;����ظ�����
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MAIN_APP_NAME}") i .r1 ?e'
	Pop $R0
	StrCmp $R0 0 +3
		MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "$(MSG_INSTALL_EXE_RUNNING)"
		Abort

	;����Ƿ���������
	RETRY:
	;FindProcDLL::FindProc "${MAIN_APP_NAME}" ;�������н������� 64λ�޷����
	killer::IsProcessRunning "${MAIN_APP_NAME}" ;�������н������� 
	Pop $R1
	StrCmp $R1 1 0 +3
		MessageBox MB_RETRYCANCEL|MB_ICONINFORMATION|MB_TOPMOST "$(MSG_DETECTED) ${PRODUCT_NAME} $(MSG_IS_RUNNING)$(MSG_CLOSE_AND_TRY)" IDRETRY RETRY
		Abort

; 	;���ж�����а汾
; 	ClearErrors
; 	ReadRegStr $UNINSTALL_PROG ${PRODUCT_UNINST_ROOT_KEY} ${PRODUCT_UNINST_KEY} "UninstallString"
; 	ReadRegStr $installPath "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_DIR_REGKEY}" "Path"
; 	;IfErrors done
; 	${IfNot} $UNINSTALL_PROG == ""
; 		; StrCpy $installPath "${INST_PATH}"
; 	    ; StrCpy $OLD_PATH $UNINSTALL_PROG -10
; 	    ; ExecWait '"$UNINSTALL_PROG" /S _?=$OLD_PATH' $0
; 		;MessageBox MB_OK "$installPath"
; 		ExecWait '"$installPath\update\cleaner.exe" /S' $0
; 		;MessageBox MB_OK $0
; 		StrCmp $0 0  done
; 	    Abort
; done:
; 		RMDir /r $OLD_PATH
; 	${EndIf}

	${If} $installPath == ""
		ReadRegStr $installPath "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_DIR_REGKEY}" "Path"
		${If} $installPath == ""
			;��ʼ����װλ��
			StrCpy $INSTDIR "${INST_PATH}"
			StrCpy $installPath "$INSTDIR"
		${EndIf}
	${EndIf}
	
	; File `/oname=$PLUGINSDIR\bg.bmp` `images\bg.bmp` ;��һҳ���� ����ť��ӰЧ��
	; File `/oname=$PLUGINSDIR\bg1.bmp` `images\bg1.bmp` ;��һҳ���� �ް�ť��ӰЧ��
	; File `/oname=$PLUGINSDIR\bg2.bmp` `images\bg2.bmp` ;�ڶ�ҳ��װʱ����
    ; File `/oname=$PLUGINSDIR\BrowseBtn.bmp` `images\browse.bmp` ;�����ť
    ; File `/oname=$PLUGINSDIR\InstallNowBtn.bmp` `images\installnow.bmp` ;������װ
    ; File `/oname=$PLUGINSDIR\BackBtn.bmp` `images\back.bmp` ;����
    ; File `/oname=$PLUGINSDIR\CloseBtn.bmp` `images\close.bmp` ;�ر�
	; File `/oname=$PLUGINSDIR\min.bmp` `images\min.bmp` ;��С��
	; ;������Ƥ��
	; File `/oname=$PLUGINSDIR\empty_bg.bmp` `images\empty_bg.bmp`
  	; File `/oname=$PLUGINSDIR\full_bg.bmp` `images\full_bg.bmp`
  	
	${If} $(MSG_SYSTEM_LANGUAGE) = 0804 ;���ļ���
		File `/oname=$PLUGINSDIR\license.rtf` `rtf\license.rtf`  ;����Э��
	    File `/oname=$PLUGINSDIR\QuickBtn.bmp` `images\sc\quick.bmp`  ;���ٰ�װ
        File `/oname=$PLUGINSDIR\CustomBtn.bmp` `images\sc\custom.bmp`  ;�Զ��尲װ
	    File `/oname=$PLUGINSDIR\ExpressBtn.bmp` `images\sc\express.bmp` ;��������
	    File `/oname=$PLUGINSDIR\FinishBtn.bmp` `images\sc\finish.bmp` ;��װ���
	    File `/oname=$PLUGINSDIR\FinishBg.bmp` `images\sc\finishbg.bmp` ;���ҳ����

		File `/oname=$PLUGINSDIR\bg.bmp` `images\sc\bg.bmp` ;��һҳ���� ����ť��ӰЧ��
		File `/oname=$PLUGINSDIR\bg1.bmp` `images\sc\bg1.bmp` ;��һҳ���� �ް�ť��ӰЧ��
		File `/oname=$PLUGINSDIR\bg2.bmp` `images\sc\bg2.bmp` ;�ڶ�ҳ��װʱ����
		File `/oname=$PLUGINSDIR\BrowseBtn.bmp` `images\sc\browse.bmp` ;�����ť
		File `/oname=$PLUGINSDIR\InstallNowBtn.bmp` `images\sc\installnow.bmp` ;������װ
		File `/oname=$PLUGINSDIR\BackBtn.bmp` `images\sc\back.bmp` ;����
		File `/oname=$PLUGINSDIR\CloseBtn.bmp` `images\sc\close.bmp` ;�ر�
		File `/oname=$PLUGINSDIR\min.bmp` `images\sc\min.bmp` ;��С��
		;������Ƥ��
		File `/oname=$PLUGINSDIR\empty_bg.bmp` `images\sc\empty_bg.bmp`
		File `/oname=$PLUGINSDIR\full_bg.bmp` `images\sc\full_bg.bmp`
	${ElseIf} $(MSG_SYSTEM_LANGUAGE) == 0404 ;���ķ���
		File `/oname=$PLUGINSDIR\license.rtf` `rtf\license_tw.rtf`  ;����Э��
	    File `/oname=$PLUGINSDIR\QuickBtn.bmp` `images\tc\quick.bmp`  ;���ٰ�װ
        File `/oname=$PLUGINSDIR\CustomBtn.bmp` `images\tc\custom.bmp`  ;�Զ��尲װ
	    File `/oname=$PLUGINSDIR\ExpressBtn.bmp` `images\tc\express.bmp` ;��������
	    File `/oname=$PLUGINSDIR\FinishBtn.bmp` `images\tc\finish.bmp` ;��װ���
	    File `/oname=$PLUGINSDIR\FinishBg.bmp` `images\tc\finishbg.bmp` ;���ҳ����

		File `/oname=$PLUGINSDIR\bg.bmp` `images\tc\bg.bmp` ;��һҳ���� ����ť��ӰЧ��
		File `/oname=$PLUGINSDIR\bg1.bmp` `images\tc\bg1.bmp` ;��һҳ���� �ް�ť��ӰЧ��
		File `/oname=$PLUGINSDIR\bg2.bmp` `images\tc\bg2.bmp` ;�ڶ�ҳ��װʱ����
		File `/oname=$PLUGINSDIR\BrowseBtn.bmp` `images\tc\browse.bmp` ;�����ť
		File `/oname=$PLUGINSDIR\InstallNowBtn.bmp` `images\tc\installnow.bmp` ;������װ
		File `/oname=$PLUGINSDIR\BackBtn.bmp` `images\tc\back.bmp` ;����
		File `/oname=$PLUGINSDIR\CloseBtn.bmp` `images\tc\close.bmp` ;�ر�
		File `/oname=$PLUGINSDIR\min.bmp` `images\tc\min.bmp` ;��С��
		;������Ƥ��
		File `/oname=$PLUGINSDIR\empty_bg.bmp` `images\tc\empty_bg.bmp`
		File `/oname=$PLUGINSDIR\full_bg.bmp` `images\tc\full_bg.bmp`
	${ElseIf} $(MSG_SYSTEM_LANGUAGE) == 0409 ; Ӣ��
		File `/oname=$PLUGINSDIR\license.rtf` `rtf\license_us.rtf`  ;����Э��
	    File `/oname=$PLUGINSDIR\QuickBtn.bmp` `images\en\quick.bmp`  ;���ٰ�װ
        File `/oname=$PLUGINSDIR\CustomBtn.bmp` `images\en\custom.bmp`  ;�Զ��尲װ
	    File `/oname=$PLUGINSDIR\ExpressBtn.bmp` `images\en\express.bmp` ;��������
	    File `/oname=$PLUGINSDIR\FinishBtn.bmp` `images\en\finish.bmp` ;��װ���
	    File `/oname=$PLUGINSDIR\FinishBg.bmp` `images\en\finishbg.bmp` ;���ҳ����

		File `/oname=$PLUGINSDIR\bg.bmp` `images\en\bg.bmp` ;��һҳ���� ����ť��ӰЧ��
		File `/oname=$PLUGINSDIR\bg1.bmp` `images\en\bg1.bmp` ;��һҳ���� �ް�ť��ӰЧ��
		File `/oname=$PLUGINSDIR\bg2.bmp` `images\en\bg2.bmp` ;�ڶ�ҳ��װʱ����
		File `/oname=$PLUGINSDIR\BrowseBtn.bmp` `images\en\browse.bmp` ;�����ť
		File `/oname=$PLUGINSDIR\InstallNowBtn.bmp` `images\en\installnow.bmp` ;������װ
		File `/oname=$PLUGINSDIR\BackBtn.bmp` `images\en\back.bmp` ;����
		File `/oname=$PLUGINSDIR\CloseBtn.bmp` `images\en\close.bmp` ;�ر�
		File `/oname=$PLUGINSDIR\min.bmp` `images\en\min.bmp` ;��С��
		;������Ƥ��
		File `/oname=$PLUGINSDIR\empty_bg.bmp` `images\en\empty_bg.bmp`
		File `/oname=$PLUGINSDIR\full_bg.bmp` `images\en\full_bg.bmp`
	${EndIf}

  	

	;��ʼ��
    SkinBtn::Init "$PLUGINSDIR\QuickBtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\CustomBtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\BrowseBtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\InstallNowBtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\FinishBtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\BackBtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\ExpressBtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\CloseBtn.bmp"
	;SkinBtn::Init "$PLUGINSDIR\MinimizeBtn.bmp"
FunctionEnd

Function OldCheck
	;���ж�����а汾
	ClearErrors
	ReadRegStr $UNINSTALL_PROG ${PRODUCT_UNINST_ROOT_KEY} ${PRODUCT_UNINST_KEY} "UninstallString"
	ReadRegStr $installPath "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_DIR_REGKEY}" "Path"
	;IfErrors done
	${IfNot} $UNINSTALL_PROG == ""
		; StrCpy $installPath "${INST_PATH}"
	    ; StrCpy $OLD_PATH $UNINSTALL_PROG -10
	    ; ExecWait '"$UNINSTALL_PROG" /S _?=$OLD_PATH' $0
		;MessageBox MB_OK "$installPath"
		ExecWait '"$installPath\update\cleaner.exe" /S' $0
		StrCmp $0 0  done
        SetOutPath $installPath\update
		File /r "bin\update\cleaner.exe"
		Sleep 50
		ExecWait '"$installPath\update\cleaner.exe" /S'
done:
		RMDir /r $OLD_PATH
	${EndIf}
FunctionEnd


Function onGUIInit
    ;�����߿�
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;����һЩ���пؼ�
    GetDlgItem $0 $HWNDPARENT 1034
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1035
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1036
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1037
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1038
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1039
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}

    ${NSW_SetWindowSize} $HWNDPARENT 588 438 ;�ı��������С
    System::Call `User32::GetDesktopWindow()i.R0`
	SetDetailsPrint none ;����ʾ��Ϣ
FunctionEnd

Function Page1Load
	GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}
	
    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;�������͸��
    ${NSW_SetWindowSize} $0 588 438 ;�ı�Page��С
	
    ;��ȡRTF���ı���
	; nsDialogs::CreateControl "RichEdit20A" \
    ; ${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_TABSTOP}|${WS_VSCROLL}|${ES_MULTILINE}|${ES_WANTRETURN} \
	; 	${WS_EX_STATICEDGE}  16u 28u 360u 210u ''
	nsDialogs::CreateControl "RichEdit20A" \
    "${DEFAULT_STYLES}|${WS_VSCROLL}|${WS_CHILD}|${ES_MULTILINE}|${ES_READONLY}" \
    "${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}"  16 40 560 350 ''
    Pop $rtfLicense
	${LoadRTF} '$PLUGINSDIR\license.rtf' $rtfLicense
    ShowWindow $rtfLicense ${SW_HIDE}

	;Э��ȷ����ť
    ; ${NSD_CreateButton} 180u 240u 50 24 "$(MSG_SURE_BUTTON)"
	${NSD_CreateButton} 245 400 80 30 "$(MSG_SURE_BUTTON)"
    Pop $btnLicenseBack
    SkinBtn::Set /IMGID=$PLUGINSDIR\BackBtn.bmp $btnLicenseBack
    GetFunctionAddress $3 btnLicenseBack_Click
    SkinBtn::onClick $btnLicenseBack $3
    ; SetCtlColors $btnLicenseBack 7F7F7F transparent
    ShowWindow $btnLicenseBack ${SW_HIDE}

	;�Զ��尲װ��ť
    ${NSD_CreateButton} 488 409 94 19 ""
    Pop $btnCustom
    SkinBtn::Set /IMGID=$PLUGINSDIR\CustomBtn.bmp $btnCustom
    GetFunctionAddress $3 btnCustom_Click
    SkinBtn::onClick $btnCustom $3
	
	;���ٰ�װ
    ; ${NSD_CreateButton} 201 328 186 45 ""
	${NSD_CreateButton} 201 300 186 48 ""
    Pop $btnQuick
    SkinBtn::Set /IMGID=$PLUGINSDIR\QuickBtn.bmp $btnQuick
    GetFunctionAddress $3 btnInstall_Click
    SkinBtn::onClick $btnQuick $3

    ;��С����ť
    ${NSD_CreateButton} 515 1 36 36 ""
    Pop $btnMinimize
    SkinBtn::Set /IMGID=$PLUGINSDIR\min.bmp $btnMinimize
    GetFunctionAddress $3 btnMinimize_Click
    SkinBtn::onClick $btnMinimize $3

	;�رհ�ť
    ${NSD_CreateButton} 551 1 36 36 ""
    Pop $btnClose
    SkinBtn::Set /IMGID=$PLUGINSDIR\CloseBtn.bmp $btnClose
    GetFunctionAddress $3 btnClose_Click
    SkinBtn::onClick $btnClose $3
	
    ;������װ
    ; ${NSD_CreateButton} 432 404 86 24 "$(MSG_INSTALL_NOW)"
	${NSD_CreateButton} 404 387 100 34 "$(MSG_INSTALL_NOW)"
    Pop $btnInstallNow
    SkinBtn::Set /IMGID=$PLUGINSDIR\InstallNowBtn.bmp $btnInstallNow
    GetFunctionAddress $3 btnInstall_Click
    SkinBtn::onClick $btnInstallNow $3
    SetCtlColors $btnInstallNow FFFFFF transparent
    ShowWindow $btnInstallNow ${SW_HIDE}

    ;����
    ; ${NSD_CreateButton} 528 404 50 24 "$(MSG_BACK_BUTTON)"
	${NSD_CreateButton} 512 386 60 36 "$(MSG_BACK_BUTTON)"
    Pop $btnBack
    SkinBtn::Set /IMGID=$PLUGINSDIR\BackBtn.bmp $btnBack
    GetFunctionAddress $3 btnBack_Click
    SkinBtn::onClick $btnBack $3
    SetCtlColors $btnBack 7F7F7F transparent
    ShowWindow $btnBack ${SW_HIDE}

	#------------------------------------------
	#����Э��
	#------------------------------------------	
	; ����ϵͳ���Ե��޸Ĳ���
	${If} $(MSG_SYSTEM_LANGUAGE) = 0804 ;���ļ���
	    ${NSD_CreateCheckbox} 10 409 90 17 "$(MSG_READE_AGREE)"
	${ElseIf} $(MSG_SYSTEM_LANGUAGE) == 0404 ;���ķ���
		${NSD_CreateCheckbox} 10 409 95 17 "$(MSG_READE_AGREE)"
	${ElseIf} $(MSG_SYSTEM_LANGUAGE) == 0409 ; Ӣ��
	    ${NSD_CreateCheckbox} 10 409 145 17 "$(MSG_READE_AGREE)"
	${EndIf}
    Pop $chkLicense
    SetCtlColors $chkLicense "" FFFFFF
    ${NSD_Check} $chkLicense
    ${NSD_OnClick} $chkLicense chkLicense_Click

	${If} $(MSG_SYSTEM_LANGUAGE) = 0804 ;���ļ��� 
	    ${NSD_CreateLink} 100 412 160 17 "$(MSG_SOFEWARE_AGREEMENT)"
	${ElseIf} $(MSG_SYSTEM_LANGUAGE) == 0404 ;���ķ���
		${NSD_CreateLink} 105 412 200 17 "$(MSG_SOFEWARE_AGREEMENT)"
	${ElseIf} $(MSG_SYSTEM_LANGUAGE) == 0409 ; Ӣ��
	    ${NSD_CreateLink} 155 412 300 17 "$(MSG_SOFEWARE_AGREEMENT)"
	${EndIf}
    Pop $licenseLink
    SetCtlColors $licenseLink 2ea9df FFFFFF
    ${NSD_OnClick} $licenseLink licenseLink_Click 
	
	#------------------------------------------
	#��ѡ��1
	#------------------------------------------
    ; ${NSD_CreateCheckbox} 104 367 104 20 "$(MSG_DESKTOP_LINK)"
	${NSD_CreateCheckbox} 100 348 104 20 "$(MSG_DESKTOP_LINK)"
    Pop $chkDesktopLnk
    SetCtlColors $chkDesktopLnk ""  FFFFFF ;ǰ��ɫ,�������͸��
	ShowWindow $chkDesktopLnk ${SW_HIDE}
	${NSD_SetState} $chkDesktopLnk $chkDesktopLnkState
	
	#------------------------------------------
	#��ѡ��2
	#------------------------------------------
	; ${NSD_CreateCheckbox} 222 367 115 20 "���ӵ�����������"
    ; Pop $chkAddQuickLaunch
    ; SetCtlColors $chkAddQuickLaunch ""  FFFFFF ;ǰ��ɫ,�������͸��
	; ShowWindow $chkAddQuickLaunch ${SW_HIDE}
	; ${NSD_SetState} $chkAddQuickLaunch $chkAddQuickLaunchState
	
	#------------------------------------------
	#��ѡ��3
	#------------------------------------------
	; ${NSD_CreateCheckbox} 365 367 104 20 "�����Զ�����"
	${NSD_CreateCheckbox} 222 348 104 20 "$(MSG_AUTO_START)" ;�����������ӿ������������ʶ�������������ǰ
    Pop $chkStartUp
    SetCtlColors $chkStartUp ""  FFFFFF ;ǰ��ɫ,�������͸��
    ShowWindow $chkStartUp ${SW_HIDE}
	${NSD_SetState} $chkStartUp $chkStartUpState
	
	
	; ; ������װĿ¼�����ı���
	; ${NSD_CreateText} 100 300 300 30 "$installPath"
	; Pop $txtInstDir
	; SetCtlColors $txtInstDir ""  FFFFFF ;�������͸��
	; ; ${NSD_AddExStyle} $txtInstDir ${WS_EX_WINDOWEDGE}
    ; CreateFont $1 "tahoma" "10" "500"
    ; SendMessage $txtInstDir ${WM_SETFONT} $1 1
	; ShowWindow $txtInstDir ${SW_HIDE}
	; ${NSD_OnChange} $txtInstDir txtInstDir_TextChanged

	;��ϱ���ͼƬʹ���������־���
	nsDialogs::CreateControl EDIT \
    "${__NSD_Text_STYLE}|${ES_WANTRETURN}" "${}" 103 306 290 20 "$installPath"
	Pop $txtInstDir
	SetCtlColors $txtInstDir ""  FFFFFF ;�������͸��
	${NSD_AddExStyle} $txtInstDir ${WS_EX_WINDOWEDGE}
    CreateFont $1 "tahoma" "10" "500"
    SendMessage $txtInstDir ${WM_SETFONT} $1 1
	ShowWindow $txtInstDir ${SW_HIDE}
	${NSD_OnChange} $txtInstDir txtInstDir_TextChanged
	
	;��������·���ļ��а�ť
    ; ${NSD_CreateButton} 400 319 84 30  "$(MSG_TO_VIEW)"
	${NSD_CreateButton} 408 299 80 32  "$(MSG_TO_VIEW)"
	Pop $btnBrowse
	SkinBtn::Set /IMGID=$PLUGINSDIR\BrowseBtn.bmp $btnBrowse
	GetFunctionAddress $3 btnBrowse_Click
    SkinBtn::onClick $btnBrowse $3
    SetCtlColors $btnBrowse 7F7F7F transparent ;ǰ��ɫ,�������͸��
    ShowWindow $btnBrowse ${SW_HIDE}
	
	;������2,����
	${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $bgImage1
    ${NSD_SetImage} $bgImage1 $PLUGINSDIR\bg1.bmp $imageHandle1
    ShowWindow $bgImage1 ${SW_HIDE}

	;��������ͼ
	${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $bgImage
    ${NSD_SetImage} $bgImage $PLUGINSDIR\bg.bmp $imageHandle
	
	GetFunctionAddress $3 onGUICallback
    WndProc::onCallback $bgImage $3 ;�����ޱ߿����ƶ�
    WndProc::onCallback $bgImage1 $3 ;�����ޱ߿����ƶ�

    nsDialogs::Show
    ${NSD_FreeImage} $imageHandle
    ${NSD_FreeImage} $imageHandle1	
FunctionEnd

Function Page1Leave
	${NSD_GetState} $chkDesktopLnk $chkDesktopLnkState
	; ${NSD_GetState} $chkAddQuickLaunch $chkAddQuickLaunchState
	${NSD_GetState} $chkStartUp $chkStartUpState
FunctionEnd

Function InstFilesPageShow
	FindWindow $R2 "#32770" "" $HWNDPARENT
	ShowWindow $0 ${SW_HIDE}
    GetDlgItem $1 $R2 1027
    ShowWindow $1 ${SW_HIDE}

	;������չͼƬ
    ;File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    ;File '/oname=$PLUGINSDIR\InstallingBG01.png' 'images\InstallingBG01.png'
    ;File '/oname=$PLUGINSDIR\InstallingBG02.png' 'images\InstallingBG02.png'
    ;File '/oname=$PLUGINSDIR\InstallingBG03.png' 'images\InstallingBG03.png'
    ;File '/oname=$PLUGINSDIR\InstallingBG04.png' 'images\InstallingBG04.png'
	;File '/oname=$PLUGINSDIR\InstallingBG05.png' 'images\InstallingBG05.png'
	;File '/oname=$PLUGINSDIR\InstallingBG06.png' 'images\InstallingBG06.png'
	
	StrCpy $R0 $R2 ;�ı�ҳ���С,��Ȼ��ͼ����ȫҳ
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 588, i 438) i r2"
    GetFunctionAddress $3 onGUICallback
    WndProc::onCallback $R0 $3 ;�����ޱ߿����ƶ�
	
	GetDlgItem $R0 $R2 1004  ;���ý�����λ��
    System::Call "user32::MoveWindow(i R0, i 1, i 360, i 586, i 10) i r2"
	SkinProgress::Set $R0 "$PLUGINSDIR\full_bg.bmp" "$PLUGINSDIR\empty_bg.bmp" ;����������ͼ
	
	GetDlgItem $R1 $R2 1006  ;����������ı�ǩ
    SetCtlColors $R1 "" FFFFFF ;�������F6F6F6,ע����ɫ������Ϊ͸���������ص�
    System::Call "user32::MoveWindow(i R1, i 20, i 395, i 418, i 14) i r2"
	
	GetDlgItem $R8 $R2 1016 ;ListView
    ;SetCtlColors $R8 ""  F6F6F6 ;�������F6F6F6,ע����ɫ������Ϊ͸���������ص�
    System::Call "user32::MoveWindow(i R8, i 0, i 0, i 588, i 360) i r2"
	
	;FindWindow $R2 "#32770" "" $HWNDPARENT  ;��ȡ1995������ͼƬ
	GetDlgItem $R0 $R2 1995
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 588, i 438) i r2"
    ${NSD_SetImage} $R0 $PLUGINSDIR\bg2.bmp $imageHandle2

FunctionEnd

Function FinishPageLoad
	${NSD_FreeImage} $imageHandle2
	
	GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;�������͸��
    ${NSW_SetWindowSize} $0 588 438 ;�ı�Page��С

	;�رհ�ť
    ${NSD_CreateButton} 551 1 36 36 ""
    Pop $btnEnd
    SkinBtn::Set /IMGID=$PLUGINSDIR\CloseBtn.bmp $btnEnd
    GetFunctionAddress $3 btnEnd_Click
    SkinBtn::onClick $btnEnd $3
	
	;��������
    ${NSD_CreateButton} 201 300 186 48 ""
    Pop $btnExpress
    SkinBtn::Set /IMGID=$PLUGINSDIR\ExpressBtn.bmp $btnExpress
    GetFunctionAddress $3 btnExpress_Click
    SkinBtn::onClick $btnExpress $3
	
	;��ɰ�װ
	${If} $(MSG_SYSTEM_LANGUAGE) = 0804 ;���ļ��� 
	    ${NSD_CreateButton} 510 402 59 19 ""
	${ElseIf} $(MSG_SYSTEM_LANGUAGE) == 0404 ;���ķ���
		${NSD_CreateButton} 510 402 59 19 ""
	${ElseIf} $(MSG_SYSTEM_LANGUAGE) == 0409 ; Ӣ��
	    ${NSD_CreateButton} 497 402 75 19 ""
	${EndIf}
    Pop $btnFinish
    SkinBtn::Set /IMGID=$PLUGINSDIR\FinishBtn.bmp $btnFinish
    GetFunctionAddress $3 btnFinish_Click
    SkinBtn::onClick $btnFinish $3
	
	;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $bgImage1
    ${NSD_SetImage} $bgImage1 $PLUGINSDIR\finishbg.bmp $imageHandle1
	
	GetFunctionAddress $3 onGUICallback
    WndProc::onCallback $bgImage1 $3 ;�����ޱ߿����ƶ�
    nsDialogs::Show
	
	${NSD_FreeImage} $imageHandle1

FunctionEnd

Function Page4Load

FunctionEnd

;�����ޱ߿��ƶ�
Function onGUICallback
	${If} $MSG = ${WM_LBUTTONDOWN}
		SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
	${EndIf}
FunctionEnd

;ˢ�¹���ͼ��
Function RefreshShellIcons
  System::Call 'shell32.dll::SHChangeNotify(i, i, i, i) v \
  (${SHCNE_ASSOCCHANGED}, ${SHCNF_IDLIST}, 0, 0)'
FunctionEnd

;����ҳ����ת������
Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

Function btnMinimize_Click
  ShowWindow $HWNDPARENT ${SW_MINIMIZE}
FunctionEnd

Function btnClose_Click
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_ICONSTOP "$(MSG_QUIT_EXR) ${PRODUCT_NAME} $(MSG_INSTALL_EXE)" IDNO CANCEL
	SendMessage $hwndparent ${WM_CLOSE} 0 0
CANCEL:
	Abort
FunctionEnd

Function btnLicenseBack_Click
    ShowWindow $chkLicense ${SW_SHOW}
    ShowWindow $licenseLink ${SW_SHOW}
    ShowWindow $btnQuick ${SW_SHOW}
    ShowWindow $btnCustom ${SW_SHOW}
    ShowWindow $btnLicenseBack ${SW_HIDE}
    ShowWindow $rtfLicense ${SW_HIDE}
FunctionEnd

Function btnCustom_Click

ShowWindow $bgImage ${SW_HIDE}
ShowWindow $chkLicense ${SW_HIDE}
ShowWindow $licenseLink ${SW_HIDE}
ShowWindow $btnQuick ${SW_HIDE}
ShowWindow $btnCustom ${SW_HIDE}

ShowWindow $bgImage1 ${SW_SHOW}
ShowWindow $btnInstallNow ${SW_SHOW}
ShowWindow $btnBack ${SW_SHOW}
ShowWindow $chkDesktopLnk ${SW_SHOW}
; ShowWindow $chkAddQuickLaunch ${SW_SHOW}
ShowWindow $chkStartUp ${SW_SHOW}
ShowWindow $btnBrowse ${SW_SHOW}
ShowWindow $txtInstDir ${SW_SHOW}
FunctionEnd

;·��ѡ��ť�¼�,��Windowsϵͳ�Դ���Ŀ¼ѡ��Ի���
Function btnBrowse_Click
	${NSD_GetText} $txtInstDir $5
	nsDialogs::SelectFolderDialog "$(MSG_PLEASE_SELECT) ${PRODUCT_NAME} $(MSG_INSTALL_DIR)" "$5"
	Pop $6
	${IfNot} $6 == error
        ${GetRoot} $6 $8   ;��ȡ��װ��Ŀ¼
        ${If} $6 == "$8\"
            ${NSD_SetText} $txtInstDir  "$6${PRODUCT_NAME_EN}" 
        ${Else}
            ${NSD_SetText} $txtInstDir  "$6\${PRODUCT_NAME_EN}" 
        ${EndIf}
	${EndIf}
FunctionEnd

Function txtInstDir_TextChanged
	${NSD_GetText} $txtInstDir $installPath
	;���»�ȡ���̿ռ�
	Call UpdateFreeSpace
	;·���Ƿ�Ϸ�(�Ϸ���Ϊ0Bytes)
	; MessageBox  MB_OK $FreeSpaceSize
	${If} $FreeSpaceSize == "0Bytes"
		EnableWindow $btnBack 0 ;��ָ���Ĵ��ڻ�ؼ��Ƿ���������0��ֹ
		EnableWindow $btnInstallNow 0	
	${Else}
		EnableWindow $btnBack 1 ;��ָ���Ĵ��ڻ�ؼ��Ƿ���������0��ֹ
		EnableWindow $btnInstallNow 1
	${EndIf}
	${GetRoot} "$installPath" $R3   ;��ȡ��װ��Ŀ¼
	${If} "$installPath" == "$R3"
	${OrIf} "$installPath" == "$R3\"
	${OrIf} "$installPath" == "$R3\\"
	${OrIf} "$installPath" == "$R3\\\"
		EnableWindow $btnBack 0 ;��ָ���Ĵ��ڻ�ؼ��Ƿ���������0��ֹ
		EnableWindow $btnInstallNow 0	
	${Else}
		EnableWindow $btnBack 1 ;��ָ���Ĵ��ڻ�ؼ��Ƿ���������0��ֹ
		EnableWindow $btnInstallNow 1
	${EndIf}
FunctionEnd

Function btnInstall_Click
     
	 Call OldCheck
	 Sleep 50

	${NSD_GetText} $txtInstDir $installPath  ;������õİ�װ·��
	;�ж�Ŀ¼�Ƿ���ȷ
	ClearErrors
	CreateDirectory "$installPath"
	IfErrors 0 +3
		MessageBox MB_ICONINFORMATION|MB_OK " $(MSG_INSTALL_DIR_NOT_EXIT)"
		Return
	StrCpy $INSTDIR $installPath  ;���氲װ·��

	Call UpdateFreeSpace ; ��ȡ���̿ռ�
	${If} $freeSpaceUnit != "GB"
		MessageBox MB_ICONINFORMATION|MB_OK " $(MSG_INSTALL_SPACE_NOT_ENOUGH)"
		Return
	${EndIf}

	StrCpy $R9 1 ;Goto the next page
	Call RelGotoPage
	Abort
FunctionEnd

Function btnBack_Click
ShowWindow $bgImage1 ${SW_HIDE}

ShowWindow $bgImage ${SW_SHOW}
ShowWindow $chkLicense ${SW_SHOW}
ShowWindow $licenseLink ${SW_SHOW}
ShowWindow $btnQuick ${SW_SHOW}
ShowWindow $btnCustom ${SW_SHOW}

ShowWindow $bgImage1 ${SW_HIDE}
ShowWindow $btnInstallNow ${SW_HIDE}
ShowWindow $btnBack ${SW_HIDE}
ShowWindow $chkDesktopLnk ${SW_HIDE}
; ShowWindow $chkAddQuickLaunch ${SW_HIDE}
ShowWindow $chkStartUp ${SW_HIDE}
ShowWindow $btnBrowse ${SW_HIDE}
ShowWindow $txtInstDir ${SW_HIDE}
FunctionEnd

Function chkLicense_Click
	${NSD_GetState} $chkLicense $5
	${If} $5 == ${BST_CHECKED}
		EnableWindow $btnQuick 1 ;��ָ���Ĵ��ڻ�ؼ��Ƿ���������0��ֹ
		EnableWindow $btnCustom 1
	${Else}
		EnableWindow $btnQuick 0 ;��ָ���Ĵ��ڻ�ؼ��Ƿ���������0��ֹ
		EnableWindow $btnCustom 0
	${EndIf}
	
FunctionEnd

;����Э��
Function licenseLink_Click
	ShowWindow $chkLicense ${SW_HIDE}
	ShowWindow $licenseLink ${SW_HIDE}
	ShowWindow $btnQuick ${SW_HIDE}
	ShowWindow $btnCustom ${SW_HIDE}

	ShowWindow $rtfLicense ${SW_SHOW}
	ShowWindow $btnLicenseBack ${SW_SHOW}
FunctionEnd

Function UpdateFreeSpace
  ${GetRoot} $installPath $0
  StrCpy $1 "Bytes"

  System::Call kernel32::GetDiskFreeSpaceEx(tr0,*l,*l,*l.r0)
   ${If} $0 > 1024
   ${OrIf} $0 < 0
      System::Int64Op $0 / 1024
      Pop $0
      StrCpy $1 "KB"
      ${If} $0 > 1024
      ${OrIf} $0 < 0
     System::Int64Op $0 / 1024
     Pop $0
     StrCpy $1 "MB"
     ${If} $0 > 1024
     ${OrIf} $0 < 0
        System::Int64Op $0 / 1024
        Pop $0
        StrCpy $1 "GB"
     ${EndIf}
      ${EndIf}
   ${EndIf}

   StrCpy $freeSpaceSize  "$0$1"
   StrCpy $freeSpaceUnit "$1"
FunctionEnd

;��������
Function btnExpress_Click
    Exec "$INSTDIR\${MAIN_APP_NAME}"
    SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd

Function btnFinish_Click
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd

;��ɰ�װҳ��ر�
Function btnEnd_Click
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd

Function GetNetFrameworkVersion
	;��ȡ.Net Framework�汾֧��
	Push $1
	Push $0
	ReadRegDWORD $0 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" "Install"
	ReadRegStr $1 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" "Version"
	StrCmp $0 1 KnowNetFrameworkVersion +1
	ReadRegDWORD $0 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5" "Install"
	ReadRegStr $1 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5" "Version"
	StrCmp $0 1 KnowNetFrameworkVersion +1
	ReadRegDWORD $0 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup" "InstallSuccess"
	ReadRegStr $1 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup" "Version"
	StrCmp $0 1 KnowNetFrameworkVersion +1
	ReadRegDWORD $0 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727" "Install"
	ReadRegStr $1 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727" "Version"
	StrCmp $1 "" +1 +2
	StrCpy $1 "2.0.50727.832"
	StrCmp $0 1 KnowNetFrameworkVersion +1
	ReadRegDWORD $0 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.1.4322" "Install"
	ReadRegStr $1 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.1.4322" "Version"
	StrCmp $1 "" +1 +2
	StrCpy $1 "1.1.4322.573"
	StrCmp $0 1 KnowNetFrameworkVersion +1
	ReadRegDWORD $0 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\.NETFramework\policy\v1.0" "Install"
	ReadRegStr $1 "${PRODUCT_UNINST_ROOT_KEY}" "SOFTWARE\Microsoft\.NETFramework\policy\v1.0" "Version"
	StrCmp $1 "" +1 +2
	StrCpy $1 "1.0.3705.0"
	StrCmp $0 1 KnowNetFrameworkVersion +1
	StrCpy $1 "not .NetFramework"
	KnowNetFrameworkVersion:
	Pop $0
	Exch $1
FunctionEnd

Function DownloadNetFramework462
	;���� .NET Framework 4.6.2
	nsisdl::download /TRANSLATE2 '$(MSG_IS_DOWNLOADING) %s' '$(MSG_ARE_CONNECTED)...' '($(MSG_REMAINNING) 1 $(MSG_THE_SECONDS))' '($(MSG_REMAINNING)1 $(MSG_THE_MINUTES))' '($(MSG_REMAINNING) 1 $(MSG_THE_HOURS))' '((MSG_REMAINNING) %u $(MSG_THE_SECONDS))' '($(MSG_REMAINNING) %u $(MSG_THE_MINUTES))' '($(MSG_REMAINNING) %u $(MSG_THE_HOURS))' \ 
		'$(MSG_HAS_COMPLETED)��%sKB(%d%%) $(MSG_THE_SIZE)��%sKB $(MSG_THE_SPEED)��%u.%01uKB/s' /TIMEOUT=120000 /NOIEPROXY \ 
		'https://download.microsoft.com/download/F/9/4/F942F07D-F26F-4F30-B4E3-EBD54FABA377/NDP462-KB3151800-x86-x64-AllOS-ENU.exe' \ 
		'$TEMP\NDP462-KB3151800-x86-x64-AllOS-ENU.exe'
	Pop $R0 ;Get the return value
		StrCmp $R0 "success" +3
			MessageBox MB_OK "$(MSG_DOWNLOAD_FAILED): $R0"
			Quit
	SetDetailsPrint textonly
	DetailPrint "$(MSG_NOW_INSTALLING) .NET Framework 4.6.2 ..."
	SetDetailsPrint none
	ExecWait '$TEMP\NDP462-KB3151800-x86-x64-AllOS-ENU.exe /q /norestart' $R1
	Delete "$TEMP\NDP462-KB3151800-x86-x64-AllOS-ENU.exe"
 
FunctionEnd


Function un.onInit
	;���������ֹ�ظ�����
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "OcsChatUninstall") i .r1 ?e'
	Pop $R1
	StrCmp $R1 0 +3
		MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "$(MSG_UNINSTALL_RUNNING)"
		Abort

	;����Ƿ���������
	RETRY:
	;FindProcDLL::FindProc "${MAIN_APP_NAME}" ;�������н�������
	killer::IsProcessRunning "${MAIN_APP_NAME}" ;�������н�������
	StrCmp $R0 1 0 +3
		MessageBox MB_RETRYCANCEL|MB_ICONINFORMATION|MB_TOPMOST '$(MSG_DETECTED) ${PRODUCT_NAME} $(MSG_IS_RUNNING) $(MSG_CLOSE_AND_TRY)' IDRETRY RETRY
		Abort
FunctionEnd


