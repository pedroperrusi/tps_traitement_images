function ldir = getImportLibDirName(context)
% GETIMPORTLIBNAME returns the compiler specific import library name on
%
% Windows specific
%
%

% Copyright 2013 The MathWorks, Inc.


cc = context.getToolchainInfo();

if strncmp(cc.Name, 'Microsoft',9)
    ldir = 'microsoft';
elseif strncmp(cc.Name,'Lcc', 3)
    ldir = 'lcc';
else
    assert(false, sprintf('Image Processing Toolbox does not support %s compiler',cc.Name));
end