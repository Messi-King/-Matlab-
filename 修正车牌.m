function [y_dowm,y_up,x_right,x_left,yuzhi]=xiuzheng(y_dowm,y_up,x_right,x_left)
 
S=(y_dowm-y_up)*(x_right-x_left) ;  %SΪ�������
if       S<=25000
    yuzhi=50;
    y_xiuzheng=3;
    x_xiuzheng=3;
elseif S>25000&&S<=45000  
    yuzhi=100;
    y_xiuzheng=3;
    x_xiuzheng=3;
elseif S>45000&&S<=80000
    yuzhi=200;
    y_xiuzheng=3;
    x_xiuzheng=3;
elseif S>80000&&S<=150000
    yuzhi=300;
    y_xiuzheng=10;
    x_xiuzheng=-10;
elseif S>150000&&S<=400000
    yuzhi=600;
    y_xiuzheng=10;
    x_xiuzheng=-10;
else
    yuzhi=1800;
    y_xiuzheng=10;
    x_xiuzheng=-10;
end
%  y_up=y_up-y_xiuzheng;%�Գ�������Ľ�һ������
%  y_dowm=y_dowm+y_xiuzheng;%�Գ�������Ľ�һ������
%  x_left=x_left;%-X_secrectify;%�Գ�������Ľ�һ������
%  x_right=x_right;%+X_secrectify;%�Գ�������Ľ�һ������