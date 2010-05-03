function P = symT3T0()

T1 = DHsym('theta1', 'offset1', 'length1', 'twist1');
T2 = DHsym('theta2', 'offset2', 'length2', 'twist2');
T3 = DHsym('theta3', 'offset3', 'length3', 'twist3');


T0to3 = T1 * T2 * T3

T0to3 = subs(T0to3, 'theta3', 0);
T0to3 = subs(T0to3, 'twist1', pi/2);
T0to3 = subs(T0to3, 'twist2', -pi/2);
T0to3 = subs(T0to3, 'twist3', 0);
T0to3 = subs(T0to3, 'length1', 0);
T0to3 = subs(T0to3, 'length2', 0);
T0to3 = subs(T0to3, 'length3', 0);
T0to3 = subs(T0to3, 'offset2', 0);
T0to3 = subs(T0to3, 'offset3', 0);

P = inv(T0to3);
end