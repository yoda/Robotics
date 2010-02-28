function plotframe(T, len, label)
    % T is a 4x4 homongeneous transform
    if nargin < 2
        len = 1;
    end
    
    disp('Transformation Matrix');
    disp(T);
    
    orig = [[0;0;0;1],[len;0;0;1],[0;len;0;1],[0;0;len;1]];
    disp('Original Matrix')
    disp(orig);
    
    xformed = T * orig;
    
    disp('Final Matrix')
    disp(xformed);
    
    line([xformed(1,1), xformed(1,2)], [xformed(1,1),xformed(2,2)], [xformed(1,1),xformed(3,2)], 'linewidth', 2, 'color', 'red')
    text(xformed(1,2), xformed(2,2), xformed(3,2), 'x')
    
    line([xformed(1,1), xformed(1,3)], [xformed(1,1),xformed(2,3)], [xformed(1,1),xformed(3,3)], 'linewidth', 2, 'color', 'blue')
    text(xformed(1,3), xformed(2,3), xformed(3,3), 'y')
    
    line([xformed(1,1), xformed(1,4)], [xformed(1,1),xformed(2,4)], [xformed(1,1),xformed(3,4)], 'linewidth', 2, 'color', 'green')
    text(xformed(1,4), xformed(2,4), xformed(3,4), 'z')
    
    
    %yaxis = line([0,0,0,1]*T,[0,len,0,1]*T,[0,0,0,1]*T);
  %  text(0, len, 0, 'Y-Axis')
    
    %zaxis = line([0,0,0,1]*T,[0,0,0,1]*T,[0,0,len,1]*T);
  %  text(0, 0, len, 'Z-Axis')
  
    
   % [a,b,c] = cylinder([3/20,1/20,3/20,4/20,2/20,2/20],5);
  %  surf(a,b,c);
  %  [a1,b1,c1] = [a,b,c] * trans(2,0,0);
  %  surf(a1,b1,c1);
  %  xlabel('X-Axis');
  %  ylabel('Y-Axis');
  %  zlabel('Z-Axis');