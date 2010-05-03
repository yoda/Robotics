function P = symT0T4()

T1 = DHsym('theta1', 'offset1', 'length1', 'twist1');
T2 = DHsym('theta2', 'offset2', 'length2', 'twist2');
T3 = DHsym('theta3', 'offset3', 'length3', 'twist3');
T4 = DHsym('theta4', 'offset4', 'length4', 'twist4');


T0to4 = T1 * T2 * T3 * T4

T0to4 = subs(T0to4, 'theta3', 0);
T0to4 = subs(T0to4, 'twist1', pi/2);
T0to4 = subs(T0to4, 'twist2', -pi/2);
T0to4 = subs(T0to4, 'twist3', 0);
T0to4 = subs(T0to4, 'twist4', pi/2);
T0to4 = subs(T0to4, 'length1', 0);
T0to4 = subs(T0to4, 'length2', 0);
T0to4 = subs(T0to4, 'length3', 0);
T0to4 = subs(T0to4, 'length4', 0);
T0to4 = subs(T0to4, 'offset2', 0);
T0to4 = subs(T0to4, 'offset4', 0);

P = T0to4;
end