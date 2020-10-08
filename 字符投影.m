function bw_fir = touying(imane_bw)   %反色图片，黑色为车牌信息，投影法修剪车牌照片。
X_yuzhi=1;
[y,x]=size(imane_bw);
Y_touying=(sum((~imane_bw)'))';%往左边投影统计黑点    再将车牌信息转化为白色
X_touying=sum((~imane_bw));%往下面投影
%找黑体边缘
Y_up=fix(y/2);       %向0取整
Y_yuzhi=mean(Y_touying((fix(y/2)-10):(fix(y/2)+10),1))/1.6;  %mean求平均值，Y方向的阈值。
while ((Y_touying(Y_up,1)>=Y_yuzhi)&&(Y_up>1))%找到图片上边界  
       Y_up=Y_up-1;
end   
Y_down=fix(y/2);
while ((Y_touying(Y_down,1)>=Y_yuzhi)&&(Y_down<y))%找到图片下边界 
       Y_down=Y_down+1;
end
%去除左边边框干扰
 X_right=1;
 
if (X_touying(1,fix(x/14)))<=X_yuzhi
   X_right=fix(x/14);
end
%找黑体边缘
bw_fir=imane_bw(Y_up:Y_down,X_right:x);
