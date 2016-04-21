function calculateMetrics(logFile, gtFile, outputFileName)
fidLog = fopen(logFile);
fidGT = fopen(gtFile);
logLine = fgetl(fidLog);
gtLine = fgetl(fidGT);

confusionMatrix = zeros(40);
fAccuracy = zeros(40,1);
count = zeros(40,1);
accuracy = 0;
total = 0;
while ischar(logLine) && size(logLine, 2) > 1
    total = total + 1;
    gtVect = strsplit(gtLine);
    logVect = strsplit(logLine);
    actual = int8(str2double(gtVect{2})) + 1;
    predicted = int8(str2double(logVect{2})) + 1;
    if(actual == predicted)
        fAccuracy(actual) = fAccuracy(actual) + 1;
        accuracy = accuracy + 1;
    end
    confusionMatrix(actual, predicted) = confusionMatrix(actual, predicted) + 1;
    count(actual) = count(actual) + 1;
    logLine = fgetl(fidLog);
    gtLine = fgetl(fidGT);
end
fAccuracy = fAccuracy ./ count;
accuracy = accuracy / total;
save(outputFileName);
fclose(fidLog);
fclose(fidGT);
end
