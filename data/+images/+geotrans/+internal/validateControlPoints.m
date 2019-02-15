function validateControlPoints(movingPoints,fixedPoints)
%   FOR INTERNAL USE ONLY -- This function is intentionally
%   undocumented and is intended for use only within other toolbox
%   classes and functions. Its behavior may change, or the feature
%   itself may be removed in a future release.
%
%   validateControlPoints(movingPoints,fixedPoints) performs input argument
%   validate on specified matched control point matrices movingPoints and
%   fixedPoints.

% Copyright 2012 The MathWorks, Inc.

validateattributes(movingPoints,{'single','double'},{'2d','finite','nonsparse','ncols',2},mfilename,'movingPoints');
validateattributes(fixedPoints,{'single','double'},{'2d','finite','nonsparse','ncols',2},mfilename,'fixedPoints');

if ~isequal(size(movingPoints),size(fixedPoints))
    error(message('images:geotrans:differentNumbersOfControlPoints','fixedPoints','movingPoints'));
end
