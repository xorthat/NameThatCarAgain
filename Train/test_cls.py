import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
from pprint import pprint

# Make sure that caffe is on the python path:
caffe_root = '../../caffe/'  # this file is expected to be in {caffe_root}/examples
import sys
sys.path.insert(0, caffe_root + 'python')

import caffe

test_listfile = '/scratch/16824/data/testlist_both.txt'
result_file = 'joint_results.txt'

caffe.set_device(0)
caffe.set_mode_gpu()
net = caffe.Net('/home/sbokhari/assignment1/py_scripts/train_val_p7.prototxt',
                '/home/sbokhari/assignment1/py_scripts/models/model_p7.caffemodel',
                caffe.TEST)

test_list = np.loadtxt(test_listfile,  str, comments=None, delimiter='\n')
data_counts = len(test_list)
batch_size = net.blobs['data'].data.shape[0]
batch_count = int(np.ceil(data_counts * 1.0 / batch_size))

accuracy = 0

f = open(result_file, 'w')
print(batch_count)
for i in range(batch_count):

    out = net.forward()
    print(out.keys())
    prop = out['fc8_box']
    predclass = out['pred_class']
    for j in range(batch_size):
        id = i * batch_size + j
        if id >= data_counts:
            break

        lbl = int(test_list[id].split(' ')[1])
        fname = test_list[id].split(' ')[0]

        im = Image.open('/scratch/16824/data/crop_imgs/'+fname)
        (W,H) = im.size
        f.write(fname)
        f.write(" {0} {1} {2} {3} {4}".format(predclass[j].argmax(), W*prop[j][0], H*prop[j][1], W*prop[j][2], H*prop[j][3]))
        f.write('\n')

f.close()

print accuracy
