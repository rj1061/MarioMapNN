require 'xlua'
require 'optim'
require 'cunn'
dofile './provider.lua'

model = nn.Sequential()

model:add(nn.Reshape(14*16))
model:add(nn.Linear(14*16, 14*16))
model:add(nn.Linear(14*16, 14*16))
model:add(nn.Reshape(14, 16))
print(model)

provider = torch.load 'provider.t7'
provider.trainData = provider.trainData:float()
if provider.trainData == nil then print("Data is nil") end

parameters,gradParameters = model:getParameters()

criterion = nn.MSECriterion()
criterion.sizeAverage = false

max_epoch = 20

for i=1,max_epoch do
  for j = 1, 4102 do
    local input= provider.trainData[j];
    local output= provider.trainData[j];

  -- feed it to the neural network and the criterion
    criterion:forward(model:forward(input), output)

  -- train over this example in 3 steps
  -- (1) zero the accumulation of the gradients
--    model:zeroGradParameters()
  -- (2) accumulate gradients
    model:backward(input, criterion:backward(model.output, output))
  -- (3) update parameters with a 0.01 learning rate
    model:updateParameters(0.01)
  end
end

print(provider.trainData[1])
print(model:forward(provider.trainData[1]))
