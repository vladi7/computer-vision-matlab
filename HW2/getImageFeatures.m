%  im - input images, let us make them all grayscale only, so it is a  h x w matrix
%  opt.type = { ‘sift’, ‘dsft’} for sift and densesift
%  f - n x d matrix containing n features of d dimension
function [f,d]=getImageFeatures(im, opt)

if ismember('sift',opt.type)
[f,d] = vl_sift(im);
end
% variant of dense SIFT descriptors, extracted at multiple scales.
%https://www.vlfeat.org/overview/dsift.html
if ismember('dsft',opt.type)
    [f,d] = vl_dsift(im);
end
end

