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
        disp('Starting another round')
        newFolderOut = [newFolderIn num2str(outputSize(j)) '/' num2str(percentPadding(i))];
        trainFolderOut = [trainFolderIn num2str(outputSize(j)) '/' num2str(percentPadding(i))];
        testFolderOut = [testFolderIn num2str(outputSize(j)) '/' num2str(percentPadding(i))];
        mkdir(newFolderOut);
        mkdir(trainFolderOut);
        mkdir(testFolderOut);
        disp('Train')
        cropAndRescaleImages(trainFolderIn, [trainFolderOut '/'], trainAnnotations, outputSize(j), ...
            percentPadding(i));
        disp('Test')
        cropAndRescaleImages(testFolderIn, [testFolderOut '/'], testAnnotations, outputSize(j), ...
            percentPadding(i));
        disp('New')
        cropAndRescaleImages(newFolderIn, [newFolderOut '/'], newAnnotations, outputSize(j), ...
            percentPadding(i));
    end
end