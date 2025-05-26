function plot_single(t, actual, indices, labels, params)
    % Create a new figure
    figure;

    % Generate distinct colors for each component
    num_components = length(indices);
    colors = lines(num_components); % Use MATLAB's lines colormap
    
    % Plot all actual components
    for i = 1:num_components
        idx = indices(i);
        plot(t, actual(idx, :), ...
             'LineStyle', params.line_styles{1}, ...
             'Color', colors(i,:), ...
             'LineWidth', 1.5);
        hold on
    end

    legend(params.legend_labels);
    
    % Labels and formatting
    xlabel('Time [s]');
    ylabel_str = labels{1};
    if ~isempty(params.units)
        ylabel_str = sprintf('%s [%s]', ylabel_str, params.units);
    end
    ylabel(ylabel_str);
    grid on;
    set(findobj(gcf,'type','axes'),'FontName', 'Arial', 'FontSize', 12);    
    hold off;
end