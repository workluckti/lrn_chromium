import os
import sys
import ctypes
import shutil
import re
import threading
  
def printHelp():
  print("-help(h): print this help text")
  print("-platform(pt): package platform: 64 or 86")
  print("-version(v): package version. Like X.X.X.X', e.g. -v 1.0.2..6")
  print('-srcRelease(sr): original chromium project src release path(no space), '
        'use to locate chrome.7z. e.g. -sr "E:\chromium-stl\src\out\Release_x64"')
  print("\n")

def parseArgv(argv, defaultCfgDict):
  nPara = len(argv)
  if nPara < 2:
    printHelp()
    return defaultCfgDict
  index = 1 # 0 is the file name: new.py
  cfgDict = defaultCfgDict
  while index < nPara:
    if '-version' == argv[index] or '-v' == argv[index]:
      index +=1
      if index >= nPara:
        print("InputErro: Please input the version numbers after -version or -v")
        return 
      else:
        cfgDict['version'] = argv[index]
    elif '-platform' == argv[index] or '-pt' == argv[index]:
      index +=1
      if index >= nPara:
        print("InputErro: Please input platform( 64 or 86) after -paltform or -pt")
        return
      else:
        cfgDict['platform'] = argv[index]
    elif '-src' == argv[index]:
      index +=1
      if index >= nPara:
        print("InputErro: Please input chromium project soruce path after -src")
        return
      else:
        cfgDict['srcPath'] = argv[index]
    elif '-sr' == argv[index] or '-srcRelease' == argv[index]:
      index +=1
      if index >= nPara:
        print("InputErro: Please input chromium project soruce path after -srcRelease or -sr")
        return
      else:
        cfgDict['srcReleasePath'] = argv[index]
    elif '-help' == argv[index] or '-h' == argv[index]:
      printHelp()
    else:
      print("InputErro: Please input right commond(can't contain space in each part):")
      printHelp()
      return 
    index +=1
  return cfgDict

class CmdThread (threading.Thread):
  cmd =""
  def __init__(self, cmd):
    threading.Thread.__init__(self)
    self.cmd = cmd
  def run(self):
      print ("Start Thread：")
      print ("runing cmd：" + self.cmd)
      print(os.getcwd())
      if self.cmd != "":
        os.system(self.cmd)
      print ("Exit Thread：")


