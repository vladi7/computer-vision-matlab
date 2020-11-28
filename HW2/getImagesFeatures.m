function [] = getImagesFeatures()
load MPEG.CDVS/names.mat;
opt.type = {'sift'};
folder = sprintf('MPEG.CDVS\\cdvs_thumbnails\\');
for j=1:100
    pair = mp_fid(j,:);
    el1 = pair(1);
    img=single(rgb2gray(imread([folder 'cdvs-' mat2str( el1) '.jpg'])));
    [f,d] = getImageFeatures(img, opt);
    %to just plot one image, uncomment the below lines
    %plotFeatures([folder 'cdvs-' mat2str( el1) '.jpg'], f, d, 200);
    %return;
    if j == 1
        f_sift_el1=f;
        d_sift_el1=d;
        continue;
    end
    f_sift_el1=[f_sift_el1,f];
    d_sift_el1=[d_sift_el1,d];
    disp(j);
end
opt.type = {'dsft'};
for j=1:10
    pair = mp_fid(j,:);
    el1 = pair(1);
    img=single(rgb2gray(imread([folder 'cdvs-' mat2str( el1) '.jpg'])));
    [f,d] = getImageFeatures(img, opt);
    if j == 1
        f_dsft_el1=f;
        d_dsft_el1=d;
        continue;
    end
    f_dsft_el1=[f_dsft_el1,f];
    d_dsft_el1=[d_dsft_el1,d];
    disp(j);
end
opt.type = {'sift'};
for j=1:100
    pair = mp_fid(j,:);
    el2 = pair(2);
    img=single(rgb2gray(imread([folder 'cdvs-' mat2str( el2) '.jpg'])));
    [f,d] = getImageFeatures(img, opt);
    if j == 1
        f_sift_el2=f;
        d_sift_el2=d;
        continue;
    end
    f_sift_el2=[f_sift_el2,f];
    d_sift_el2=[d_sift_el2,d];
    disp(j);
end
opt.type = {'dsft'};
for j=1:10
    pair = mp_fid(j,:);
    el2 = pair(2);
    img=single(rgb2gray(imread([folder 'cdvs-' mat2str( el2) '.jpg'])));
    [f,d] = getImageFeatures(img, opt);
    if j == 1
        f_dsft_el2=f;
        d_dsft_el2=d;
        continue;
    end
    f_dsft_el2=[f_dsft_el2,f];
    d_dsft_el2=[d_dsft_el2,d];
    disp(j);
end
save data/hw2_data1.mat d_sift_el1 d_sift_el2 d_dsft_el1 d_dsft_el2 '-v7.3' ;
opt.type = {'sift'};
folder = sprintf('MPEG.CDVS\\cdvs_thumbnails\\');
for j=1:100
    pair = nmp_fid(j,:);
    el1 = pair(1);
    img=single(rgb2gray(imread([folder 'cdvs-' mat2str( el1) '.jpg'])));
    [f,d] = getImageFeatures(img, opt);
    if j == 1
        f_sift_el1=f;
        d_sift_el1=d;
        continue;
    end
    f_sift_el1=[f_sift_el1,f];
    d_sift_el1=[d_sift_el1,d];
    disp(j);
end
opt.type = {'dsft'};
for j=1:10
    pair = nmp_fid(j,:);
    el1 = pair(1);
    img=single(rgb2gray(imread([folder 'cdvs-' mat2str( el1) '.jpg'])));
    [f,d] = getImageFeatures(img, opt);
    if j == 1
        f_dsft_el1=f;
        d_dsft_el1=d;
        continue;
    end
    f_dsft_el1=[f_dsft_el1,f];
    d_dsft_el1=[d_dsft_el1,d];
    disp(j);
end
opt.type = {'sift'};
for j=1:100
    pair = nmp_fid(j,:);
    el2 = pair(2);
    img=single(rgb2gray(imread([folder 'cdvs-' mat2str( el2) '.jpg'])));
    [f,d] = getImageFeatures(img, opt);
    if j == 1
        f_sift_el2=f;
        d_sift_el2=d;
        continue;
    end
    f_sift_el2=[f_sift_el2,f];
    d_sift_el2=[d_sift_el2,d];
    disp(j);
end
opt.type = {'dsft'};
for j=1:10
    pair = nmp_fid(j,:);
    el2 = pair(2);
    img=single(rgb2gray(imread([folder 'cdvs-' mat2str( el2) '.jpg'])));
    [f,d] = getImageFeatures(img, opt);
    if j == 1
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

