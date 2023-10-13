%row = uint8(0:255);%,22,22,3,3,3,255,4,255,255,255,255,255,255,160,160,190,190,190,177,177,178,177]);
%im66 = repmat(row, 3, 1);
%im(1,16:21)=[20,20,20,20,20,20]




im=imread('rice.png');
% imshow(im)
% figure;

im=rgb2gray(imread("181108.jpg"));
thres = intermeans_51( im )+0.1
bw=im2bw(im,thres);
imshow(bw)
figure;
[L,NUM] = bwlabel(bw);
bw2 = bwareaopen(bw,5);

imshow(bw2)
[L,NUM] = bwlabel(bw2);
function thres = intermeans_6( im )
    h = imhist(im); %array of pixel values at each gray level 
    thres = 255-round(255-mean2(im)); %set initial threshold to be the mean of image gray levels
    thres_prev = thres+1; 
    
    while thres_prev ~= thres 
        thres_prev = thres;
        
        %calculate u1 
        D = 0:thres_prev; %D is 0 up to the initial specified threshold 
        mLnum = sum(D.*((h(D+1))')); %element wise multiplication of D and the corresponding values in transposed h array 
        mLdenom = sum(h(D+1)); %sum of corresponding h values 
        meanLow = mLnum/mLdenom
        
        %calculate u2
        D1 = thres_prev+1:255;   %D is all values above the initial specified threshold 
        mHnum = sum(D1.*((h(D1+1))')); %same as above for meanLow
        mHdenom = sum(h(D1+1));
        meanHi = mHnum/mHdenom
        
        %Re-estimate T 
        thres=255-round(255-(meanLow+meanHi)/2)
            
    end 
    thres = thres/255; %normalize and return the threshold 
    
end 