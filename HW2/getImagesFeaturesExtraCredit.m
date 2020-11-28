function [] = getImagesFeaturesExtraCredit()
%load MPEG.CDVS/names.mat;
classes = {'airplane', 'airport', 'baseball_diamond', 'basketball_court', 'beach', 'bridge', 'chaparral', 'church', 'circular_farmland', 'cloud', 'commercial_area', 'dense_residential', 'desert', 'forest', 'freeway'};
opt.type = {'sift'};
%matching
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:20
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 1
            f_sift_el1=f;
            d_sift_el1=d;
            continue;
        end
        disp(j);
    end
    f_sift_el1=[f_sift_el1,f];
    d_sift_el1=[d_sift_el1,d];
end
opt.type = {'dsft'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:5
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 1
            f_dsft_el1=f;
            d_dsft_el1=d;
            continue;
        end
        f_dsft_el1=[f_dsft_el1,f];
        d_dsft_el1=[d_dsft_el1,d];
        disp(j);
    end
end
opt.type = {'sift'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=20:40
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 20
            f_sift_el2=f;
            d_sift_el2=d;
            continue;
        end
        f_sift_el2=[f_sift_el2,f];
        d_sift_el2=[d_sift_el2,d];
        disp(j);
    end
end
opt.type = {'dsft'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=5:10
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 5
            f_dsft_el2=f;
            d_dsft_el2=d;
            continue;
        end
        f_dsft_el2=[f_dsft_el2,f];
        d_dsft_el2=[d_dsft_el2,d];
        disp(j);
    end
end
save data/hw2_data1.mat d_sift_el1 d_sift_el2 d_dsft_el1 d_dsft_el2 '-v7.3' ;


%non matching
opt.type = {'sift'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:20
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 1
            f_sift_el1=f;
            d_sift_el1=d;
            continue;
        end
        f_sift_el1=[f_sift_el1,f];
        d_sift_el1=[d_sift_el1,d];
        disp(j);
    end
end
opt.type = {'dsft'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:5
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 1
            f_dsft_el1=f;
            d_dsft_el1=d;
            continue;
        end
        f_dsft_el1=[f_dsft_el1,f];
        d_dsft_el1=[d_dsft_el1,d];
        disp(j);
    end
end
opt.type = {'sift'};
for i=length(classes):-1:1
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:20
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 15 && j == 1
            f_sift_el2=f;
            d_sift_el2=d;
            continue;
        end
        f_sift_el2=[f_sift_el2,f];
        d_sift_el2=[d_sift_el2,d];
        disp(j);
    end
end
opt.type = {'dsft'};
for i=length(classes):-1:1
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:5
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 15 && j == 1
            f_dsft_el2=f;
            d_dsft_el2=d;
            continue;
        end
        f_dsft_el2=[f_dsft_el2,f];
        d_dsft_el2=[d_dsft_el2,d];
        disp(j);
    end
    save data/hw2_data2.mat d_sift_el1 d_sift_el2 d_dsft_el1 d_dsft_el2 '-v7.3' ;
end



