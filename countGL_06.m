function y = countGL_06( im, v )
%reads the length of the vector 
    N=length(v);
    %creates an empty output vector
    y=zeros(1,N-1);
    
    %loop for each interval
    for i=1:N-1
        %loop for each gray level in the interval
        for j=v(i):v(i+1)-1
            %count the number of pixels equal to j and add it to y(i)
            y(i)=y(i)+sum(sum(im==j));
        end
    end
end