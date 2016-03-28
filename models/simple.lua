require 'nn'
require 'cunn'

local simple = nn.Sequential()

simple:add(nn.Reshape(14*16))
simple:add(nn.Linear(16*14, 16*14))
simple:add(nn.Linear(16*14, 16*14))
simple:add(nn.Reshape(14*16))

return simple
