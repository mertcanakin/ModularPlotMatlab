function plot_main(t, actual_data, varargin)

    % Parameters:
    %   t              - Time vector
    %   actual_data    - Matrix of actual data (n_signals x n_samples)
    %   'desired_data' - Matrix of desired/reference data [optional]
    %   'indices'      - Which components to plot [default: all]
    %   'labels'       - Custom labels for each component
    %   'units'        - Unit string for y-axis
    %   'data_name'    - Name of data for titles [default: 'data']
    %   'subplot_layout'- 'multi' (separate subplots) or 'single' (overlay)
    %   'line_styles'  - Cell array of line styles
    %   'colors'       - Cell array of colors
    %   'legend_labels'- Custom legend labels [default: {'Actual', 'Desired'}]
    
    % Parse input arguments
    p = inputParser;
    addRequired(p, 't', @isnumeric);
    addRequired(p, 'actual_data', @isnumeric);
    addParameter(p, 'desired_data', [], @isnumeric);
    addParameter(p, 'indices', [], @isnumeric);
    addParameter(p, 'labels', {}, @iscell);
    addParameter(p, 'units', '', @ischar);
    addParameter(p, 'data_name', 'data', @ischar);
    addParameter(p, 'subplot_layout', 'multi', @(x) ismember(x, {'multi', 'single'}));
    addParameter(p, 'line_styles', {'-', '--'}, @iscell);
    addParameter(p, 'colors', {'b', 'r'}, @iscell);
    addParameter(p, 'legend_labels', {'Actual', 'Desired'}, @iscell);
    addParameter(p, 'figure_size', [], @(x) numel(x) == 4); % [width height] in pixels

    parse(p, t, actual_data, varargin{:});
    
    if isempty(p.Results.indices)
        indices = 1:size(actual_data, 1); % Plot all components by default
    else
        indices = p.Results.indices;
    end

    if isempty(p.Results.labels)
        labels = arrayfun(@(x) sprintf('Component %d', x), indices, 'UniformOutput', false);
    else
        labels = p.Results.labels;
    end
    
    % Check desired data if provided
    if ~isempty(p.Results.desired_data)
        has_desired = true;
    else
        has_desired = false;
    end
           
    % Plot based on layout
    if strcmp(p.Results.subplot_layout, 'multi')
        plot_subplots(t, actual_data, p.Results.desired_data, indices, labels, p.Results, has_desired);
        if ~isempty(p.Results.figure_size)
            fig = gcf;
            fig.Position = p.Results.figure_size;
        end
    else
        plot_single(t, actual_data, indices, labels, p.Results);
    end

end
