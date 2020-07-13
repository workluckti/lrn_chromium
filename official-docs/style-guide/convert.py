import tomd

htmlFile = open(r'./style-language-gn.md','r',encoding='utf-8')
htmlTextLines = htmlFile.readlines()
htmlText = ''
for lineText in htmlTextLines:
    htmlText = htmlText + lineText
htmlFile.close

markdownText = tomd.convert(htmlText)

markdownFile = open(r"./language-gn..md",'w',encoding='utf-8')
markdownFile.write(markdownText)
markdownFile.close