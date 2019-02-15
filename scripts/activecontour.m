function BW = activecontour(varargin)
%ACTIVECONTOUR Segment image into foreground and background using active contour.
%   BW = activecontour(A, MASK) segments the 2-D grayscale image A into
%   foreground (object) and background regions using active contour based
%   segmentation. The output image BW is a binary image where the
%   foreground is white (logical true) and the background is black (logical
%   false). MASK is a binary image, same size as A, that specifies the
%   initial position of the active contour. The boundaries of the object
%   region(s) (white) in MASK define the initial contour position used for
%   contour evolution to segment the image. Typically faster and more
%   accurate results are obtained when the initial contour position is close
%   to the desired object boundaries. See NOTES section for more
%   information on the various constraints in specifying MASK.
%
%   BW = activecontour(A, MASK, N) segments the image by evolving the
%   active contour for a maximum of N iterations. If N is not specified, a
%   value of N = 100 is chosen by default. Higher values of N may be needed
%   for desired segmentation result if the initial contour position
%   (specified by the region boundaries in MASK) is far from the desired
%   object boundaries.
% 
%   BW = activecontour(A, MASK, METHOD) specifies the active contour method
%   used for segmentation. Available methods are (names can be
%   abbreviated):
%   
%   'Chan-Vese' - Chan and Vese's region-based active contour method
%                 described in [1]. (default)
%                 
%   'edge'      - Edge-based method similar to the Geodesic Active Contour 
%                 method described in [2].
%
%   BW = activecontour(A, MASK, N, METHOD) segments the image by evolving
%   the active contour for a maximum of N iterations using the specified
%   method.
%   
%   BW = activecontour(A, MASK, N, METHOD, SMOOTHFACTOR) segments the image
%   using the specified SMOOTHFACTOR. SMOOTHFACTOR is a positive scalar
%   which controls the degree of smoothness or regularity of the boundaries
%   of the segmented regions. Higher values of SMOOTHFACTOR produce
%   smoother region boundaries but can also smooth out finer details. Lower
%   values produce more irregularities (less smoothing) in the region
%   boundaries but allow finer details to be captured. If SMOOTHFACTOR is
%   not specified, the default value is chosen as follows:
% 
%       If METHOD is 'Chan-Vese' (default), then SMOOTHFACTOR = 0. 
%       If METHOD is 'edge',                then SMOOTHFACTOR = 1. 
%
%   Class Support 
%   ------------- 
%   The input image A is an array of one of the following classes: uint8,
%   int8, uint16, int16, uint32, int32, single, or double. It must be
%   nonsparse. MASK must be a logical array of the same size as A. N and
%   SMOOTHFACTOR are scalars of class double. Output image BW is a logical
%   array of the same size as A.
%
%   Notes 
%   -----  
%   1. The evolution of the active contour is stopped if the contour position
%      in the current iteration is the same as one of the contour positions
%      from the most recent Q iterations (Q = 5), or if the maximum number
%      of iterations, N, is reached.
%   
%   2. ACTIVECONTOUR uses Sparse-Field level-set method, similar to the
%      method described in [3], for implementing active contour evolution.
% 
%   3. The boundaries of the regions in MASK are used as the initial state
%      of the contour from where the evolution starts. If MASK has regions
%      with holes, unpredictable results may be seen. Use IMFILL to fill
%      any holes in the regions in MASK. 
% 
%   4. The regions in MASK should not touch the image borders. If a region
%      touches the image border(s), ACTIVECONTOUR removes a single-pixel
%      layer from the region so that the region does not touch the image
%      border before further processing.
% 
%   5. Faster and more accurate results are obtained when the initial
%      contour position is close to the desired object boundaries. This is
%      especially true for the 'edge' method.
% 
%   6. For the 'edge' method, the active contour is naturally biased
%      towards shrinking inwards (collapsing) by default, i.e. in absence
%      of any image gradient, the active contour shrinks on its own. This
%      is unlike the 'Chan-Vese' method where, by default, the contour is
%      unbiased, i.e. free to either shrink or expand based on the image
%      features.
% 
%   7. To get an accurate segmentation result with the 'edge' method,
%      the initial contour (specified by region boundaries in MASK) should
%      lie outside the boundaries of the object to be segmented, because
%      the active contour is biased to shrink by default.
% 
%   8. The 'Chan-Vese' method [1] may not segment all objects in the image,
%      if the various object regions are of significantly different
%      grayscale intensities. For example, if the image has some objects
%      that are brighter than the background and some that are darker, the
%      'Chan-Vese' method typically segments out either the dark or the
%      bright objects only.
%
%   Example 1
%   ---------
%   This example segments an example image using Chan-Vese method.
%
%   I = imread('coins.png');
%   imshow(I)
%   title('Original Image');
% 
%   % Specify initial contour location
%   mask = zeros(size(I));
%   mask(25:end-25,25:end-25) = 1;
% 
%   figure, imshow(mask);
%   title('Initial Contour Location');
% 
%   % Segment the image using the default method and 300 iterations
%   bw = activecontour(I,mask,300);
% 
%   % Display segmented image
%   figure, imshow(bw);
%   title('Segmented Image');
% 
%   Example 2
%   ---------
%   This example shows image segmentation using the 'edge' method. Note
%   that for the 'edge' method the initial contour location specified by
%   MASK should be close to the object boundary.
%
%   I = imread('toyobjects.png');
%   imshow(I)
%   hold on, title('Original Image');
% 
%   % Specify initial contour location close to the object that is to be
%   % segmented.
%   mask = false(size(I));
%   mask(50:150,40:170) = true;
% 
%   % Display the initial contour on the original image in blue.
%   contour(mask,[0 0],'b'); 
% 
%   % Segment the image using the 'edge' method and 200 iterations
%   bw = activecontour(I, mask, 200, 'edge');
% 
%   % Display the final contour on the original image in red.
%   contour(bw,[0 0],'r'); 
%   legend('Initial Contour','Final Contour');
% 
%   % Display segmented image.
%   figure, imshow(bw)
%   title('Segmented Image');
%
%   Example 3
%   ---------
%   This example shows image segmentation using a polygonal mask created
%   interactively. 
%
%   I = imread('toyobjects.png');
%   imshow(I)
% 
%   str = 'Click to select initial contour location. Double-click to confirm and proceed.';
%   title(str,'Color','b','FontSize',12);
%   disp(sprintf('\nNote: Click close to object boundaries for more accurate result.'));
% 
%   % Select region interactively
%   mask = roipoly;
% 
%   figure, imshow(mask)
%   title('Initial MASK');
% 
%   % Segment the image using active contours
%   maxIterations = 200; % More iterations may be needed to get accurate segmentation. 
%   bw = activecontour(I, mask, maxIterations, 'Chan-Vese');
% 
%   % Display segmented image
%   figure, imshow(bw)
%   title('Segmented Image');
%
%   References: 
%   ----------- 
%   [1] T. F. Chan, L. A. Vese, "Active contours without edges," IEEE
%       Transactions on Image Processing, Volume 10, Issue 2, pp. 266-277,
%       2001.
%
%   [2] V. Caselles, R. Kimmel, G. Sapiro, "Geodesic active contours,"
%       International Journal on Computer Vision, Volume 22, Issue 1, pp.
%       61-79, 1997.
% 
%   [3] R. T. Whitaker, "A level-set approach to 3d reconstruction from
%       range data," International Journal of Computer Vision, Volume 29,
%       Issue 3, pp.203–231, 1998.
% 
%   See also IMFREEHAND, IMELLIPSE, MULTITHRESH, POLY2MASK, ROIPOLY.

