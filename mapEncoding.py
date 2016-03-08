readPrefix = './original/'
writePrefix = './encoded/'

filenames = ['SMB-w1-l1_final.txt',
             'SMB-w1-l2_final.txt',
             'SMB-w1-l3_final.txt',
             'SMB-w2-l1_final.txt',
             'SMB-w2-l3_final.txt',
             'SMB-w3-l1_final.txt',
             'SMB-w3-l2_final.txt',
             'SMB-w3-l3_final.txt',
             'SMB-w4-l1_final.txt',
             'SMB-w4-l2_final.txt',
             'SMB-w4-l3_final.txt',
             'SMB-w5-l1_final.txt',
             'SMB-w5-l2_final.txt',
             'SMB-w5-l3_final.txt',
             'SMB-w6-l1_final.txt',
             'SMB-w6-l2_final.txt',
             'SMB-w6-l3_final.txt',
             'SMB-w7-l1_final.txt',
             'SMB-w7-l3_final.txt',
             'SMB-w8-l1_final.txt',
             'SMB-w8-l2_final.txt',
             'SMB-w8-l3_final.txt',
	]

noOfFiles = 22

def encodeMap(filename):
  originalmap = open(readPrefix + filename, 'r')
  mapContent = originalmap.read()
  newcontent = ''
  for character in mapContent:
    if character == '[':
      newcontent += ''
    elif character == ']':
      newcontent += ''
    elif character == '0':
      newcontent += '0'
    elif character == '\n':
      newcontent += '\n'
    elif character == '\r':
      newcontent+= '\n'
    elif character == '#':
      continue
    elif character == 'F':
      continue
    else:
      newcontent += '1'
  encodedMap = open(writePrefix + filename, 'w')
  encodedMap.write(newcontent)
  return

for i in range(0, noOfFiles):
  encodeMap(filenames[i])
