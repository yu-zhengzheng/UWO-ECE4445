function [im2, a] = autolevel_51( fname )
% LEVEL  Levels background of an image.
%
% USAGE: [im2, a] = level( fname ) where 'fname' is a string representing
% the filename of the file containing the image, 'im2' is the levelled
% image, and 'a' is a vector of the 6 unknown coefficients.

% Read in image and display it
im = imread( fname );
imshow(im);

% Get background points
% -------------- NEW CODE ------------- %
% specify subcells size
m = 30;
n = 30;
% separate the matrix into subcells 
%boxes = mat2cell(im, m*ones(size(im,1)/m,1), n*ones(size(im,2)/n,1), 1);

boxes = mat2cell(im, [m*ones(floor(size(im,1)/m),1); mod(size(im,1),m)], [n*ones(floor(size(im,2)/n),1); mod(size(im,2),n)]);
% create row, column, and gray level arrays
x = [];
y = [];
I = [];
celldisp(boxes)
for i = 1:(256/m)
    for j = 1:(256/n)
        boxtemp = boxes{i,j}; %extract cell(i,j)
        minbox = min(boxtemp(:)); %get the minimum value of that cell
        [row, col] = find(boxtemp == minbox(1)); %get the row and column specific to that cell
        %calculate the correct row and column in the actual image 
        accrow = m*(i-1) + row(1); 
        acccol = n*(j-1) + col(1); 
        %store in the corresponding arrays (x = column, y = row)
        x = [x; acccol];
        y = [y; accrow];
        I = [I;minbox(1)];
    end
end 
I = double(I);


imshow(im);
hold on
plot(x, y, 'y+')

% ------------------------------------- %





% Fit data at selected points to background function
%  Solve least-squares problem: [C]{a} = {k} using the
%    \ operator, i.e., {a} = [C]\{k}
%  First, compute elements of the matrix [C]
N = length(x);
Sx = sum(x);
Sy = sum(y);
Sxx = sum(x.*x);
Syy = sum(y.*y);
Sxy = sum(x.*y);
Sxxx = sum(x.^3);
Sxxy = sum(x.*x.*y);
Sxyy = sum(x.*y.*y);
Syyy = sum(y.^3);
Sxxxx = sum(x.^4);
Sxxxy = sum(y.*x.^3);
Sxxyy = sum(x.*x.*y.*y);
Sxyyy = sum(x.*y.^3);
Syyyy = sum(y.^4);
C = [N    Sx  Sy   Sxx   Syy   Sxy;
    Sx   Sxx Sxy  Sxxx  Sxyy  Sxxy;
    Sy   Sxy Syy  Sxxy  Syyy  Sxyy;
    Sxx Sxxx Sxxy Sxxxx Sxxyy Sxxxy;
    Syy Sxyy Syyy Sxxyy Syyyy Sxyyy;
    Sxy Sxxy Sxyy Sxxxy Sxyyy Sxxyy];
% Construct {k} 
SI = sum(I);
SxI = sum(x.*I);
SyI = sum(y.*I);
SxxI = sum(x.*x.*I);
SyyI = sum(y.*y.*I);
SxyI = sum(x.*y.*I);
k = [SI SxI SyI SxxI SyyI SxyI]';
% Solve
a = C\k;

% Remove background
% First compute background image
[rows, cols] = size(im);
[x, y] = meshgrid( 1:cols, 1:rows );
back = a(1) + a(2)*x + a(3)*y + a(4)*x.*x + a(5)*y.*y +a(6)*x.*y;
im2 = double(im) - back;
im2 = mat2gray(im2); % Convert matrix of type double to image of type double
im2 = im2uint8(im2); % Convert to uint8 image. Although you were not asked
                     % to do this, it is useful to make output same type as
                     % input image.
size(I)