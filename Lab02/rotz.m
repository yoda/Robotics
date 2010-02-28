function [T] = rotz(angle)
    rangle = angle * pi / 180;
    T = [ cos(rangle), -sin(rangle), 0, 0
          sin(rangle), cos(rangle), 0, 0
          0, 0, 1, 0
          0, 0, 0, 1];