class PackSoftware:

  version = "0.0.0.0"
  platform = "64"

  softwareName = "program"

  webkitVersion="78.0.3904.97"

  outPath = ".\\"
  releaseName = ""
  releasePath=""
  commonPath = ".\\common"
  updatePath =""
  exe7zaPath=".\\common\\7za.exe"
  exeSSRName="programService.exe"
  exeSSRPath = ""

  package7zPath = "..\\packages_7z"

  installerPath = "..\\installer"
  installer7zPath = "..\\installer\\bin\\update\\program.7z"
  exe7zrPath = "..\\installer\\tools\\7zr_x64.exe"
  exeCourgettePath = "..\\installer\\tools\\courgette_x64.exe"

  buildPath = "..\\build"
  exeMd5Path = "..\\build\\md5.exe"
  
  srcPath = "E:\\chromium-stl\\src"
  srcReleasePath = ""
  chrome7zPath=""

  cmdThreads = []

  def __init__(self, cfgDict):
    self.version = cfgDict['version']
    self.platform = cfgDict['platform']
    self.outPath = cfgDict['outPath']
    self.srcReleasePath = cfgDict['srcReleasePath']

  def initEnv(self):
    ''' init the path and variables'''
    self.releaseName = self.softwareName + "_"+self.version+"_x"+self.platform
    releaseFolder= self.releaseName + "_official"
    self.releasePath=os.path.join(self.outPath, releaseFolder)
    if (not os.path.exists(self.releasePath)):
      os.makedirs(self.releasePath, 0o754 )
    else:
      print("Path existed: ", self.releasePath)
    if self.srcReleasePath == "":
      self.chrome7zPath=os.path.join(self.srcPath, "out\\Release_x"+self.platform+"\\chrome.7z")
    else:
      self.chrome7zPath=os.path.join(self.srcReleasePath, "chrome.7z")
    self.updatePath = os.path.join(self.commonPath, "x"+self.platform+"\\Update")
    self.exeSSRPath = os.path.join(self.commonPath, self.exeSSRName)

  def Package7z(self):
    ''' generate the release 7z package from the chrome.7z'''
    if(not os.path.exists(self.chrome7zPath)):
      print("[ERROR] Can't find "+self.chrome7zPath)
      return
    if(not os.path.exists(self.exe7zaPath)):
      print("[ERROR] Can't find "+self.exe7zaPath)
      return
    # unzip chrome.7z
    unzipCmd = self.exe7zaPath+" x -y "+ self.chrome7zPath +" -o" + self.releasePath
    os.system(unzipCmd)
    # add SSR and Update
    chromebinPath = self.releasePath+"\\Chrome-bin"
    if(not os.path.exists(chromebinPath)):
      print("[ERROR] unzip Chrome.7z failded. Can't find " + chromebinPath)
      return
    exeSSRDstPath = os.path.join(chromebinPath, os.path.join(self.webkitVersion, self.exeSSRName))
    ## copy SSR
    if (os.path.exists(exeSSRDstPath)):
      os.remove(exeSSRDstPath)
    shutil.copyfile(self.exeSSRPath, exeSSRDstPath)
    ## copy Update
    updateDstPath = os.path.join(chromebinPath, "Update")
    if (os.path.exists(updateDstPath)):
      shutil.rmtree(updateDstPath)
    shutil.copytree(self.updatePath, updateDstPath)
    # replace language package en_US.pak by en_GB.pak
    enUSPakPath= os.path.join(chromebinPath, os.path.join(self.webkitVersion, "Locales\\en-US.pak"))
    enGBPakPath= os.path.join(chromebinPath, os.path.join(self.webkitVersion, "Locales\\en-GB.pak"))
    os.remove(enUSPakPath)
    shutil.copyfile(enGBPakPath, enUSPakPath)
    # zip Chrome-bin
    dst7zName = self.releaseName+".7z"
    dst7zPath = os.path.join(self.releasePath, dst7zName)
    zipCmd = self.exe7zrPath+ " a "+ dst7zPath+" " + chromebinPath+"\\**"
    os.system(zipCmd)
    # remove chrome-bin
    shutil.rmtree(chromebinPath)
    # copy 7z package to package_7z
    dst7zName = self.releaseName+".7z"
    package7zDstPath = os.path.join(self.package7zPath, dst7zName)
    if (os.path.exists(package7zDstPath)):
      os.remove(package7zDstPath)
    shutil.copyfile(dst7zPath, package7zDstPath)
  
  def generateVersionDiff(self):
    '''generate the diff files'''
    # get all 7z pacakge file name
    file7zDict ={}
    for dirpath, dirnames, filenames in os.walk(self.package7zPath):
      for file7z in filenames:
        if file7z == self.releaseName+".7z":
          continue
        strFile7z = self.softwareName +'_\d+.\d+.\d+.\d+_x'+self.platform+'.7z'
        strPattern = re.compile(strFile7z)
        if re.findall(strPattern,file7z):
          file7zVersion = file7z.split("_")[1]
          # print(file7zVersion, file7z)
          file7zDict[file7zVersion] = file7z
    # print(file7zDict)
    # generate diff file by courgette
    dst7zName = self.releaseName+".7z"
    file7zPath = os.path.abspath(os.path.join(self.package7zPath, dst7zName))
    for file7zVersion in file7zDict:
      # print(file7zVersion, file7zDict[file7zVersion])
      oldFile7zPath = os.path.abspath(os.path.join(self.package7zPath, file7zDict[file7zVersion]))
      fileDiffName = "patch_V"+file7zVersion+"_to_V"+self.version+"_x"+ self.platform+".diff"
      fileDiffPath  = os.path.abspath(os.path.join(self.releasePath, fileDiffName))
      exeCourgettePath = os.path.abspath(self.exeCourgettePath)
      file7zDiffCmd = exeCourgettePath + " -gen "+ oldFile7zPath + " " + file7zPath + " " + fileDiffPath
      thread = CmdThread(file7zDiffCmd)
      thread.start()
      self.cmdThreads.append(thread)

  def makeInstaller(self):
    '''make installer exe'''
    # copy 7z package from package_7z to installer bin
    dst7zName = self.releaseName+".7z"
    package7zSrcPath = os.path.join(self.package7zPath, dst7zName)
    if (os.path.exists(self.installer7zPath)):
      os.remove(self.installer7zPath)
    shutil.copyfile(package7zSrcPath, self.installer7zPath)
    makeInstallerCmd="makensis ..\\installer\\programNsis.nsi"
    os.system(makeInstallerCmd)
    # copy installer exe from build path to release path
    exeInstallerName = self.releaseName+".exe"
    exeInstallerPath = os.path.join(self.buildPath, exeInstallerName)
    exeInstallerDstPath = os.path.join(self.releasePath, exeInstallerName)
    if (os.path.exists(exeInstallerDstPath)):
      os.remove(exeInstallerDstPath)
    shutil.copyfile(exeInstallerPath, exeInstallerDstPath)

  def generateMd5(self):
    '''generate md5.json'''
    for thread in self.cmdThreads:
      thread.join()
    md5Cmd= self.exeMd5Path + " " + self.releasePath
    os.system(md5Cmd)

  def lastPackage(self):
    dst7zPath = os.path.join(self.outPath, self.releaseName+"_official.7z")
    lastCmd = self.exe7zaPath+ " a "+ dst7zPath+" " + self.releasePath
    os.system(lastCmd)

  def displayCfg(self):
    '''show the pacakage variables'''
    print("=================== pack configuration display start=============== ")
    print("           version: ", self.version)
    print("          platform: ", self.platform)
    print("     software name: ", self.softwareName)

    print("          out path: ", self.outPath)
    print("      release path: ", self.releasePath)
    print("      release name: ", self.releaseName)
    print("       common path: ", self.commonPath)
    print("      7za.exe path: ", self.exe7zaPath)
    print("          SSR path: ", self.exeSSRPath)

    print("      7zr.exe path: ", self.exe7zrPath)
    print("courgette.exe path: ", self.exeCourgettePath)

    print("    chrome.7z path: ", self.chrome7zPath)
    print("=================== pack configuration display end ================ ")


if __name__ == '__main__':
  nPara = len(sys.argv)
  if nPara < 3:
    printHelp()
    exit()

  defaultCfgDict = {
    'version':"0.0.0.0",
    'platform':"64",
    'outPath':".\\",
    'srcReleasePath':"E:\chromium-stl\src\out\Release_x64"
  }

  cfgDict = parseArgv(sys.argv, defaultCfgDict)

  packBrowser = PackSoftware(cfgDict)
  packBrowser.initEnv()
  packBrowser.displayCfg()

  packBrowser.Package7z()

  packBrowser.generateVersionDiff()

  packBrowser.makeInstaller()

  packBrowser.generateMd5()

  packBrowser.lastPackage()

