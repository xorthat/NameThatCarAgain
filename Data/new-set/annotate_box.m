function boxes = annotate_box(files)
    boxes = []
    for i=1:numel(files)
        fn_img = files(i).name
        imshow(fn_img)

        [x1, y1, b1] = ginput(1)

        if b1 ~= 1
            break
        end

        imshow(fn_img)
        hold on
        plot(x1, y1, 'r*')

        p2 = ginput(1)
        hold off

        boxes = [boxes; x1, y1, p2]

    end
end
