classdef ImregionalmaxBuildable < coder.ExternalDependency %#codegen
    %IMREGIONALMAXBUILDABLE - Encapsulate imregionalmax implementation library
    
    % Copyright 2012-2013 The MathWorks, Inc.
    
    methods (Static)
        
        function name = getDescriptiveName(~)
            name = 'imregionalmaxBuildable';
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
                    linkFiles       = {'libmwimregionalmax'}; %#ok<*EMCA>
                    linkFiles       = strcat(linkFiles, linkLibExt);
                    
                case {'glnxa64','maci64'}
                    linkFiles       = {'libmwimregionalmax','libmwnhood'};
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
            nonBuildFiles = {'libmwnhood', 'libmwimregionalmax'};            
            nonBuildFiles = strcat(binArch,nonBuildFiles, execLibExt);
            buildInfo.addNonBuildFiles(nonBuildFiles,'',group);
            
        end
        
        
        function BW = imregionalmaxcore_logical(I, BW, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('imregionalmax.h');
            coder.ceval('imregionalmax_boolean',...
                coder.rref(I),...
                coder.ref(BW),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function BW = imregionalmaxcore_uint8(I, BW, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('imregionalmax.h');
            coder.ceval('imregionalmax_uint8',...
                coder.rref(I),...
                coder.ref(BW),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function BW = imregionalmaxcore_int8(I, BW, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('imregionalmax.h');
            coder.ceval('imregionalmax_int8',...
                coder.rref(I),...
                coder.ref(BW),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function BW = imregionalmaxcore_uint16(I, BW, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('imregionalmax.h');
            coder.ceval('imregionalmax_uint16',...
                coder.rref(I),...
                coder.ref(BW),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function BW = imregionalmaxcore_int16(I, BW, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('imregionalmax.h');
            coder.ceval('imregionalmax_int16',...
                coder.rref(I),...
                coder.ref(BW),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function BW = imregionalmaxcore_uint32(I, BW, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('imregionalmax.h');
            coder.ceval('imregionalmax_uint32',...
                coder.rref(I),...
                coder.ref(BW),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function BW = imregionalmaxcore_int32(I, BW, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('imregionalmax.h');
            coder.ceval('imregionalmax_int32',...
                coder.rref(I),...
                coder.ref(BW),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function BW = imregionalmaxcore_single(I, BW, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('imregionalmax.h');
            coder.ceval('imregionalmax_real32',...
                coder.rref(I),...
                coder.ref(BW),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
        
        
        function BW = imregionalmaxcore_double(I, BW, nimdims, imSize, conn, nconndims, connSize)
            coder.inline('always');
            coder.cinclude('imregionalmax.h');
            coder.ceval('imregionalmax_real64',...
                coder.rref(I),...
                coder.ref(BW),...
                nimdims,...
                coder.rref(imSize),...
                coder.rref(conn),...
                nconndims,...
                coder.rref(connSize));
        end
    end
end