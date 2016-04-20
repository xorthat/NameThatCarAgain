function cropAndRescaleImages(inputFolder, outputFolder, annotations, outputSize, ...
    percentPadding)
%imageFolder - the absolute or relative path to the folder containing the
%   images you wish to crop and rescale
%annotions - the relative or absolute path with file name to the .mat file
%   containing the bounding box annotations
%outputSize - (scalar) the desired size of the the output image.  The
%   output images will be square
%percentPadding - the percentage that you wish the bounding box to be
%   enlarged by

load(annotations);
fid = fopen([outputFolder 'labels.txt'], 'w');

for i = 1:size(annotations, 2)
    fprintf(fid, '%s %d\n', annotations(i).fname, annotations(i).class);
    bb = [annotations(i).bbox_x1, annotations(i).bbox_y1, ...
        annotations(i).bbox_x2, annotations(i).bbox_y2];
    image = imread([inputFolder annotations(i).fname]);
    height = size(image, 1);
    width = size(image, 2);
    bb_width = bb(3) - bb(1);
    bb_height = bb(4) - bb(2);
    
    newLeft = max([0, bb(1) - bb_width*percentPadding]);
    newTop = max([0, bb(2) - bb_height*percentPadding]);
    newWidth = min([width, bb(3) + bb_width*percentPadding]) - newLeft;
    newHeight = min([height, bb(4) + bb_height*percentPadding]) - newTop;
    
    imageName = [outputFolder annotations(i).fname];
    croppedIm = imcrop(image, [newLeft, newTop, newWidth, newHeight]);
    resizedIm = imresize(croppedIm, [outputSize, outputSize]);
    imwrite(resizedIm, imageName);
end
fclose(fid);