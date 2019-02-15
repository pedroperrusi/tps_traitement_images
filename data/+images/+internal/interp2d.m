function outputImage = interp2d(inputImage,X,Y,method,fillValues)
% FOR INTERNAL USE ONLY -- This function is intentionally
% undocumented and is intended for use only within other toolbox
% classes and functions. Its behavior may change, or the feature
% itself may be removed in a future release.
%
% Vq = INTERP2D(V,XINTRINSIC,YINTRINSIC,METHOD,FILLVAL) computes 2-D
% interpolation on the input grid V at locations in the intrinsic
% coordinate system XINTRINSIC, YINTRINSIC. The value of the output grid
% Vq(I,J) is determined by performing 2-D interpolation at locations
% specified by the corresponding grid locations in XINTRINSIC(I,J),
% YINTRINSIC(I,J). XINTRINSIC and YINTRINSIC are plaid matrices of the
% form constructed by MESHGRID. When V has more than two dimensions, the
% output Vq is determined by interpolating V a slice at a time beginning at
% the 3rd dimension.
%
% See also INTERP2, MAKERESAMPLER, MESHGRID

% Copyright 2012-2013 The MathWorks, Inc.

% Algorithm Notes
%
% This function is intentionally very similar to the MATLAB INTERP2
% function. The differences between INTERP2 and images.internal.interp2d
% are:
%
% 1) Edge behavior. This function uses the 'fill' pad method described in
% the help for makeresampler. When the interpolation kernel partially
% extends beyond the grid, the output value is determined by blending fill
% values and input grid values.
%
% 2) Plane at a time behavior. When the input grid has more than 2
% dimensions, this function treats the input grid as a stack of 2-D interpolation
% problems beginning at the 3rd dimension.
%
% 3) Degenerate 2-D grid behavior. Unlike interp2, this function handles
% input grids that are 1-by-N or N-by-1.

validateattributes(inputImage,{'single','double'},{'nonsparse'},mfilename,'inputImage');

validateattributes(X,{'single','double'},{'nonnan','nonsparse','real','2d'},mfilename,'X');

validateattributes(Y,{'single','double'},{'nonnan','nonsparse','real','2d'},mfilename,'Y');

validateattributes(fillValues,{'single','double'},{'nonsparse'},mfilename,'fillValue');

method = validatestring(method,{'nearest','bilinear','bicubic'});

if ~isequal(size(X),size(Y))
    error(message('images:interp2d:inconsistentXYSize'));
end

% IPP requires that X,Y,and fillVal are of same type. We enforce this for
% both codepaths for consistency of results.
if isa(inputImage,'double')
    X = double(X);
    Y = double(Y);
    fillValues = double(fillValues);
else
    % inputImage is single because of the validateattribes check
    % earlier.
    X = single(X);
    Y = single(Y);
    fillValues = single(fillValues);
end

if (~ismatrix(inputImage) && isscalar(fillValues))
    % If we are doing plane at at time behavior, make sure fillValues
    % always propogates through code as a matrix of size determine by
    % dimensions 3:end of inputImage.
    sizeInputImage = size(inputImage);
    if (ndims(inputImage)==3)
        % This must be handled as a special case because repmat(X,N)
        % replicates a scalar X as a NxN matrix. We want a Nx1 vector.
        sizeVec = [sizeInputImage(3) 1];
    else
        sizeVec = sizeInputImage(3:end);
    end
    fillValues = repmat(fillValues,sizeVec);
end

if ippl
    
    [inputImage,X,Y] = padImage(inputImage,X,Y,fillValues);

    % We have to account for 1 vs. 0 difference in intrinsic
    % coordinate system between remapmex and MATLAB
    X = X-1;
    Y = Y-1;
    
    if isreal(inputImage)    
        outputImage = images.internal.remapmex(inputImage,X,Y,method,fillValues);
    else
        outputImage = complex(images.internal.remapmex(real(inputImage),X,Y,method,real(fillValues)),...
                              images.internal.remapmex(imag(inputImage),X,Y,method,imag(fillValues)));
    end
            
    
else
    
    % Preallocate outputImage so that we can call interp2 a plane at a time if
    % the number of dimensions in the input image is greater than 2.
    if ~ismatrix(inputImage)
        [~,~,P] = size(inputImage);
        sizeInputVec = size(inputImage);
        outputImage = zeros([size(X) sizeInputVec(3:end)],class(inputImage));
    else
        P = 1;
        outputImage = zeros(size(X),class(inputImage));
    end
    
    [inputImage,X,Y] = padImage(inputImage,X,Y,fillValues);
    
    for plane = 1:P
        outputImage(:,:,plane) = interp2(inputImage(:,:,plane),X,Y,method,fillValues(plane));
    end
    
end


function [paddedImage,X,Y] = padImage(inputImage,X,Y,fillValues)
% We achieve the 'fill' pad behavior from makeresampler by prepadding our
% image with the fillValues and translating our X,Y locations to the
% corresponding locations in the padded image. We pad two elements in each
% dimension to account for the limiting case of bicubic interpolation,
% which has a interpolation kernel half-width of 2.

pad = 3;
X = X+pad;
Y = Y+pad;

if isscalar(fillValues)
    paddedImage = padarray(inputImage,[pad pad],fillValues);
else
    sizeInputImage = size(inputImage);
    sizeOutputImage = sizeInputImage;
    sizeOutputImage(1:2) = sizeOutputImage(1:2) + [2*pad 2*pad];
    paddedImage = zeros(sizeOutputImage,class(inputImage));
    [~,~,numPlanes] = size(inputImage);
    for i = 1:numPlanes
        paddedImage(:,:,i) = padarray(inputImage(:,:,i),[pad pad],fillValues(i));
    end
    
end
    
