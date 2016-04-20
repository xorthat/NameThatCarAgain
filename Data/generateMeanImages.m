testFolderIn = 'test-set/';
testAnnotations = 'updated_test_annos.mat';

trainFolderIn = 'train-set/';
trainAnnotations = 'updated_train_annos.mat';

newFolderIn = 'new-set/';
newAnnotations = 'updated_new_annos.mat';

percentPadding = [0, .05];
outputSize = [512, 256, 128];

for i = 1:numel(percentPadding)
    for j = 1:numel(outputSize)
        disp('new round');
        newFolderOut = [newFolderIn num2str(outputSize(j)) '/' num2str(percentPadding(i)) '/'];
        trainFolderOut = [trainFolderIn num2str(outputSize(j)) '/' num2str(percentPadding(i)) '/'];
        testFolderOut = [testFolderIn num2str(outputSize(j)) '/' num2str(percentPadding(i)) '/'];
        findMeanImage(newFolderOut, newAnnotations, outputSize(j));
        findMeanImage(trainFolderOut, trainAnnotations, outputSize(j));
        findMeanImage(testFolderOut, testAnnotations, outputSize(j));        
    end
end
