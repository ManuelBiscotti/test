#############
# Notepad++ #

function Invoke-NotepadPlusPlus {
    # Dynamically retrieve the latest installer URL
    $rel = Invoke-RestMethod -Uri "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest" -Headers @{ 'User-Agent' = 'pwsh' }
    $asset = $rel.assets | Where-Object { $_.name -match "Installer\.x64\.exe$" } | Select-Object -First 1
    $url = $asset.browser_download_url
    
    $exe = "$env:TEMP\npp.Installer.x64.exe"
    
    Get-FileFromWeb -URL $url -File $exe -UseBasicParsing
    Start-Process -FilePath $exe -ArgumentList '/S' -Wait -PassThru

	# remove modern notepad		
	Get-AppxPackage -AllUsers *Microsoft.WindowsNotepad* | Remove-AppxPackage -AllUsers
	
	# remove legacy notepad
	# "Microsoft.Windows.Notepad.System~~~~0.0.1.0","Microsoft.Windows.Notepad~~~~0.0.1.0" | ForEach-Object { Remove-WindowsCapability -Online -Name $_ >$null 2>&1 }
	
	# notepad++ default file type associations		
	$MultilineComment = @"
Windows Registry Editor Version 5.00				

; Created by: Shawn Brink
; http://www.tenforums.com
; Tutorial: http://www.tenforums.com/tutorials/8703-default-file-type-associations-restore-windows-10-a.html
; enhanced by WillingMost7

[HKEY_CLASSES_ROOT\.txt]	
@="txtfile"	
"Content Type"="text/plain"	
"PerceivedType"="text"	
	
[HKEY_CLASSES_ROOT\.txt\PersistentHandler]	
@="{5e941d80-bf96-11cd-b579-08002b30bfeb}"	
	
[HKEY_CLASSES_ROOT\.txt\ShellNew]	
"ItemName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,\	
  6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,\	
  00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,2c,00,\	
  2d,00,34,00,37,00,30,00,00,00	
"NullFile"=""	
	
[-HKEY_CLASSES_ROOT\SystemFileAssociations\.txt]	
	
[HKEY_CLASSES_ROOT\SystemFileAssociations\.txt]	
"PerceivedType"="document"	
	
[-HKEY_CLASSES_ROOT\txtfile]	
	
[HKEY_CLASSES_ROOT\txtfile]	
@="Text Document"	
"EditFlags"=dword:00210000	
"FriendlyTypeName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,\	
  00,6f,00,6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,\	
  32,00,5c,00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,\	
  00,2c,00,2d,00,34,00,36,00,39,00,00,00	
	
[HKEY_CLASSES_ROOT\txtfile\DefaultIcon]	
@="C:\\Program Files\\Notepad++\\notepad++.exe,0"	
	
[HKEY_CLASSES_ROOT\txtfile\shell\open\command]	
@="\"C:\\Program Files\\Notepad++\\notepad++.exe\" \"%1\""	
	
[-HKEY_CLASSES_ROOT\txtfile\shell\print]	
	
[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt]	
	
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithList]	
	
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithProgids]	
"txtfile"=hex(0):	
	
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\UserChoice]	
"Hash"="hyXk/CpboWw="	
"ProgId"="txtfile"	
	
[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt]	
	
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt\UserChoice]	
"Hash"="FvJcqeZpmOE="	
"ProgId"="txtfile"	
	
[HKEY_CLASSES_ROOT\regfile\shell\edit\command]	
@="\"C:\\Program Files\\Notepad++\\notepad++.exe\" \"%1\""	
	
[-HKEY_CLASSES_ROOT\regfile\shell\print]	
	
[HKEY_CLASSES_ROOT\batfile\shell\edit\command]	
@="\"C:\\Program Files\\Notepad++\\notepad++.exe\" \"%1\""	
	
[-HKEY_CLASSES_ROOT\batfile\shell\print]	
	
[HKEY_CLASSES_ROOT\VBSFile\Shell\Edit\Command]	
@="\"C:\\Program Files\\Notepad++\\notepad++.exe\" \"%1\""	
	
[-HKEY_CLASSES_ROOT\VBSFile\Shell\Print]	
	
[HKEY_CLASSES_ROOT\cmdfile\shell\edit\command]	
@="\"C:\\Program Files\\Notepad++\\notepad++.exe\" \"%1\""	
	
[-HKEY_CLASSES_ROOT\cmdfile\shell\print]	
	
[-HKEY_CLASSES_ROOT\xbox-tcui]	
[-HKEY_CLASSES_ROOT\xboxmusic]
"@

	Set-Content -Path "$env:TEMP\NotepadPlusPlus.reg" -Value $MultilineComment -Force														
	Regedit.exe /S "$env:TEMP\NotepadPlusPlus.reg"	

	# create config for notepad ++
	$MultilineComment = @"
