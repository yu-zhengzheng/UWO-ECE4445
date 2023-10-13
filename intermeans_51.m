function thres = intermeans_51( im )
    h = imhist(im); %array of pixel values at each gray level 
    thres = 255-round(255-mean2(im)); %set initial threshold to be the mean of image gray levels
    thres_prev = thres+1; 
    
    while thres_prev ~= thres 
        thres_prev = thres;
        
        %calculate u1 
        D = 0:thres_prev; %D is 0 up to the initial specified threshold 
        mLnum = sum(D.*((h(D+1))')); %element wise multiplication of D and the corresponding values in transposed h array 
        mLdenom = sum(h(D+1)); %sum of corresponding h values 
        meanLow = mLnum/mLdenom;
        
        %calculate u2
        D = thres_prev+1:255;   %D is all values above the initial specified threshold 
        mHnum = sum(D.*((h(D+1))')); %same as above for meanLow
        mHdenom = sum(h(D+1));
        meanHi = mHnum/mHdenom;
        
        %Re-estimate T 
        thres = 255-round(255-(meanHi + meanLow)/2); 
        
            
    end 
    thres = thres/255; %normalize and return the threshold 
    
end 