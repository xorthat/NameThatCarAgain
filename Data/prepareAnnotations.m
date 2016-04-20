updatedtestAnnotations = 'updated_test_annos.mat';
testAnnotations = 'cars_test_annos.mat';

updatedtrainAnnotations = 'updated_train_annos.mat';
trainAnnotations = 'cars_train_annos.mat';

generateNewDataAnnotations();
updateOldAnnotations(trainAnnotations, updatedtrainAnnotations)
updateOldAnnotations(testAnnotations, updatedtestAnnotations)