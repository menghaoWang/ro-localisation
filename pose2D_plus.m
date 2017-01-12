function pose1 = se2_plus(pose0,dS,dG)
    
   pose1 = [pose0(1) + dS * cos(pose0(3));
            pose0(2) + dS * sin(pose0(3));
            pi_to_pi(pose0(3) + dG)];
       