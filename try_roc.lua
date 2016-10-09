require 'torch'
metrics = require 'metrics'
--gfx = require 'gfx.js'

resp = torch.DoubleTensor { -0.9, -0.8, -0.8, -0.5, -0.1, 0.0, 0.2, 0.2, 0.51, 0.74, 0.89}
labels = torch.IntTensor  { -1, -1 , 1, -1, -1, 1, 1, -1, -1, 1, 1 }

roc_points, thresholds = metrics.roc.points(resp, labels)
area = metrics.roc.area(roc_points)

print(area)

--gfx.chart(roc_points)

require 'gnuplot'
gnuplot.plot(roc_points)
