function P = symT0T6()

T1 = DHsym('theta1', 'offset1', 'length1', 'twist1');
T2 = DHsym('theta2', 'offset2', 'length2', 'twist2');
T3 = DHsym('theta3', 'offset3', 'length3', 'twist3');

T4 = DHsym('theta4', 'offset4', 'length4', 'twist4');
T5 = DHsym('theta5', 'offset5', 'length5', 'twist5');
T6 = DHsym('theta6', 'offset6', 'length6', 'twist6');


T0toT6 = T1 * T2 * T3 * T4 * T5 * T6;

% Thetas
T0toT6 = subs(T0toT6, 'theta3', 0);

% Offsets
T0toT6 = subs(T0toT6, 'offset2', 0);
T0toT6 = subs(T0toT6, 'offset4', 0);
T0toT6 = subs(T0toT6, 'offset5', 0);

% Lengths
T0toT6 = subs(T0toT6, 'length1', 0);
T0toT6 = subs(T0toT6, 'length2', 0);
T0toT6 = subs(T0toT6, 'length3', 0);
T0toT6 = subs(T0toT6, 'length4', 0);
T0toT6 = subs(T0toT6, 'length5', 0);
T0toT6 = subs(T0toT6, 'length6', 0);

% Twists
T0toT6 = subs(T0toT6, 'twist1', pi/2);
T0toT6 = subs(T0toT6, 'twist2', -pi/2);
T0toT6 = subs(T0toT6, 'twist3', 0);
T0toT6 = subs(T0toT6, 'twist4', pi/2);
T0toT6 = subs(T0toT6, 'twist5', -pi/2);
T0toT6 = subs(T0toT6, 'twist6', 0);

P = T0toT6;
end