function [counts, imgs] = updateOldAnnotations(annotationFile, newFileName)
load(annotationFile);
oldAnnotations = annotations;
load('car_labels.mat');
clear annotations;
imgs = 0;
counts = zeros(40,1);
for i = 1:numel(oldAnnotations)
    oldClass = oldAnnotations(1,i).class;
    newClass = -1;
    if(oldClass >= 2 && oldClass <= 7)
        newClass = 1; %Acura
    elseif(oldClass >= 8 && oldClass <= 11)
        newClass = 2; %Aston Martin
    elseif(oldClass >= 12 && oldClass <= 25)
        newClass = 3; %Audi
    elseif(oldClass >= 26 && oldClass <= 38)
        newClass = 4;%BMW
    elseif(oldClass >= 39 && oldClass <= 44)
        newClass = 5;%Bentley
    elseif(oldClass >= 45 && oldClass <= 46)
        newClass = 6;%Bugatti
    elseif(oldClass >= 47 && oldClass <= 50)
        newClass = 7;%Buick
    elseif(oldClass >= 51 && oldClass <= 53)
        newClass = 8;%Cadillac
    elseif(oldClass >= 54 && oldClass <= 75)
        newClass = 9;%Chevrolet
    elseif(oldClass >= 76 && oldClass <= 81)
        newClass = 10;%Chrysler
    elseif(oldClass == 82)
        newClass = 11;%Daweoo
    elseif(oldClass >= 83 && oldClass <= 97)
        newClass = 12;%Dodge
    elseif(oldClass >= 99 && oldClass <= 100)
        newClass = 13;%FIAT
    elseif(oldClass >= 101 && oldClass <= 104)
        newClass = 14;%Ferrari
    elseif(oldClass >= 106 && oldClass <= 117)
        newClass = 15;%Ford
    elseif(oldClass >= 118 && oldClass <= 122)
        newClass = 16;%GMC
    elseif(oldClass >= 124 && oldClass <= 125)
        newClass = 17;%HUMMER
    elseif(oldClass >= 126 && oldClass <= 129)
        newClass = 18;%Honda
    elseif(oldClass >= 130 && oldClass <= 140)
        newClass = 19;%Hyundai
    elseif(oldClass >= 141 && oldClass <= 142)
        newClass = 20;%Infiniti
    elseif(oldClass == 144)
        newClass = 21;%Jaguar
    elseif(oldClass >= 145 && oldClass <= 149)
        newClass = 22;%Jeep
    elseif(oldClass >= 150 && oldClass <= 153)
        newClass = 23;%Lamborghini
    elseif(oldClass >= 154 && oldClass <= 155)
        newClass = 24;%Land
    elseif(oldClass == 156)
        newClass = 25;%Lincoln
    elseif(oldClass == 157)
        newClass = 26;%MINI
    elseif(oldClass == 159)
        newClass = 27;%Mazda
    elseif(oldClass == 160)
        newClass = 28;%McLaren
    elseif(oldClass >= 161 && oldClass <= 166)
        newClass = 29;%Mercedes-Benz
    elseif(oldClass == 167)
        newClass = 30;%Mitsubishi
    elseif(oldClass >= 168 && oldClass <= 171)
        newClass = 31;%Nissan
    elseif(oldClass == 173)
        newClass = 32;%Porsche
    elseif(oldClass == 174)
        newClass = 33;%Ram
    elseif(oldClass >= 175 && oldClass <= 177)
        newClass = 34;%Rolls-Royce
    elseif(oldClass >= 181 && oldClass <= 184)
        newClass = 35;%Suzuki
    elseif(oldClass == 185)
        newClass = 36;%Tesla
    elseif(oldClass >= 186 && oldClass <= 189)
        newClass = 37;%Toyota
    elseif(oldClass >= 190 && oldClass <= 192)
        newClass = 38;%Volkswagen
    elseif(oldClass >= 193 && oldClass <= 195)
        newClass = 39;%Volvo
    elseif(oldClass == 196)
        newClass = 40;%smart
    end
    if(newClass > 0)
        counts(newClass) = counts(newClass) + 1;
        imgs = imgs +1;
        annotations(imgs) = oldAnnotations(i);
        annotations(imgs).class = newClass;
    end
end
save(newFileName, 'annotations');
end