function P = T2to4(valT1to4)

inv2 = DHsym('theta2', 'offset2', 'length2', 'twist2');

inv2 = subs(inv2, 'length2', 0);
inv2 = subs(inv2, 'offset2', 0);
inv2 = subs(inv2, 'twist2', -pi/2);

inv2 = inv(inv2);

T = valT1to4;

P = simplify(inv2 * T);




end