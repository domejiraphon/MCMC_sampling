select_parameters = {'log_omega', 'log_sigma1', 'log_sigma2', 'mm', 'pie', 'mu1', 'mu2', };

num_samples = 100000;
metropolis = true;

sel_samples = sampling(select_parameters, num_samples, metropolis);

plot(sel_samples(1,:), sel_samples(2,:));
title(sprintf('Plot between mm vs log omega using statistical initialization'))
xlabel('mm'); ylabel('log omega');
for i = 1:7
    figure(i)
    hist(sel_samples(i, :), 30)
    title(sprintf("%s", select_parameters{i}))
end

