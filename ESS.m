function beta = ESS(particles,nParticles)
cum = 0;
sum_linear_w = 0;
for i=1:nParticles
    sum_linear_w = sum_linear_w + exp(particles(i).w);
end
for i=1:nParticles
    tmp = exp(particles(i).w) / sum_linear_w;
    cum = cum + tmp*tmp;
end
beta = 1/(cum*nParticles);