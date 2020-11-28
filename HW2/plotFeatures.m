function plotFeatures(im, f, d, numberOfFeatures)
%plot the features
perm = randperm(size(f,2)) ;
sel = perm(1:numberOfFeatures) ;
h1 = vl_plotframe(f(:,sel)) ;
h2 = vl_plotframe(f(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
set(h3,'color','g') ;
hold on
I = imread(im); 
h = image(xlim,ylim,I)
uistack(h,'bottom')
end

