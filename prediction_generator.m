function [dV,dG,GT,iwp] = prediction_generator(GT,wp,iwp,generator,ro_model)

nwp = size(wp,2);
if iwp == nwp
    aim = wp(:,1);
else
    aim = wp(:,iwp+1);
end

delta = aim - GT(1:2,1);
deltaS = norm(delta);
deltaG = atan2(delta(2),delta(1));
deltaG = pi_to_pi(pi_to_pi(deltaG) - GT(3));

if (deltaS >= generator.V)
    V = generator.V;
else
    V = deltaS;
end

if (abs(deltaG) >= generator.G)
    G = deltaG/abs(deltaG) * generator.G;%get sign
else
    G = deltaG;
end

if deltaS < generator.V
    if (iwp == nwp)
        iwp = 1;
    else
        iwp = iwp + 1;
    end
end

GT = se2_plus(GT,V,G);
%add gaussian random noise
dV = V + randn*V*generator.sigmaV;
dG = G + randn*G*generator.sigmaG;

    


