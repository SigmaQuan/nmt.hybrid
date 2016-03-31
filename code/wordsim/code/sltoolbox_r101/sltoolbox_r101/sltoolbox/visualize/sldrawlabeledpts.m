function h = sldrawlabeledpts(X, labels, labelset, plotsyms, varargin)
%SLDRAWLABELEDPTS Draws Labeled 2D or 3D points
%
% $ Syntax $
%   - sldrawlabeledpts(X, labels)
%   - sldrawlabeledpts(X, labels, labelset)
%   - sldrawlabeledpts(X, labels, labelset, plotsyms, ...)
%   - h = sldrawlabeledpts(...)
%
% $ Arguments $
%   - X:            the sample matrix (2 x n or 3 x n)
%   - labels:       the row vector of labels of the samples
%   - labelset:     the set of used labels
%   - plotsyms:     the plotting symbols for the labels
%   - h:            the handles of the plots
%
% $ Description $
%   - sldrawlabeledpts(X, labels) draws a set of 2D or 3D samples 
%     with different labels using different plotting symbols.
%
%   - sldrawlabeledpts(X, labels, labelset) also specifies the 
%     set of labels that may be used.
%
%   - sldrawlabeledpts(X, labels, labelset, plotsyms, ...) specifies
%     the plotting symbols or even extra plotting properties.
%
%   - h = sldrawlabeledpts(...) returns the vector of handles to the
%     plottings.
%
% $ Remarks $
%   - If labelset is not specified, then it will be automatically 
%     generated by applying function unique on labels. The plotsyms
%     will be used following the order in labelset.
%   
%   - The points with labels not in labelset will not be plotted.
%
%   - The implementation is based on sldrawpts.
%
% $ History $
%   - Created by Dahua Lin, on Aug 28, 2006
%

%% Parse and verify input arguments

if nargin < 2
    raise_lackinput('sldrawlabeledpts', 2);
end

if ~isnumeric(X) || ndims(X) ~= 2
    error('sltoolbox:invalidarg', ...
        'X should be a 2D numeric matrix');
end

n = size(X, 2);

if ~isequal(size(labels), [1 n])
    error('sltoolbox:sizmismatch', ...
        'The labels should be a 1 x n row vector');
end

if nargin < 3 || isempty(labelset)
    labelset = unique(labels);
end

if nargin < 4 || isempty(plotsyms)
    plotsyms = [];
end

%% Rearrange samples

K = length(labelset);
nums = zeros(1, K);
inds = cell(1, K);

for i = 1 : K    
    inds{i} = find(labels == labelset(i));    
    nums(i) = length(inds{i});
end

inds = horzcat(inds{:});
X = X(:, inds);

%% Plot

if nargout == 0
    if isempty(plotsyms)
        sldrawpts(X, nums, varargin{:});
    else
        sldrawpts(X, nums, plotsyms, varargin{:});
    end
else
    if isempty(plotsyms)
        h = sldrawpts(X, nums, varargin{:});
    else
        h = sldrawpts(X, nums, plotsyms, varargin{:});
    end
end






   

    




