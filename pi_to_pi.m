function y = pi_to_pi(x)
if x >= pi
    y = x - 2*pi;
elseif x <= -pi
    y = x + 2*pi;
else
    y = x;
end