%   Copyright 2012-2013 The MathWorks, Inc.

narginchk(2,5);

[A, mask, N, method, smoothfactor] = parse_inputs(varargin{:});

if (isempty(A) || islogical(A))
    BW = A;
    return;
end

% Create speed function object
switch (method)
    case 'Chan-Vese'
        
        balloonweight = 0;
        foregroundweight = 1;
        backgroundweight = 1;
        
        speed = images.activecontour.internal.ActiveContourSpeedChanVese ...
            (smoothfactor, balloonweight, foregroundweight, backgroundweight);
        
    case 'edge'
        
        balloonweight = 0.3; % balloonweight > 0 biases the contour to shrink. 
        advectionweight = 1;
        sigma = 2;
        gradientnormfactor = 1;
        edgeExponent = 1;
        
        speed = images.activecontour.internal.ActiveContourSpeedEdgeBased ...
            (smoothfactor, balloonweight, advectionweight, sigma, ...
             gradientnormfactor, edgeExponent);         
end

% Create contour evolver object
evolver = images.activecontour.internal.ActiveContourEvolver(A, mask, speed);

% Evolve the contour for specified number of iterations
evolver = moveActiveContour(evolver, N);

% Extract final contour state
BW = evolver.ContourState;
      
end

%--------------------------------------------------------------------------

function [A, mask, N, method, smoothfactor] = parse_inputs(varargin)

% Validate A
A = varargin{1};
validImageTypes = {'uint8','int8','uint16','int16','uint32','int32', ...
                   'single','double','logical'};
validateattributes(A,validImageTypes,{'finite','nonsparse','real'},mfilename,'A',1);

if (isvector(A) || ~ismatrix(A)) 
    error(message('images:activecontour:mustBe2D','A'));
end

% Validate MASK
mask = varargin{2};
validMaskTypes = {'logical','numeric'};
validateattributes(mask,validMaskTypes,{'nonnan','nonsparse','real'},mfilename,'MASK',2);

if ~isequal(size(A),size(mask))
    error(message('images:activecontour:differentMatrixSize','A','MASK'))
end

if ~islogical(mask)
    mask = logical(mask);
end
    
% Default values for optional arguments (N, METHOD, SMOOTHFACTOR)
N = 100; 
method = 'Chan-Vese';
smoothfactor = 0; % Default SMOOTHFACTOR for Chan-Vese method

% If specified, parse optional arguments 
if nargin > 2
    if ~ischar(varargin{3})
        N = varargin{3};
        % Validate N
        validateattributes(N,{'numeric'},{'positive','scalar','finite', ...
            'integer'}, mfilename,'N',3); 
        method_arg_loc = 4;        
    else
        method_arg_loc = 3;        
    end
    
    args_after_N = varargin(method_arg_loc:end); 
    
    if ~isempty(args_after_N)
        
        if (length(args_after_N) > 2)
            error(message('images:validate:tooManyInputs', mfilename))
        end
                
        % Validate METHOD
        method_strings = {'Chan-Vese', 'edge'}; % Do not change order.
        
        method = validatestring(args_after_N{1}, method_strings, ...
                                mfilename,'METHOD',method_arg_loc);
               
        if (length(args_after_N) > 1)            
            smoothfactor = args_after_N{2};
            % Validate smoothfactor
            validateattributes(smoothfactor,{'uint8','int8','uint16', ...
                'int16','uint32','int32','single','double'},{'nonnegative', ... 
                'real','scalar','finite'}, mfilename,'SMOOTHFACTOR', ...
                method_arg_loc+1);
            smoothfactor = double(smoothfactor);                         
            
        else     
            switch method
                case 'Chan-Vese'
                    smoothfactor = 0;
                case 'edge'
                    smoothfactor = 1;
                otherwise
                    iptassert(false,'images:validate:unknownInputString');
            end
            
        end        
    end
end
                    
end





