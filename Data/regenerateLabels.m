load('updated_new_annos.mat');
fid = fopen('labels_new.txt', 'w');
for i=1:numel(annotations)
    fprintf(fid, '%s %d\n', annotations(i).fname, annotations(i).class - 1);
end
fclose(fid);

load('updated_test_annos.mat');
fid = fopen('labels_test.txt', 'w');
for i=1:numel(annotations)
    fprintf(fid, '%s %d\n', annotations(i).fname, annotations(i).class - 1);
end
fclose(fid);

load('updated_train_annos.mat');
fid = fopen('labels_train.txt', 'w');
for i=1:numel(annotations)
    fprintf(fid, '%s %d\n', annotations(i).fname, annotations(i).class - 1);
end
fclose(fid);