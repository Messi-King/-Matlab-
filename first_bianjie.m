function [ydown,yup,xright,xleft]=first_bianjie(yt)
[y,x,~]=size(yt);
yt = double(yt);  %转化为double型数据
y_yuzhi = 5;  %y的蓝色边界阈值
%====================== Y 方向============================
y_lanse=zeros(y,1);
for b=1:y
    for c=1:x  
        if((yt(b,c,1)<=48)&&((yt(b,c,2)<=100)&&(yt(b,c,2)>=40))&&((yt(b,c,3)<=200)&&(yt(b,c,3)>=80)))     %判断是否为蓝色RGB
           y_lanse(b,1)= y_lanse(b,1)+1;      % Y方向蓝色象素点统计                    
        end  
    end       
end
waitbar(0.2);
k=0;  %记录蓝色区域的循环次数
[~,y_max_hang] = max(y_lanse); % Y方向车牌区域,temp是最大值，MaxY是所在的行数。
yup=y_max_hang;    %有最多蓝点的行付给yup
while ((y_lanse(yup,1)>=y_yuzhi)&&(yup>1))%找到车牌上边界
    yup=yup-1;
end 
%yup 存储车牌上边界值
ydown=y_max_hang;
while ((y_lanse(ydown,1)>=y_yuzhi)&&(ydown<y))  %找到车牌下边界
     ydown=ydown+1;
end
%==============X 方向===============================
x_yuzhi=fix((ydown-yup)/11);  %这个数值很重要。决定了提取的彩图的质量,适当提高可抗干扰，但是小图会照成剪裁太多
x_lanse=zeros(1,x);             % 初始化蓝色矩阵
for c=1:x
    for b=yup:ydown   
        if((yt(b,c,1)<=65)&&((yt(b,c,2)<=100)&&(yt(b,c,2)>=40))&&((yt(b,c,3)<=160)&&(yt(b,c,3)>=90)))%这里由82修改成90.因为图片20090504809   
         x_lanse(1,c)= x_lanse(1,c)+1;               
        end  
    end       
end
waitbar(0.3);
[~,x_max_lie]=max(x_lanse);  %temp是最大值，MaxX是最大值所在的列数。
xleft=x_max_lie-6*(ydown-yup);%这里根据长宽比得到初步边界。
if  xleft<=1     %防止溢出边界。
    xleft=1;
end
while ((x_lanse(1,xleft)<=x_yuzhi)&&(xleft<x))%确定X的左边起点。
      xleft=xleft+1;
end   
xright=x_max_lie+6*(ydown-yup);%得到初步的X右边边界。
if  xright>=x     %防止溢出边界。
    xright=x;
end
while ((x_lanse(1,xright)<=x_yuzhi)&&(xright>xleft))%%确定X的右边终点。
       xright=xright-1;
end

%=========================================================       
kuan=ydown-yup+1;chang=xright-xleft+1;
White=0;       %设置白色像素点变量
for b=yup:ydown
    for c=xleft:xright
        if (std([yt(b,c,1) yt(b,c,2) yt(b,c,3)],1,2)<=22)&&(yt(b,c,1)>=90)&&(yt(b,c,1)<=255)  %std为求标准差函数
    %第三个参数代表的是按照列求标准差还是按照行求标准差，std(A,1,1)代表的是按照列求标准差，std(A,1,2)代表的是按照行求标准差。
            White= White+1;    % 白色象素点统计                    
        end  
    end       
end
bai_lan_bi=White/(kuan*chang);
kuan_chang_bi=kuan/chang;
k=k+1;
waitbar(0.35);
while(~((bai_lan_bi>=0.12)&&(bai_lan_bi<=0.5)&&(kuan_chang_bi>=0.20)&&(kuan_chang_bi<=0.6)))  %判断白蓝比与宽长比是否符合条件，若不符合则进入下面程序，继续判断。  
%===========================蓝色区域不是车牌区域=====================
% y_lanse(yup:ydowm,1)=0;   %在图片中将不是车牌区域置0
for m=yup:ydown
    for n=xleft:xright
        yt(m,n,1)= 0;yt(m,n,2)=0;yt(m,n,3)=0;
    end
end
%====================== Y 方向============================
y_lanse=zeros(y,1);
for b=1:y
    for c=1:x  
        if((yt(b,c,1)<=48)&&((yt(b,c,2)<=100)&&(yt(b,c,2)>=40))&&((yt(b,c,3)<=200)&&(yt(b,c,3)>=80)))     %判断是否为蓝色RGB
           y_lanse(b,1)= y_lanse(b,1)+1;      % Y方向蓝色象素点统计                    
        end  
    end       
end
[~,y_max_hang] = max(y_lanse); % Y方向车牌区域,temp是最大值，MaxY是所在的行数。
yup=y_max_hang;    %有最多蓝点的行付给yup
while ((y_lanse(yup,1)>=y_yuzhi)&&(yup>1))%找到车牌上边界
    yup=yup-1;
end 
%yup 存储车牌上边界值
ydown=y_max_hang;
while ((y_lanse(ydown,1)>=y_yuzhi)&&(ydown<y))  %找到车牌下边界
     ydown=ydown+1;
end
%==============X 方向===============================
x_yuzhi=fix((ydown-yup)/11);  %这个数值很重要。决定了提取的彩图的质量,适当提高可抗干扰，但是小图会照成剪裁太多
x_lanse=zeros(1,x);             % 初始化蓝色矩阵
for c=1:x
    for b=yup:ydown   
        if((yt(b,c,1)<=65)&&((yt(b,c,2)<=100)&&(yt(b,c,2)>=40))&&((yt(b,c,3)<=160)&&(yt(b,c,3)>=90)))%这里由82修改成90.因为图片20090504809   
         x_lanse(1,c)= x_lanse(1,c)+1;               
        end  
    end       
end
[~,x_max_lie]=max(x_lanse);  %temp是最大值，MaxX是最大值所在的列数。
xleft=x_max_lie-6*(ydown-yup);%这里根据长宽比得到初步边界。
if  xleft<=1     %防止溢出边界。
    xleft=1;
end
while ((x_lanse(1,xleft)<=x_yuzhi)&&(xleft<x))%确定X的左边起点。
      xleft=xleft+1;
end   
xright=x_max_lie+6*(ydown-yup);%得到初步的X右边边界。
if  xright>=x     %防止溢出边界。
    xright=x;
end
while ((x_lanse(1,xright)<=x_yuzhi)&&(xright>xleft))%%确定X的右边终点。
       xright=xright-1;
end
%=========================================================       
kuan=ydown-yup+1;chang=xright-xleft+1;
White=0;
for b=yup:ydown
    for c=xleft:xright
        if   (std([yt(b,c,1) yt(b,c,2) yt(b,c,3)],1,2)<=16)&&(yt(b,c,1)>=90)&&(yt(b,c,1)<=255)
            White= White+1;    % 白色象素点统计                    
        end  
    end       
end        
bai_lan_bi=White/(kuan*chang);
kuan_chang_bi=kuan/chang;
k=k+1;
%防止陷入死循环
if (xright<=xleft)||(yup>=ydown)
    msgbox('粗定位出错','警告');
    sound(audioread('粗定位出错.wav'),48000);
    pause(1);
    ydown=-5;
    break ;
end

end