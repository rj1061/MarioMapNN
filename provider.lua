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
  local map = readAll("./encoded/SMB-w1-l1_final.txt")
  local mapTensor = parseFile2D(map, 14, 199)
  local windowTensor = makeTensorWithWindows(mapTensor, 16, 14, 199)
  print(windowTensor:nDimension())
  print(windowTensor:size())
end
