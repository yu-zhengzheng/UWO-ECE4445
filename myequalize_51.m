im=imread("pout.tif");
im=rgb2gray(imread("181108.jpg"));
im3=myequalize_51a(im);
subplot(2,2,1)
stem(imhist(im))
subplot(2,2,2)
stem(imhist(im3))
subplot(2,2,3)
imshow(im)
subplot(2,2,4)
imshow(im3)
function im2=myequalize_51a(im)
    [H,D]=imhist(im);
    cdf=cumsum(H)/sum(H);   %Creates a cdf for the histogram of im
    map=convergent(cdf*255);     %Creates a map with index-1 being the input GL and value being output GL
    im2=uint8(map(im+1));
end