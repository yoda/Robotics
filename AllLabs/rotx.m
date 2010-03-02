function [T] = rotx(angle)
    rangle = angle * pi / 180;
    T = [1, 0, 0, 0
         0, cos(rangle), -sin(rangle), 0
         0, sin(rangle), cos(rangle), 0
         0, 0, 0, 1];