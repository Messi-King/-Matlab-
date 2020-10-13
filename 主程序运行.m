
function varargout = xuliu(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @xuliu_OpeningFcn, ...
                   'gui_OutputFcn',  @xuliu_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% 以上程序自动生成，不用修改


function xuliu_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
%显示背景图片
ha=axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'down');
II=imread('dabeijing.jpg');
image(II);
colormap gray;
set(ha,'handlevisibility','off','visible','off');


function varargout = xuliu_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
%点击‘选择图片’按钮执行的程序
function open_Callback(hObject, eventdata, handles)
[filename,pathname] = uigetfile('*.jpg','选择图片');
handles.filename = filename;
guidata(hObject,handles);
zhaopianlujing=[pathname filename];
handles.zhaopianlujing = zhaopianlujing;
guidata(hObject,handles);

%点击‘开始识别’执行的程序
function run_Callback(hObject, eventdata, handles)
tic;  %程序运行时间
h=waitbar(0,'请稍等......');  %进度条
yt=imread(handles.zhaopianlujing);   %yt为原始图像
axes(handles.show);      %显示原图
imshow(yt);
handles.yt = yt;               %第一张图
guidata(hObject,handles);
%================================车牌粗定位===============================
waitbar(0.1);
[ydown,yup,xright,xleft]=first_bianjie(yt);

if  ydown>0
[ydown,yup,xright,xleft,yuzhi]=xiuzheng(ydown,yup,xright,xleft);  %车牌区域根据面积二次修正
Plate = yt(yup:ydown,xleft:xright,:);
handles.Plate = Plate;   %放入handles结构体中，方便在其他回调函数中调用 第二张图片
guidata(hObject,handles);
bw=Plate;
%==============================车牌精确定位===============================
bw=rgb_huiduhua(bw);        %将车牌彩色图变换为灰度图
chepaihuidu = bw;
handles.chepaihuidu = chepaihuidu;     %第三张图片
guidata(hObject,handles);
%==========倾斜校正===========
qingxiejiao=rando_bianhuan(bw);
bw=imrotate(bw,qingxiejiao,'bilinear','crop');%取值为负值向右旋转
jiaozhenghou = bw;
handles.jiaozhenghou = jiaozhenghou;     %第四张图片，车牌倾斜矫正后的图片
guidata(hObject,handles);
waitbar(0.4);
%========数学形态学处理======
bw=im2bw(bw,graythresh(bw));   %graythresh函数找到二值化阈值
erzhihua = bw;
handles.erzhihua = erzhihua;     %第五张图片，二值化后的图片
guidata(hObject,handles);
bw=bwmorph(bw,'open',5); %  执行形态学开操作（先腐蚀后膨胀）
bw=bwmorph(bw,'hbreak',inf);% 'hbreak'移除连通的像素
bw=bwmorph(bw,'spur',inf);%   移除刺激（孤立）像素。
bw=bwmorph(bw,'open',5);% 执行形态学开操作（先腐蚀后膨胀）

% se=strel('disk',1);
% bw=imdilate(bw,se);         %开启操作  

