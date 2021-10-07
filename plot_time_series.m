function plot_time_series(sel_samples, select_parameters)
%Plot time series between the time and the parameter's value
%Args:
%   sel_samples array[2, number of samples]
%   select_parameters [name_0, name_1] name that corresponding to
%                                       sel_samples
%Show graph
%==========================================================================
num = size(sel_samples)
plot(1:num(2), sel_samples);
title(sprintf('Time series of %s', ...
            select_parameters))

xlabel('t'); ylabel(select_parameters);
