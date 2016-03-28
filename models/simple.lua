require 'nn'

local simple = nn.Sequential()

simple:add(nn.Linear(16*14, 20))
simple:add(nn.Linear(20, 16*14))

return simple