<?xml version="1.0" encoding="UTF-8" ?>
<NotepadPlus>
    <FindHistory nbMaxFindHistoryPath="10" nbMaxFindHistoryFilter="10" nbMaxFindHistoryFind="10" nbMaxFindHistoryReplace="10" matchWord="no" matchCase="no" wrap="yes" directionDown="yes" fifRecuisive="yes" fifInHiddenFolder="no" fifProjectPanel1="no" fifProjectPanel2="no" fifProjectPanel3="no" fifFilterFollowsDoc="no" fifFolderFollowsDoc="no" searchMode="0" transparencyMode="1" transparency="150" dotMatchesNewline="no" isSearch2ButtonsMode="no" regexBackward4PowerUser="no" bookmarkLine="no" purge="no">
        <Filter name="" />
        <Find name="" />
        <Find name="sharpening" />
        <Find name="sharpen" />
        <Find name="sharp" />
        <Replace name="" />
    </FindHistory>
    <History nbMaxFile="0" inSubMenu="no" customLength="-1" />
    <ProjectPanels>
        <ProjectPanel id="0" workSpaceFile="" />
        <ProjectPanel id="1" workSpaceFile="" />
        <ProjectPanel id="2" workSpaceFile="" />
    </ProjectPanels>
    <ColumnEditor choice="number">
        <text content="" />
        <number initial="-1" increase="-1" repeat="-1" formatChoice="dec" leadingChoice="none" />
    </ColumnEditor>
    <GUIConfigs>
        <GUIConfig name="ToolBar" visible="yes">small</GUIConfig>
        <GUIConfig name="StatusBar">show</GUIConfig>
        <GUIConfig name="TabBar" dragAndDrop="yes" drawTopBar="yes" drawInactiveTab="yes" reduce="yes" closeButton="yes" doubleClick2Close="no" vertical="no" multiLine="no" hide="no" quitOnEmpty="no" iconSetNumber="0" />
        <GUIConfig name="ScintillaViewsSplitter">vertical</GUIConfig>
        <GUIConfig name="UserDefineDlg" position="undocked">hide</GUIConfig>
        <GUIConfig name="TabSetting" replaceBySpace="no" size="4" />
        <GUIConfig name="AppPosition" x="148" y="77" width="1234" height="773" isMaximized="no" />
        <GUIConfig name="FindWindowPosition" left="460" top="338" right="1074" bottom="702" isLessModeOn="no" />
        <GUIConfig name="FinderConfig" wrappedLines="no" purgeBeforeEverySearch="no" showOnlyOneEntryPerFoundLine="yes" />
        <GUIConfig name="noUpdate" intervalDays="15" nextUpdateDate="20250326">yes</GUIConfig>
        <GUIConfig name="Auto-detection">yes</GUIConfig>
        <GUIConfig name="CheckHistoryFiles">no</GUIConfig>
        <GUIConfig name="TrayIcon">no</GUIConfig>
        <GUIConfig name="MaintainIndent">yes</GUIConfig>
        <GUIConfig name="TagsMatchHighLight" TagAttrHighLight="yes" HighLightNonHtmlZone="no">yes</GUIConfig>
        <GUIConfig name="RememberLastSession">no</GUIConfig>
        <GUIConfig name="KeepSessionAbsentFileEntries">no</GUIConfig>
        <GUIConfig name="DetectEncoding">yes</GUIConfig>
        <GUIConfig name="SaveAllConfirm">yes</GUIConfig>
        <GUIConfig name="NewDocDefaultSettings" format="0" encoding="4" lang="0" codepage="-1" openAnsiAsUTF8="yes" addNewDocumentOnStartup="no" />
        <GUIConfig name="langsExcluded" gr0="0" gr1="0" gr2="0" gr3="0" gr4="0" gr5="0" gr6="0" gr7="0" gr8="0" gr9="0" gr10="0" gr11="0" gr12="0" langMenuCompact="yes" />
        <GUIConfig name="Print" lineNumber="yes" printOption="3" headerLeft="" headerMiddle="" headerRight="" footerLeft="" footerMiddle="" footerRight="" headerFontName="" headerFontStyle="0" headerFontSize="0" footerFontName="" footerFontStyle="0" footerFontSize="0" margeLeft="0" margeRight="0" margeTop="0" margeBottom="0" />
        <GUIConfig name="Backup" action="0" useCustumDir="no" dir="" isSnapshotMode="no" snapshotBackupTiming="7000" />
        <GUIConfig name="TaskList">yes</GUIConfig>
        <GUIConfig name="MRU">yes</GUIConfig>
        <GUIConfig name="URL">0</GUIConfig>
        <GUIConfig name="uriCustomizedSchemes">svn:// cvs:// git:// imap:// irc:// irc6:// ircs:// ldap:// ldaps:// news: telnet:// gopher:// ssh:// sftp:// smb:// skype: snmp:// spotify: steam:// sms: slack:// chrome:// bitcoin:</GUIConfig>
        <GUIConfig name="globalOverride" fg="no" bg="no" font="no" fontSize="no" bold="no" italic="no" underline="no" />
        <GUIConfig name="auto-completion" autoCAction="3" triggerFromNbChar="1" autoCIgnoreNumbers="yes" insertSelectedItemUseENTER="yes" insertSelectedItemUseTAB="yes" autoCBrief="no" funcParams="yes" />
        <GUIConfig name="auto-insert" parentheses="no" brackets="no" curlyBrackets="no" quotes="no" doubleQuotes="no" htmlXmlTag="no" />
        <GUIConfig name="sessionExt"></GUIConfig>
        <GUIConfig name="workspaceExt"></GUIConfig>
        <GUIConfig name="MenuBar">show</GUIConfig>
        <GUIConfig name="Caret" width="1" blinkRate="600" />
        <GUIConfig name="openSaveDir" value="0" defaultDirPath="" lastUsedDirPath="" />
        <GUIConfig name="titleBar" short="no" />
        <GUIConfig name="insertDateTime" customizedFormat="yyyy-MM-dd HH:mm:ss" reverseDefaultOrder="no" />
        <GUIConfig name="wordCharList" useDefault="yes" charsAdded="" />
        <GUIConfig name="delimiterSelection" leftmostDelimiter="40" rightmostDelimiter="41" delimiterSelectionOnEntireDocument="no" />
        <GUIConfig name="largeFileRestriction" fileSizeMB="200" isEnabled="yes" allowAutoCompletion="no" allowBraceMatch="no" allowSmartHilite="no" allowClickableLink="no" deactivateWordWrap="yes" suppress2GBWarning="no" />
        <GUIConfig name="multiInst" setting="0" clipboardHistory="no" documentList="no" characterPanel="no" folderAsWorkspace="no" projectPanels="no" documentMap="no" fuctionList="no" pluginPanels="no" />
        <GUIConfig name="MISC" fileSwitcherWithoutExtColumn="no" fileSwitcherExtWidth="50" fileSwitcherWithoutPathColumn="yes" fileSwitcherPathWidth="50" fileSwitcherNoGroups="no" backSlashIsEscapeCharacterForSql="yes" writeTechnologyEngine="1" isFolderDroppedOpenFiles="no" docPeekOnTab="no" docPeekOnMap="no" sortFunctionList="no" saveDlgExtFilterToAllTypes="no" muteSounds="no" enableFoldCmdToggable="no" hideMenuRightShortcuts="no" />
        <GUIConfig name="Searching" monospacedFontFindDlg="no" fillFindFieldWithSelected="yes" fillFindFieldSelectCaret="yes" findDlgAlwaysVisible="no" confirmReplaceInAllOpenDocs="yes" replaceStopsWithoutFindingNext="no" inSelectionAutocheckThreshold="1024" />
        <GUIConfig name="searchEngine" searchEngineChoice="2" searchEngineCustom="" />
        <GUIConfig name="MarkAll" matchCase="no" wholeWordOnly="yes" />
        <GUIConfig name="SmartHighLight" matchCase="no" wholeWordOnly="yes" useFindSettings="no" onAnotherView="no">yes</GUIConfig>
        <GUIConfig name="DarkMode" enable="yes" colorTone="0" customColorTop="2105376" customColorMenuHotTrack="4210752" customColorActive="4210752" customColorMain="2105376" customColorError="176" customColorText="14737632" customColorDarkText="12632256" customColorDisabledText="8421504" customColorLinkText="65535" customColorEdge="6579300" customColorHotEdge="10197915" customColorDisabledEdge="4737096" enableWindowsMode="no" darkThemeName="DarkModeDefault.xml" darkToolBarIconSet="0" darkTabIconSet="2" darkTabUseTheme="no" lightThemeName="" lightToolBarIconSet="4" lightTabIconSet="0" lightTabUseTheme="yes" />
        <GUIConfig name="ScintillaPrimaryView" lineNumberMargin="show" lineNumberDynamicWidth="yes" bookMarkMargin="show" indentGuideLine="show" folderMarkStyle="box" isChangeHistoryEnabled="1" lineWrapMethod="aligned" currentLineIndicator="1" currentLineFrameWidth="1" virtualSpace="no" scrollBeyondLastLine="yes" rightClickKeepsSelection="no" disableAdvancedScrolling="no" wrapSymbolShow="hide" Wrap="no" borderEdge="yes" isEdgeBgMode="no" edgeMultiColumnPos="" zoom="4" zoom2="0" whiteSpaceShow="hide" eolShow="hide" eolMode="1" npcShow="hide" npcMode="1" npcCustomColor="no" npcIncludeCcUniEOL="no" npcNoInputC0="yes" ccShow="yes" borderWidth="2" smoothFont="no" paddingLeft="0" paddingRight="0" distractionFreeDivPart="4" lineCopyCutWithoutSelection="yes" multiSelection="yes" columnSel2MultiEdit="yes" />
        <GUIConfig name="DockingManager" leftWidth="200" rightWidth="200" topHeight="200" bottomHeight="200">
            <ActiveTabs cont="0" activeTab="-1" />
            <ActiveTabs cont="1" activeTab="-1" />
            <ActiveTabs cont="2" activeTab="-1" />
            <ActiveTabs cont="3" activeTab="-1" />
        </GUIConfig>
    </GUIConfigs>
</NotepadPlus>
"@
	Set-Content -Path "$env:AppData\Notepad++\config.xml" -Value $MultilineComment -Force
}