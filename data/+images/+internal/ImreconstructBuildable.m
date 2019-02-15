classdef ImreconstructBuildable < coder.ExternalDependency %#codegen
    %IMRECONSTRUCTBUILDABLE - encapsulate imreconstruct implementation library
    
    % Copyright 2012-2013 The MathWorks, Inc.
    
    
    methods (Static)
        
        function name = getDescriptiveName(~)
            name = 'ImreconstructBuildable';
        end
        
        function b = isSupportedContext(context)
            b = context.isMatlabHostTarget();
        end
        
        function updateBuildInfo(buildInfo, context)
            % File extensions
            [~, linkLibExt, execLibExt] = ...
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
                    linkLibPath     = fullfile(matlabroot,'extern','lib',computer('arch'),libDir);
                    linkFiles       = {'libmwimreconstruct'}; %#ok<*EMCA>
                    linkFiles       = strcat(linkFiles, linkLibExt);
                    
                case {'glnxa64','maci64'}
                    linkFiles       = {'libmwimreconstruct','libmwnhood'};
                    linkFiles       = strcat(linkFiles, linkLibExt);
                    linkLibPath     = binArch;
                
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
            nonBuildFiles = {'libmwnhood', 'libmwimreconstruct'};            
            nonBuildFiles = strcat(binArch,nonBuildFiles, execLibExt);
            buildInfo.addNonBuildFiles(nonBuildFiles,'',group);
                        
        end
        
        
        function marker = imreconstructcore_logical(marker, mask, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('tmwtypes.h');coder.cinclude('imreconstruct.h');
            coder.ceval('imreconstruct_boolean',...
                coder.ref(marker),...
                coder.rref(mask),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function marker = imreconstructcore_uint8(marker, mask, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('tmwtypes.h');coder.cinclude('imreconstruct.h');
            coder.ceval('imreconstruct_uint8',...
                coder.ref(marker),...
                coder.rref(mask),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function marker = imreconstructcore_int8(marker, mask, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('tmwtypes.h');coder.cinclude('imreconstruct.h');
            coder.ceval('imreconstruct_int8',...
                coder.ref(marker),...
                coder.rref(mask),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function marker = imreconstructcore_uint16(marker, mask, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('tmwtypes.h');coder.cinclude('imreconstruct.h');
            coder.ceval('imreconstruct_uint16',...
            coder.ref(marker),...
                coder.rref(mask),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function marker = imreconstructcore_int16(marker, mask, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('tmwtypes.h');coder.cinclude('imreconstruct.h');
            coder.ceval('imreconstruct_int16',...
            coder.ref(marker),...
                coder.rref(mask),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function marker = imreconstructcore_uint32(marker, mask, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('tmwtypes.h');coder.cinclude('imreconstruct.h');
            coder.ceval('imreconstruct_uint32',...
            coder.ref(marker),...
                coder.rref(mask),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function marker = imreconstructcore_int32(marker, mask, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('tmwtypes.h');coder.cinclude('imreconstruct.h');
            coder.ceval('imreconstruct_int32',...
            coder.ref(marker),...
                coder.rref(mask),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        function marker = imreconstructcore_single(marker, mask, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('tmwtypes.h');coder.cinclude('imreconstruct.h');
            coder.ceval('imreconstruct_real32',...
                coder.ref(marker),...
                coder.rref(mask),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function marker = imreconstructcore_double(marker, mask, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('tmwtypes.h');coder.cinclude('imreconstruct.h');
            coder.ceval('imreconstruct_real64',...
                coder.ref(marker),...
                coder.rref(mask),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
    end
    
    
end