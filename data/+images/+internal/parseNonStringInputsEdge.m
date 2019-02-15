function [Thresh,Sigma,H,kx,ky] = parseNonStringInputsEdge(allinputs,Method,Direction,nonstr)
%PARSENONSTRINGINPUTSEDGE Input-parsing for EDGE shared between CPU and GPU.

Thresh = [];
Sigma  = 2;
H      = [];
K      = [1 1];

switch Method
    case {'prewitt','sobel','roberts'}
        threshSpecified = 0;  % Threshold is not yet specified
        for i = nonstr
            if numel(allinputs{i})<=1 && ~threshSpecified % Scalar or empty
                Thresh = allinputs{i};
                threshSpecified = 1;
            elseif numel(allinputs{i})==2  % The dreaded K vector
                error(message('images:removed:syntax', 'BW = EDGE(... , K)', 'BW = EDGE(... , DIRECTION)'))
            else
                error(message('images:edge:invalidInputArguments'));
            end
        end
    
    case {'canny','canny_old'}
        % Default Std dev of gaussian for canny
        if (strcmp(Method, 'canny'))
            % The canny_old method smooths the input image twice
            % Use sqrt(2) to achieve similar results to the canny_old
            % method
            Sigma = sqrt(2);
        else
            Sigma = 1.0;
        end
        threshSpecified = 0;  % Threshold is not yet specified
        for i = nonstr
            if numel(allinputs{i})==2 && ~threshSpecified
                Thresh = allinputs{i};
                threshSpecified = 1;
            elseif numel(allinputs{i})==1
                if ~threshSpecified
                    Thresh = allinputs{i};
                    threshSpecified = 1;
                else
                    Sigma = allinputs{i};
                end
            elseif isempty(allinputs{i}) && ~threshSpecified
                threshSpecified = 1;
            else
                error(message('images:edge:invalidInputArguments'));
            end
        end
        
    case 'log'
        threshSpecified = 0;  % Threshold is not yet specified
        for i = nonstr
            if numel(allinputs{i})<=1  % Scalar or empty
                if ~threshSpecified
                    Thresh = allinputs{i};
                    threshSpecified = 1;
                else
                    Sigma = allinputs{i};
                end
            else
                error(message('images:edge:invalidInputArguments'));
            end
        end
        
    case 'zerocross'
        threshSpecified = 0;  % Threshold is not yet specified
        for i = nonstr
            if numel(allinputs{i})<=1 && ~threshSpecified % Scalar or empty
                Thresh = allinputs{i};
                threshSpecified = 1;
            elseif numel(allinputs{i}) > 1 % The filter for zerocross
                H = allinputs{i};
            else
                error(message('images:edge:invalidInputArguments'));
            end
        end
                
    otherwise
        error(message('images:edge:invalidInputArguments'));
end

if Sigma<=0
    error(message('images:edge:sigmaMustBePositive'))
end

switch Direction
    case 'both',
        kx = K(1); ky = K(2);
    case 'horizontal',
        kx = 0; ky = 1; % Directionality factor
    case 'vertical',
        kx = 1; ky = 0; % Directionality factor
    otherwise
        error(message('images:edge:badDirectionString'))
end
end