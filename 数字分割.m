function fenge = shuzifenge(imfenge)       %������ϢΪ��ɫ
[y,x]=size(imfenge);
%===============�ú����趨�ָ���ֵ========================
SS=x*y;         %���ݲ�ͬ������趨��ֵ
if     SS<=20000
    shedingyuzhi=4;
    
elseif SS>20000&&SS<=30000
    shedingyuzhi=4;
elseif SS>30000&&SS<=50000
    shedingyuzhi=4;
    
elseif SS>50000&&SS<=80000
    shedingyuzhi=4;
    
else
    shedingyuzhi=4;
    
end
ganrao=SS/100;
%=========================================================
%��������histogram�洢X����ĺڵ���
histogram=sum(~imfenge);     %ת��Ϊ��ɫ��ͳ�Ƴ���������

figure(12);
plot(1:x,histogram);
%=================���ַָ�=============================
k=1;
for h=1:x-1
    if  ((histogram(1,h)<=shedingyuzhi)&&(histogram(1,h+1)>shedingyuzhi))||((h==1)&&histogram(1,h)>shedingyuzhi)
        fenge(1,k)=h;      %����ָ���߽�����
        k=k+1;
    elseif ((histogram(1,h)>shedingyuzhi)&&(histogram(1,h+1)<=shedingyuzhi))||((h==x-1)&&histogram(1,h)>shedingyuzhi)
        fenge(1,k)=h+1;    %����ָ��ұ߽�����
        k=k+1;
    end
end
k=k-1;%ȥ���������һ��Kֵ
%==============================================
if (sum(histogram(1,fenge(1,1):fenge(1,2)))<ganrao)||((fenge(1,2)-fenge(1,1))<(fenge(1,4)-fenge(1,3))/2)       %������Ʒָ�Ĳ��ֳ����˸���
    for i=3:k                    %ȥ����һ���ָ��
        fenge(1,i-2)=fenge(1,i);
    end
end
[~,n]=size(fenge);         %�����ָ�ʱ��n==14
if  n<14
    msgbox('�ָ����','����');
    sound(audioread('��ȡ����.wav'),48000);
    pause(1);
end
fenge=fenge(1,1:14);   %ֻ����ʮ�ĸ��ָ�ڵ�
