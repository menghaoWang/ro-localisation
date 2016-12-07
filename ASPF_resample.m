function particles = ASPF_resample(particles,n)%nParticles
log_w = zeros(1,n);
for i=1:n
    log_w(i) = particles(i).w;
end
max_log_w = max(log_w);%almost is 0
linear_w = exp(log_w) - max_log_w;
sum_linear_w = sum(linear_w);
linear_w = linear_w / sum_linear_w;

to_sort = [linear_w',[1:n]'];
sort_w = sortrows(to_sort,1);

T = zeros(1,n+1);
d = 1/n;
T(1) = rand*d;
for i=1:n
    T(i+1) = T(i) + d;
end
T(n+1) = 1;

out_index = zeros(1,n);
i = 1;
j = 1;
while i <= n
    if T(i) < sort_w(j,1)
        out_index(i) = sort_w(j,2);
        i = i + 1;
    else
        j = j + 1;
        if j > n%reach end
            j = n;
            out_index(i:n) = sort_w(j,2);
            break;
        end
    end
end
particles= particles(out_index);