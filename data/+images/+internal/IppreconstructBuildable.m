classdef IppreconstructBuildable < coder.ExternalDependency %#codegen
    %IPPRECONSTRUCTBUILDABLE - encapsulate ippreconstruct implementation library
    
    % Copyright 2012-2013 The MathWorks, Inc.
    
    
    methods (Static)
        
        function name = getDescriptiveName(~)
            name = 'IppreconstructBuildable';
        end
        
        function b = isSupportedContext(context)
            b = context.isMatlabHostTarget();
        end
        
        function updateBuildInfo(buildInfo,context)
            % File extensions
            [linkLibPath, linkLibExt, execLibExt] = ...
                context.getStdLibInfo();
            group = 'BlockModules';
            
            % Header paths
            buildInfo.addIncludePaths(fullfile(matlabroot,'extern','include'));
            
            % Platform specific link and non-build files
            arch            = computer('arch');
            binArch         = fullfile(matlabroot,'bin',arch,filesep);
            switch arch
                case {'win32','win64'}                    
                    libDir          = images.internal.getImportLibDirName(context);
                    linkLibPath     = fullfile(matlabroot,'extern','lib',arch,libDir);
                    linkFiles       = {'libmwippreconstruct'}; %#ok<*EMCA>
                    linkFiles       = strcat(linkFiles, linkLibExt);
                    
                    nonBuildFiles   = {'libmwippreconstruct','libippmwipt', 'libiomp5md'};
                    nonBuildFiles   = strcat(nonBuildFiles, execLibExt);
                    nonBuildFiles   = strcat(binArch, nonBuildFiles);                    
                    
                case 'glnxa64'                    
                    linkFiles       = {'libmwippreconstruct','libippmwipt'};
                    linkFiles       = strcat(linkFiles, linkLibExt);

                    nonBuildFiles   = {'libmwippreconstruct','libippmwipt'};
                    nonBuildFiles   = strcat(nonBuildFiles, execLibExt);
                    nonBuildFiles   = strcat(binArch, nonBuildFiles);

                    ompFiles        = {'libiomp5', 'libimf','libirc','libintlc'};
                    ompFiles        = strcat(ompFiles, execLibExt);
                    % libintlc.so.5
                    ompFiles{end}   = [ompFiles{end} '.5'];
                    sysosPath       = fullfile(matlabroot,'sys','os',arch,filesep);
                    ompFiles        = strcat(sysosPath, ompFiles);
                    
                    nonBuildFiles   = [nonBuildFiles, ompFiles];                    
                    
                case 'maci64'                    
                    linkFiles       = {'libmwippreconstruct','libippmwipt'};
                    linkFiles       = strcat(linkFiles, linkLibExt);

                    nonBuildFiles   = {'libmwippreconstruct','libippmwipt'};
                    nonBuildFiles   = strcat(nonBuildFiles, execLibExt);
                    nonBuildFiles   = strcat(binArch, nonBuildFiles);
                    
                    ompFiles        = 'libiomp5';
                    ompFiles        = strcat(ompFiles, execLibExt);
                    sysosPath       = fullfile(matlabroot,'sys','os',arch,filesep);
                    ompFiles        = strcat(sysosPath, ompFiles);
                    
                    nonBuildFiles   = [nonBuildFiles, ompFiles];     
                    
                otherwise
                    % unsupported
                    assert(false,[ arch ' operating system not supported']);
            end
            
            linkPriority    = '';
            linkPrecompiled = true;
            linkLinkonly    = true;
            buildInfo.addLinkObjects(linkFiles,linkLibPath,linkPriority,...
                linkPrecompiled,linkLinkonly,group);
            
            % Non-build files
            buildInfo.addNonBuildFiles(nonBuildFiles,'',group);
            
        end
        
        
        function marker = ippreconstructcore_uint8(marker, mask, imSize, modeFlag, numThreads)
            coder.inline('always');
            coder.cinclude('ippreconstruct.h');coder.cinclude('tmwtypes.h');
            coder.ceval('ippreconstruct_uint8',...
                coder.ref(marker),...
                coder.rref(mask),...
                coder.rref(imSize),...
                modeFlag,...
                numThreads);
        end
        
        
        function marker = ippreconstructcore_uint16(marker, mask, imSize, modeFlag, numThreads)
            coder.inline('always');
            coder.cinclude('ippreconstruct.h');coder.cinclude('tmwtypes.h');
            coder.ceval('ippreconstruct_uint16',...
                coder.ref(marker),...
                coder.rref(mask),...
                coder.rref(imSize),...
                modeFlag,...
                numThreads);
        end
        
        
        function marker = ippreconstructcore_single(marker, mask, imSize, modeFlag, numThreads)
            coder.inline('always');
            coder.cinclude('ippreconstruct.h');coder.cinclude('tmwtypes.h');
            coder.ceval('ippreconstruct_real32',...
                coder.ref(marker),...
                coder.rref(mask),...
                coder.rref(imSize),...
                modeFlag,...
                numThreads);
        end
        
        
        function marker = ippreconstructcore_double(marker, mask, imSize, modeFlag, numThreads)
            coder.inline('always');
            coder.cinclude('ippreconstruct.h');coder.cinclude('tmwtypes.h');
            coder.ceval('ippreconstruct_real64',...
                coder.ref(marker),...
                coder.rref(mask),...
                coder.rref(imSize),...
                modeFlag,...
                numThreads);
        end
        
        
    end
    
    
end