xingtaixue = bw;
handles.xingtaixue = xingtaixue;   %第六张图片，第一次形态学处理后的图片
guidata(hObject,handles);
bw=~bw;  %转化车牌信息的颜色
%==对图像进一步裁剪，保证边框贴近字体====
bw=touying(bw);
waitbar(0.5);
bw=~bw;     %车牌信息为白色
diercijiancai = bw;
handles.diercijiancai = diercijiancai;     %第七张图片，第二次剪裁后的图片
guidata(hObject,handles);
bw = bwareaopen(bw, yuzhi);     %移除小对象
dierciyichu = bw;
handles.dierciyichu = dierciyichu;     %第八张图片，第二次移除小对象后的图片
guidata(hObject,handles);
bw=~bw;             %黑字白底
[y,~]=size(bw);%对长宽重新赋值
%=========================================字符分割============================================
fenge=shuzifenge(bw);
waitbar(0.7);
%============ 剪裁七个字符===========
han_zi  =bw( 1:y,fenge(1):fenge(2));
zi_mu   =bw( 1:y,fenge(3):fenge(4));
xuhao_1 =bw( 1:y,fenge(5):fenge(6));
xuhao_2 =bw( 1:y,fenge(7):fenge(8));
xuhao_3 =bw( 1:y,fenge(9):fenge(10));
xuhao_4 =bw( 1:y,fenge(11):fenge(12));
xuhao_5 =bw( 1:y,fenge(13):fenge(14));
%=====显示分割图像结果========
axes(handles.axes2);
imshow(han_zi);
axes(handles.axes15);
imshow(zi_mu);
axes(handles.axes16);
imshow(xuhao_1);
axes(handles.axes17);
imshow(xuhao_2);
axes(handles.axes18);
imshow(xuhao_3);
axes(handles.axes19);
imshow(xuhao_4);
axes(handles.axes20);
imshow(xuhao_5);
waitbar(0.8);
%==========================================识别================================================
%=======将分割后的字符归一化=========
guiyihua_hanzi =   imresize(han_zi, [110 70],'bilinear');
guiyihua_zimu  =   imresize(zi_mu,  [110 70],'bilinear'); 
guiyihua_xuhao1=  imresize(xuhao_1,[110 70],'bilinear');
guiyihua_xuhao2 = imresize(xuhao_2,[110 70],'bilinear');
guiyihua_xuhao3 = imresize(xuhao_3,[110 70],'bilinear');
guiyihua_xuhao4 = imresize(xuhao_4,[110 70],'bilinear');
guiyihua_xuhao5 = imresize(xuhao_5,[110 70],'bilinear');
%============ 把0-9 , A-Z以及省份简称的数据存储方便访问====================
muban_hanzi=guiyihua_muban_hanzi;
muban_hanzi = ~muban_hanzi;
%因数字和字母比例不同。这里要修改
muban_shuzizimu = guiyihua_muban_szzm;  
mubna_zimu  = guiyihua_muban_zimu;
waitbar(0.9);
%============================识别结果================================     
jieguohanzi  = shibiehanzi(muban_hanzi,guiyihua_hanzi);        shibiejieguo(1) =jieguohanzi;  i=2;
jieguozimu   = shibiezimu(mubna_zimu,guiyihua_zimu);           shibiejieguo(i) =jieguozimu;   i=i+1;
shibiejieguo(i) ='·';   i=i+1;
jieguozm_sz_1= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao1);   shibiejieguo(i) =jieguozm_sz_1;i=i+1;
jieguozm_sz_2= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao2);   shibiejieguo(i) =jieguozm_sz_2;i=i+1;
jieguozm_sz_3= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao3);   shibiejieguo(i) =jieguozm_sz_3;i=i+1;
jieguozm_sz_4= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao4);   shibiejieguo(i) =jieguozm_sz_4;i=i+1;
jieguozm_sz_5= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao5);   shibiejieguo(i) =jieguozm_sz_5;

handles.shibiejieguo=shibiejieguo;
guidata(hObject,handles);

set(handles.chepai,'string',shibiejieguo);  

%=====================导出文本==================
fid=fopen('Data.dat','a');
fprintf(fid,'%s\r\n',shibiejieguo,datestr(now));
fclose(fid);
%================读取计时==========================
t=toc;
set(handles.time,'string',t);
waitbar(1);
close(h);
else
    close(h);
end




function exit_Callback(hObject, eventdata, handles)
button=questdlg('确定退出系统吗？','确认','No');  %当按回车键时，返回default值default 必须是yes,no或cancel 之一。
if strcmp(button,'Yes')
    close all;
end


function about_Callback(hObject, eventdata, handles)
str={'车牌识别系统1.0';'完成人：徐柳'};
% 改变msgbox属性
% 寻找句柄，改变属性
hs = msgbox(str,'关于');
ht = findobj(hs, 'Type', 'text');
set(ht, 'FontWeight', 'bold','FontSize',12);


% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
str = get(hObject,'string');
axes(handles.show);
switch str
    case '原图'
        imshow(handles.yt);
    case '车牌粗定位图像'
        imshow(handles.Plate);
    case '车牌灰度图像'
        imshow(handles.chepaihuidu);
    case '车牌倾斜矫正后图像'
        imshow(handles.jiaozhenghou);
    case '车牌二值图像'
        imshow(handles.erzhihua);
    case '第一次形态学处理后'
        imshow(handles.xingtaixue);
    case '车牌精确定位图像'
        imshow(handles.diercijiancai);
    case '第二次形态学处理后'
        imshow(handles.dierciyichu);
end


%点击语音播报执行的函数
function sound_Callback(hObject, eventdata, handles)
duchushengyin(handles.shibiejieguo);
