# generate language text id

`src\tools\grit` `manual-id.py`
```py
from grit.extern.tclib import GenerateMessageId

while(True):
    messageStr =input("请输入信息字符串：")
    print("所输入信息字符串：", messageStr)
    print("所输入信息字符串ID：", GenerateMessageId(messageStr))
```
