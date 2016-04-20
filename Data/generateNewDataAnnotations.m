new_bb = csvread('new-set/new_boundingboxes.csv');
new_labels = csvread('new-set/updated_new_labels.txt');
new_dir = dir('new-set');
imgs = 1;

for i = 1:size(new_dir, 1)
    if and(and(isempty(strfind(new_dir(i).name, '.jpg')), ...
        isempty(strfind(new_dir(i).name, '.png'))), isempty(strfind(new_dir(i).name, '.jpeg')))
        continue
    end
    annotations(1,imgs).fname = new_dir(i).name;
    annotations(1,imgs).bbox_x1 = new_bb(imgs, 1);
    annotations(1,imgs).bbox_y1 = new_bb(imgs, 2);
    annotations(1,imgs).bbox_x2 = new_bb(imgs, 3);
    annotations(1,imgs).bbox_y2 = new_bb(imgs, 4);
    annotations(1,imgs).class = new_labels(imgs, 1);
    imgs = imgs + 1;
end
save('updated_new_annos.mat', 'annotations');