function img_mat= Qdct2Img(qdct_mat,Qtbl)
% This function computes the Image
% matrix of the considered component.
demat=dequantize(qdct_mat,Qtbl);
img_mat0=ibdct(demat)+128;
img_mat=uint8(img_mat0);
%