import numpy as np

# Make sure that caffe is on the python path:
caffe_root = '../caffe-master/'  # this file is expected to be in {caffe_root}/examples
import sys
sys.path.insert(0, caffe_root + 'python')

import caffe

def findAccuracy(result_file, model, test_listfile, prototxt):
  caffe.set_device(0)
  caffe.set_mode_gpu()
  net = caffe.Net(prototxt,
                model,
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
  	print(i)
  	for j in range(batch_size):
  		id = i * batch_size + j
  		if id >= data_counts:
  			break
 
		lbl = int(test_list[id].split(' ')[1])
		fname = test_list[id].split(' ')[0]
		
		prop = out['softmax'][j] 
		pred_lbl = prop.argmax()
		if pred_lbl == lbl:
			accuracy = accuracy + 1

		f.write(fname)
		f.write('{0: d}'.format(pred_lbl))
		f.write('\n')

  f.close()

  accuracy = accuracy * 1.0 / ( data_counts) 
  print accuracy
  return accuracy

acc30Test = findAccuracy('30results_256_0.txt','/home/jelake/Train/models/256_0_model_iter_30000.caffemodel', '/scratch/sbokhari/test-set/256/0/labels.txt', '/home/jelake/Test/test.prototxt')
acc30New = findAccuracy('30results_256_0_new.txt','/home/jelake/Train/models/256_0_model_iter_30000.caffemodel','/scratch/sbokhari/new-set/256/0/labels.txt', '/home/jelake/Test/new_test.prototxt')
acc15Test = findAccuracy('15results_256_0.txt','/home/jelake/Train/models/256_0_model_iter_15000.caffemodel', '/scratch/sbokhari/test-set/256/0/labels.txt', '/home/jelake/Test/test.prototxt')
acc15New = findAccuracy('15results_256_0_new.txt','/home/jelake/Train/models/256_0_model_iter_15000.caffemodel', '/scratch/sbokhari/new-set/256/0/labels.txt', '/home/jelake/Test/new_test.prototxt')

print '===The results==='
print '30K Test'
print acc30Test
print '30k New'
print acc30New
print '15k Test'
print acc15Test
print '15K New'
print acc15New

