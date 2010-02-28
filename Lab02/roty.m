function [T] = roty(angle)
    rangle = angle * pi / 180;
    T = [ cos(rangle), 0, sin(rangle), 0
          0, 1, 0, 0'
          -sin(rangle), 0, cos(rangle), 0
          0, 0, 0, 1];