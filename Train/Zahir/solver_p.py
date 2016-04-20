from __future__ import division
import sys

caffe_root = '../../caffe/'
sys.path.insert(0, caffe_root + 'python')

import caffe
import numpy as np
import os

# init
caffe.set_mode_gpu()
caffe.set_device(0)

# caffe.set_mode_cpu()

solver = caffe.SGDSolver('solver_project.prototxt')
solver.net.copy_from('/scratch/16824/models/bvlc_reference_caffenet.caffemodel')

niter = 30000
train_loss = np.zeros(niter)

f = open('log.txt', 'w')

for it in range(niter): 
    solver.step(1)
    train_loss[it] = solver.net.blobs['loss'].data
    f.write('{0: f}\n'.format(train_loss[it]))

    if it % 20 == 0:
        f.flush()
        os.fsync(f)

f.close()

# solver.step(80000)


