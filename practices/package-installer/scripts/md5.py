#-*-coding:utf-8-*-  
''''' 
'''    
import hashlib  
import os  
import sys  
import json
          
def createMD5(filePath):    
  if not os.path.isfile(filePath):  
    return ""
  else:  
    tmpLength = 1024  
    m = hashlib.md5()  
    with open(filePath, 'rb') as f:  
      b = f.read(tmpLength)  
      while b != b'':  
        m.update(b)  
        b = f.read(tmpLength)
      md5_text = m.hexdigest().upper()
      print(filePath, ' MD5:\t', md5_text)
      return md5_text

def generateMD5Path(path):
  lenRootPath =  len(path)
  md5_dict = {}
  for root, dirs, files in os.walk(path):
    for name in files:
      if (name.endswith(".exe") and name != "md5.exe")or name.endswith(".diff") or name.endswith(".7z"):
        filePath = os.path.join(path, name)
        md5_text =createMD5(filePath)
        if md5_text != "":
          md5_dict[name] = md5_text
  return md5_dict

if __name__ == '__main__':  
    if 2 != len(sys.argv):  
        path = ".\\"  
    else:  
        path = sys.argv[1]   
    md5_json = json.dumps(generateMD5Path(path), indent=2)
    print(md5_json)
    with open(os.path.join(path,"md5.json"), "w") as json_file:
      json_file.write(md5_json)
      json_file.close()
