a=imread("s8.png");
b = imsharpen(a,'Radius',3,'Amount',1);
subplot(1,2,1)
imshow(a)
subplot(1,2,2)
imshow(b)