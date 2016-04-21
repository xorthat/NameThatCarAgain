folder = '../Jenna_Logs/';
dirInfo = dir(folder);
for i =1:numel(dirInfo)
    if(isempty(strfind(dirInfo(i).name, '.txt')))
        continue;
    end
    
    if(isempty(strfind(dirInfo(i).name, 'new')))
        gt = 'labels_test.txt';
    else
        gt = 'labels_new.txt';
    end
    fileAndPath = [folder dirInfo(i).name];
    temp = strsplit(dirInfo(i).name, '.');
    outputName = ['flickr' temp{1:end-1} '.mat'];
    calculateMetrics(fileAndPath, gt, outputName);
end
