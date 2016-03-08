require 'nn'
require 'image'
require 'xlua'

torch.setdefaulttensortype('torch.FloatTensor')

function parseFile2D(f, height, width)
  local t = torch.FloatTensor(height, width)
  local index = 1
  for i=1,height do
    local j = 1
    while string.sub(f, index, index)~="\n" do
      if string.sub(f, index, index)=="0" then t[i][j] = 0
      else t[i][j] = 1 end
      index = index + 1
      j = j + 1
    end
    index = index + 1
  end
  return t
end

function readAll(file)
  local f = io.open(file, "r")
  local content = f:read("*all")
  f:close()
  return content
end

function makeTensorWithWindows(f, windowSize, height, width)
  local windows = width - windowSize + 1
  local t = torch.FloatTensor(windows, height, windowSize)
  for w=1,windows do
    for l=1,windowSize do
      for h=1,height do
        t[w][h][l] = f[h][(w+l-1)]
      end
    end
  end
  return t
end

local Provider = torch.class 'Provider'

function Provider:__init(full)
  local windowSize = 16
  local wT1 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w1-l1_final.txt"), 14, 199), windowSize, 14, 199)
  local wT2 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w1-l2_final.txt"), 14, 166), windowSize, 14, 166)
  local wT3 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w1-l3_final.txt"), 14, 153), windowSize, 14, 153)
  local wT4 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w2-l1_final.txt"), 14, 201), windowSize, 14, 201)
  local wT5 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w2-l3_final.txt"), 14, 226), windowSize, 14, 226)
  local wT6 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w3-l1_final.txt"), 14, 201), windowSize, 14, 201)
  local wT7 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w3-l2_final.txt"), 14, 210), windowSize, 14, 210)
  local wT8 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w3-l3_final.txt"), 14, 152), windowSize, 14, 152)
  local wT9 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w4-l1_final.txt"), 14, 226), windowSize, 14, 226)
  local wT10 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w4-l2_final.txt"), 14, 187), windowSize, 14, 187)
  local wT11 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w4-l3_final.txt"), 14, 148), windowSize, 14, 148)
  local wT12 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w5-l1_final.txt"), 14, 206), windowSize, 14, 206)
  local wT13 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w5-l2_final.txt"), 14, 201), windowSize, 14, 201)
  local wT14 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w5-l3_final.txt"), 14, 153), windowSize, 14, 153)
  local wT15 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w6-l1_final.txt"), 14, 187), windowSize, 14, 187)
  local wT16 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w6-l2_final.txt"), 14, 233), windowSize, 14, 233)
  local wT17 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w6-l3_final.txt"), 14, 168), windowSize, 14, 168)
  local wT18 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w7-l1_final.txt"), 14, 180), windowSize, 14, 180)
  local wT19 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w7-l3_final.txt"), 14, 226), windowSize, 14, 226)
  local wT20 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w8-l1_final.txt"), 14, 377), windowSize, 14, 377)
  local wT21 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w8-l2_final.txt"), 14, 217), windowSize, 14, 217)
  local wT22 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w8-l3_final.txt"), 14, 215), windowSize, 14, 215)
end
