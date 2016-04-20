fidR = fopen('new-set/new_labels.txt');
fidW = fopen('new-set/updated_new_labels.txt', 'w');
class_names = {'Acura', 'Aston', 'Audi', 'BMW', 'Bentley', ...
    'Bugatti', 'Buick', 'Cadillac', 'Chevrolet', 'Chrysler' ...
    'Daewoo', 'Dodge', 'FIAT', 'Ferrari', 'Ford', 'GMC', 'HUMMER', ...
    'Honda', 'Hyundai', 'Infiniti', 'Jaguar', 'Jeep', 'Lamborghini', 'Land',  ...
    'Lincoln', 'MINI', 'Mazda', 'McLaren', 'Mercedes-Benz', 'Mitsubishi', ...
    'Nissan', 'Porsche', 'Ram', 'Rolls-Royce', 'Suzuki', 'Tesla', 'Toyota', ...
    'Volkswagen', 'Volvo', 'smart'};
tline = fgetl(fidR);
while ischar(tline)
    for i = 1:numel(class_names)
        if(strcmp(tline,class_names{i}))
            fprintf(fidW, '%d\n', i);
            break;
        end
        if(i == numel(class_names))
            disp('error!')
        end
        
    end
    tline = fgetl(fidR);
end
save('car_labels.mat','class_names');
fclose(fidR);
fclose(fidW);