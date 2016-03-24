require 'nn'
require 'image'
require 'xlua'

torch.setdefaulttensortype('torch.FloatTensor')

function parseFile2D(f, height, width)
  local tensor = torch.FloatTensor(height, width)
  local index = 1
  for i=1,height do
    local j = 1
    while string.sub(f, index, index)~="\n" do
      if string.sub(f, index, index)=="0" then tensor[i][j] = 0
      else tensor[i][j] = 1 end
      index = index + 1
      j = j + 1
    end
    index = index + 1
  end
  return tensor
end

function readAll(file)
  local f = io.open(file, "r")
  local content = f:read("*all")
  f:close()
  return content
end

function makeTensorWithWindows(f, windowSize, height, width)
  local windows = width - windowSize + 1
  totalwindows = totalwindows + windows
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

function getTrainingSet()
  local windowSize = 16
  totalwindows = 0
  local WT1 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w1-l1_final.txt"), 14, 199), windowSize, 14, 199)
  local WT2 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w1-l2_final.txt"), 14, 166), windowSize, 14, 166)
  local WT3 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w1-l3_final.txt"), 14, 153), windowSize, 14, 153)
  local WT4 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w2-l1_final.txt"), 14, 201), windowSize, 14, 201)
  local WT5 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w2-l3_final.txt"), 14, 226), windowSize, 14, 226)
  local WT6 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w3-l1_final.txt"), 14, 201), windowSize, 14, 201)
  local WT7 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w3-l2_final.txt"), 14, 210), windowSize, 14, 210)
  local WT8 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w3-l3_final.txt"), 14, 152), windowSize, 14, 152)
  local WT9 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w4-l1_final.txt"), 14, 226), windowSize, 14, 226)
  local WT10 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w4-l2_final.txt"), 14, 187), windowSize, 14, 187)
  local WT11 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w4-l3_final.txt"), 14, 148), windowSize, 14, 148)
  local WT12 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w5-l1_final.txt"), 14, 206), windowSize, 14, 206)
  local WT13 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w5-l2_final.txt"), 14, 201), windowSize, 14, 201)
  local WT14 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w5-l3_final.txt"), 14, 153), windowSize, 14, 153)
  local WT15 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w6-l1_final.txt"), 14, 187), windowSize, 14, 187)
  local WT16 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w6-l2_final.txt"), 14, 233), windowSize, 14, 233)
  local WT17 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w6-l3_final.txt"), 14, 168), windowSize, 14, 168)
  local WT18 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w7-l1_final.txt"), 14, 180), windowSize, 14, 180)
  local WT19 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w7-l3_final.txt"), 14, 226), windowSize, 14, 226)
  local WT20 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w8-l1_final.txt"), 14, 377), windowSize, 14, 377)
  local WT21 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w8-l2_final.txt"), 14, 217), windowSize, 14, 217)
  local WT22 = makeTensorWithWindows(parseFile2D(readAll("./encoded/SMB-w8-l3_final.txt"), 14, 215), windowSize, 14, 215)

  local trainingSet = torch.FloatTensor(totalwindows, 14, windowSize)
  trainingSet = torch.cat(WT1, WT2, 1):cat(WT3, 1):cat(WT4, 1):cat(WT5, 1):cat(WT6, 1):cat(WT7, 1):cat(WT8, 1):cat(WT9, 1):cat(WT10, 1):cat(WT11, 1):cat(WT12, 1):cat(WT13, 1):cat(WT14, 1):cat(WT15, 1):cat(WT16, 1):cat(WT17, 1):cat(WT18, 1):cat(WT19, 1):cat(WT20, 1):cat(WT21, 1):cat(WT22, 1)
  return trainingSet
end

function Provider:__init(full)
  return getTrainingSet()
end
