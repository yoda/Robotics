function P = T1to4()

inv1 = DHsym('theta1', 'offset1', 'length1', 'twist1');

inv1 = subs(inv1, 'length1', 0);
inv1 = subs(inv1, 'twist1', pi/2);

inv1 = inv(inv1);

T = symT0T4;

T = T(:,4);

P = simplify(inv1 * T);




end