function plot_subplots(t, actual, desired, indices, labels, params, has_desired)
    figure;
    num_plots = length(indices);
    
    for i = 1:num_plots
        subplot(num_plots, 1, i);
        
        % Plot actual
        plot(t, actual(indices(i), :), params.line_styles{1}, ...
             'Color', params.colors{1}, 'LineWidth', 1.5);
        hold on;
        
        % Plot desired if available
        if has_desired
            plot(t, desired(indices(i), :), params.line_styles{2}, ...
                 'Color', params.colors{2}, 'LineWidth', 1.5);
        end
        
        % Labels and formatting
        xlabel('Time [s]');
        ylabel_str = labels{i};
        if ~isempty(params.units)
            ylabel_str = sprintf('%s [%s]', ylabel_str, params.units);
        end
        ylabel(ylabel_str);
        
        % Only show legend if we have desired data
        if has_desired
            legend(params.legend_labels);
        end
        grid on;
        
        % Make it look nice
        set(gca, 'FontSize', 10);
    end
    
    % Overall title
    set(findobj(gcf,'type','axes'),'FontName', 'Arial', 'FontSize', 12);

end