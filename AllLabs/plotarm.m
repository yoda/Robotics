function plotarm(J0, l1,l2,theta1,theta2, rot1, rot2, seg1, seg2)
    val1 = (rot1/seg1);
    val2 = (rot2/seg2);    
    clf;
    hold on;
    j = 1;
    for x = 0: seg1,
        for y = 0: seg2,
           [J1, J2] = planar2dof(J0, l1, l2, theta1 + x*val1,theta2 + y *val2);
           plot( [J0(1), J1(1), J2(1)] , [J0(2), J1(2), J2(2)] );
           M(j) = getframe;             % Set frame j of M to the current image frame.
           j = j + 1;
        end
    end
    save awesome M;
    
    