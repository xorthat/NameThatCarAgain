import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
from pprint import pprint
from numpy.random import choice
from scipy.spatial.distance import cdist

# Make sure that caffe is on the python path:
caffe_root = '../../caffe/'  # this file is expected to be in {caffe_root}/examples
import sys
sys.path.insert(0, caffe_root + 'python')

import caffe

test_listfile = '/scratch/16824/data/testlist_class.txt'
result_file = 'cls_results.txt'

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
fnames = []
lsize = net.blobs['fc7'].data.shape
wholeset = []

for i in range(batch_count):

    out = net.forward()
    data = net.blobs['fc7'].data
    print(data)
    for j in range(batch_size):
        id = i * batch_size + j
        if id >= data_counts:
            break

        fname = test_list[id].split(' ')[0]
        fnames.append(fname)

        wholeset.append(np.copy(data[j,:].reshape((1,lsize[1]))))

wholeset = np.concatenate(tuple(wholeset))

files = ['NN_1/', 'NN_2/', 'NN_3/']
imgsIds = choice(len(fnames), len(files))
imgFeats = wholeset[imgsIds, :]
dists = cdist(imgFeats, wholeset, 'cosine')

sortids = np.argsort(dists, axis=1)
sorts = np.sort(dists, axis=1)


for i in range(len(files)):
    print("Image {0}: {1}".format(i+1, fnames[imgsIds[i]]))
    for j in range(11): #sortids[i,0:10]:
        print("NN {0} at {2}: {1}".format(j, fnames[sortids[i,j]], dists[i,int(sortids[i,j])]))

        img = Image.open('/scratch/16824/data/crop_imgs/'+fnames[sortids[i,j]])
        img.save(files[i]+'nn'+str(j)+'.jpg')
