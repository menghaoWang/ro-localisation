function obs = observation_generator(bec,ground_truth,generator,barriers)
nbec = size(bec,2);
obs = zeros(nbec,1);
for i=1:nbec
    dis = intersection(bec(:,i),ground_truth,barriers);
    if dis == 0
        D2 = (bec(1,i)-ground_truth(1))*(bec(1,i)-ground_truth(1)) + (bec(2,i)-ground_truth(2))*(bec(2,i)-ground_truth(2));
        dis = sqrt(D2);
        obs(i) = dis + 0.1*(1.01-exp(-dis*generator.beacon_std)) + randn * generator.beacon_sigma; %see in paper
    else
        obs(i) = dis;
    end
end

function dis = intersection(bec,gt,barriers)
[m,n] = size(barriers);
if m ~= 4
    error('Input barriers is in a wrong format!');
end
p1 = bec;
p2 = gt(1:2);
for i=1:n
    p3 = barriers(1:2,i);
    p4 = barriers(3:4,i);
    %This is just a simulation,in one rule to create NLOS observation.don't
    %take it serviously~
    if is_acute(p1,p3,p4)&&is_acute(p2,p3,p4)&&is_acute(p3,p1,p2)&&is_acute(p4,p1,p2)
        dis = norm(cross([p3-p1;0],[p4-p1;0])) / distance(p3,p4);
        return;
    else
        dis = 0;
    end
end

function bool = is_acute(p,a,b)
bool = 1;
ap = p - a;
ab = b - a;
if dot(ap,ab) <= 0
    bool = 0;
    return;
end
bp = p - b;
ba = a - b;
if dot(bp,ba) <= 0
    bool = 0;
end



%%%