function outputImage = interp3d(inputImage,X,Y,Z,method,fillValue)
% FOR INTERNAL USE ONLY -- This function is intentionally
% undocumented and is intended for use only within other toolbox
% classes and functions. Its behavior may change, or the feature
% itself may be removed in a future release.
%
% Vq = INTERP3D(V,XINTRINSIC,YINTRINSIC,ZINTRINSIC,METHOD,FILLVAL) computes 3-D
% interpolation on the input grid V at locations in the intrinsic
% coordinate system XINTRINSIC,YINTRINSIC,ZINTRINSIC. The value of the
% output grid Vq(I,J,K) is determined by performing 3-D interpolation at
% locations specified by the corresponding grid locations in
% XINTRINSIC(I,J,K), YINTRINSIC(I,J,K), ZINTRINSIC(I,J,K). XINTRINSIC,
% YINTRINSIC, and ZINTRINSIC are plaid matrices of the form constructed by
% MESHGRID.
%
% See also INTERP3, MAKERESAMPLER, MESHGRID

% Copyright 2012-2013 The MathWorks, Inc.

% Algorithm Notes
%
% This function is intentionally very similar to the MATLAB INTERP3
% function. The differences between INTERP3 and images.internal.interp3d
% are:
%
% 1) Edge behavior. This function uses the 'fill' pad method described in
% the help for makeresampler. When the interpolation kernel partially
% extends beyond the grid, the output value is determined by blending fill
% values and input grid values.

validateattributes(inputImage,{'single','double'},{'nonsparse'},mfilename,'inputImage');

validateattributes(X,{'single','double'},{'nonnan','nonsparse','real'},mfilename,'X');

validateattributes(Y,{'single','double'},{'nonnan','nonsparse','real'},mfilename,'Y');

validateattributes(Z,{'single','double'},{'nonnan','nonsparse','real'},mfilename,'Z');

validateattributes(fillValue,{'single','double'},{'nonsparse'},mfilename,'fillValue');

if isa(inputImage,'double')
    X = double(X);
    Y = double(Y);
    Z = double(Z);
    fillValue = double(fillValue);
else
    % inputImage is single because of the validateattribes check
    % earlier.
    X = single(X);
    Y = single(Y);
    Z = single(Z);
    fillValue = single(fillValue);
end
    
[inputImage,X,Y,Z] = padImage(inputImage,X,Y,Z,fillValue);

outputImage = interp3(inputImage,X,Y,Z,method,fillValue);

    
function [paddedImage,X,Y,Z] = padImage(inputImage,X,Y,Z,fillValue)
% We achieve the 'fill' pad behavior from makeresampler by prepadding our
% image with the fillValue and translating our X,Y locations to the
% corresponding locations in the padded image.

pad = 3;
paddedImage = padarray(inputImage,[pad pad,pad],fillValue);
X = X+pad;
Y = Y+pad;
Z = Z+pad;
    
