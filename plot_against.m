function plot_against(sel_samples, select_parameters)
%Scatter plot between the first parameters and the second parameters
%Args:
%   sel_samples array[2, number of samples]
%   select_parameters [name_0, name_1] name that corresponding to
%                                       sel_samples
%==========================================================================
plot(sel_samples(1,:), sel_samples(2,:));
title(sprintf('Plot between %s vs %s', ...
            select_parameters{1}, select_parameters{2}))
xlabel(select_parameters{1}); ylabel(select_parameters{2});