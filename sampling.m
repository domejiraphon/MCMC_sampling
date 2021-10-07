function sel_samples = sampling(select_parameters, num_samples, metropolis)
% This is a function to return sample that are sampled from Metropolis 
% or Slice sampling

%Args:
%   select_parameters: is the list of name of parameters that we want
%   num_samples: int is the number of total samples
%   metropolis: boolean if it is True, use metropolis. Otherwise, use Slice
%               Sampling
%Returns:
%   samples: array size [len(select_parameters), num_samples]
%==========================================================================

% Load data
ws = load('astro_data');
xx = ws.xx;
vv = ws.vv;
clear('ws');

% Initial condition
mu = mean(xx); 
ext = max(xx) - min(xx);
log_omega = log(mean(abs(vv)) / ext); % Something with the right units
mm = mu;
pie = 0.5;
mu1 = log(0.5*ext*rand);
mu2 = log(0.5*ext*rand); 
log_sigma1 = 1;
log_sigma2 = 1;

init = [log_omega; mm; pie; mu1; mu2; log_sigma1; log_sigma2];

% Run sampler
wrapper = @(args) log_pstar(args{:}, xx, vv);
logdist = @(x) wrapper(num2cell(x));
assert(~isinf(logdist(init))); % Need a feasible point to begin with
%num_samples = 100;
%0.017;
if metropolis == true
    step = 0.017;
    [samples, arate] = dumb_metropolis(init, logdist, num_samples, step);
else
    S = 1e3;
    step_out = true;
    widths = 0.001;
    samples = slice_sample(S, 0, logdist, init, widths, step_out);
    %save('slice_samples', 'samples');
    burn = 100;
end

%select_parameters = {'mm', 'log_omega'};
idx_param = struct('log_omega', 1, ...
                   'mm', 2, ...
                   'pie', 3, ...
                   'mu1', 4, ...
                   'mu2', 5, ...
                   'log_sigma1', 6, ...
                   'log_sigma2', 7);

choose_param = [];
for num_param = 1:length(select_parameters)
   choose_param(num_param) = idx_param.(select_parameters{num_param});
end
sel_samples = samples(choose_param,:);



