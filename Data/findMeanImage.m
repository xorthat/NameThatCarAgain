function findMeanImage(folder, annotationFile, outputSize)
load(annotationFile);
mean = double(zeros(outputSize, outputSize, 3));

for i=1:numel(annotations)
    img = double(imread([folder annotations(i).fname]));
    if(size(img, 3) == 1)
        %Fix grayscale images
        img = repmat(img, [1,1,3]);
        imwrite(uint8(img), [folder annotations(i).fname]);
    end
    mean = mean + img;
end
mean = mean ./ numel(annotations);
imageName = [folder 'meanImg.jpg'];
imwrite(uint8(mean), imageName);
end