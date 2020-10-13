
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
% ���ϳ����Զ����ɣ������޸�


function xuliu_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
%��ʾ����ͼƬ
ha=axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'down');
II=imread('dabeijing.jpg');
image(II);
colormap gray;
set(ha,'handlevisibility','off','visible','off');


function varargout = xuliu_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
%�����ѡ��ͼƬ����ťִ�еĳ���
function open_Callback(hObject, eventdata, handles)
[filename,pathname] = uigetfile('*.jpg','ѡ��ͼƬ');
handles.filename = filename;
guidata(hObject,handles);
zhaopianlujing=[pathname filename];
handles.zhaopianlujing = zhaopianlujing;
guidata(hObject,handles);

%�������ʼʶ��ִ�еĳ���
function run_Callback(hObject, eventdata, handles)
tic;  %��������ʱ��
h=waitbar(0,'���Ե�......');  %������
yt=imread(handles.zhaopianlujing);   %ytΪԭʼͼ��
axes(handles.show);      %��ʾԭͼ
imshow(yt);
handles.yt = yt;               %��һ��ͼ
guidata(hObject,handles);
%================================���ƴֶ�λ===============================
waitbar(0.1);
[ydown,yup,xright,xleft]=first_bianjie(yt);

if  ydown>0
[ydown,yup,xright,xleft,yuzhi]=xiuzheng(ydown,yup,xright,xleft);  %����������������������
Plate = yt(yup:ydown,xleft:xright,:);
handles.Plate = Plate;   %����handles�ṹ���У������������ص������е��� �ڶ���ͼƬ
guidata(hObject,handles);
bw=Plate;
%==============================���ƾ�ȷ��λ===============================
bw=rgb_huiduhua(bw);        %�����Ʋ�ɫͼ�任Ϊ�Ҷ�ͼ
chepaihuidu = bw;
handles.chepaihuidu = chepaihuidu;     %������ͼƬ
guidata(hObject,handles);
%==========��бУ��===========
qingxiejiao=rando_bianhuan(bw);
bw=imrotate(bw,qingxiejiao,'bilinear','crop');%ȡֵΪ��ֵ������ת
jiaozhenghou = bw;
handles.jiaozhenghou = jiaozhenghou;     %������ͼƬ��������б�������ͼƬ
guidata(hObject,handles);
waitbar(0.4);
%========��ѧ��̬ѧ����======
bw=im2bw(bw,graythresh(bw));   %graythresh�����ҵ���ֵ����ֵ
erzhihua = bw;
handles.erzhihua = erzhihua;     %������ͼƬ����ֵ�����ͼƬ
guidata(hObject,handles);
bw=bwmorph(bw,'open',5); %  ִ����̬ѧ���������ȸ�ʴ�����ͣ�
bw=bwmorph(bw,'hbreak',inf);% 'hbreak'�Ƴ���ͨ������
bw=bwmorph(bw,'spur',inf);%   �Ƴ��̼������������ء�
bw=bwmorph(bw,'open',5);% ִ����̬ѧ���������ȸ�ʴ�����ͣ�

% se=strel('disk',1);
% bw=imdilate(bw,se);         %��������  

xingtaixue = bw;
handles.xingtaixue = xingtaixue;   %������ͼƬ����һ����̬ѧ������ͼƬ
guidata(hObject,handles);
bw=~bw;  %ת��������Ϣ����ɫ
%==��ͼ���һ���ü�����֤�߿���������====
bw=touying(bw);
waitbar(0.5);
bw=~bw;     %������ϢΪ��ɫ
diercijiancai = bw;
handles.diercijiancai = diercijiancai;     %������ͼƬ���ڶ��μ��ú��ͼƬ
guidata(hObject,handles);
bw = bwareaopen(bw, yuzhi);     %�Ƴ�С����
dierciyichu = bw;
handles.dierciyichu = dierciyichu;     %�ڰ���ͼƬ���ڶ����Ƴ�С������ͼƬ
guidata(hObject,handles);
bw=~bw;             %���ְ׵�
[y,~]=size(bw);%�Գ������¸�ֵ
%=========================================�ַ��ָ�============================================
fenge=shuzifenge(bw);
waitbar(0.7);
%============ �����߸��ַ�===========
han_zi  =bw( 1:y,fenge(1):fenge(2));
zi_mu   =bw( 1:y,fenge(3):fenge(4));
xuhao_1 =bw( 1:y,fenge(5):fenge(6));
xuhao_2 =bw( 1:y,fenge(7):fenge(8));
xuhao_3 =bw( 1:y,fenge(9):fenge(10));
xuhao_4 =bw( 1:y,fenge(11):fenge(12));
xuhao_5 =bw( 1:y,fenge(13):fenge(14));
%=====��ʾ�ָ�ͼ����========
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
%==========================================ʶ��================================================
%=======���ָ����ַ���һ��=========
guiyihua_hanzi =   imresize(han_zi, [110 70],'bilinear');
guiyihua_zimu  =   imresize(zi_mu,  [110 70],'bilinear'); 
guiyihua_xuhao1=  imresize(xuhao_1,[110 70],'bilinear');
guiyihua_xuhao2 = imresize(xuhao_2,[110 70],'bilinear');
guiyihua_xuhao3 = imresize(xuhao_3,[110 70],'bilinear');
guiyihua_xuhao4 = imresize(xuhao_4,[110 70],'bilinear');
guiyihua_xuhao5 = imresize(xuhao_5,[110 70],'bilinear');
%============ ��0-9 , A-Z�Լ�ʡ�ݼ�Ƶ����ݴ洢�������====================
muban_hanzi=guiyihua_muban_hanzi;
muban_hanzi = ~muban_hanzi;
%�����ֺ���ĸ������ͬ������Ҫ�޸�
muban_shuzizimu = guiyihua_muban_szzm;  
mubna_zimu  = guiyihua_muban_zimu;
waitbar(0.9);
%============================ʶ����================================     
jieguohanzi  = shibiehanzi(muban_hanzi,guiyihua_hanzi);        shibiejieguo(1) =jieguohanzi;  i=2;
jieguozimu   = shibiezimu(mubna_zimu,guiyihua_zimu);           shibiejieguo(i) =jieguozimu;   i=i+1;
shibiejieguo(i) ='��';   i=i+1;
jieguozm_sz_1= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao1);   shibiejieguo(i) =jieguozm_sz_1;i=i+1;
jieguozm_sz_2= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao2);   shibiejieguo(i) =jieguozm_sz_2;i=i+1;
jieguozm_sz_3= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao3);   shibiejieguo(i) =jieguozm_sz_3;i=i+1;
jieguozm_sz_4= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao4);   shibiejieguo(i) =jieguozm_sz_4;i=i+1;
jieguozm_sz_5= shibiezm_sz(muban_shuzizimu,guiyihua_xuhao5);   shibiejieguo(i) =jieguozm_sz_5;

handles.shibiejieguo=shibiejieguo;
guidata(hObject,handles);

set(handles.chepai,'string',shibiejieguo);  

%=====================�����ı�==================
fid=fopen('Data.dat','a');
fprintf(fid,'%s\r\n',shibiejieguo,datestr(now));
fclose(fid);
%================��ȡ��ʱ==========================
t=toc;
set(handles.time,'string',t);
waitbar(1);
close(h);
else
    close(h);
end




function exit_Callback(hObject, eventdata, handles)
button=questdlg('ȷ���˳�ϵͳ��','ȷ��','No');  %�����س���ʱ������defaultֵdefault ������yes,no��cancel ֮һ��
if strcmp(button,'Yes')
    close all;
end


function about_Callback(hObject, eventdata, handles)
str={'����ʶ��ϵͳ1.0';'����ˣ�����'};
% �ı�msgbox����
% Ѱ�Ҿ�����ı�����
hs = msgbox(str,'����');
ht = findobj(hs, 'Type', 'text');
set(ht, 'FontWeight', 'bold','FontSize',12);


% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
str = get(hObject,'string');
axes(handles.show);
switch str
    case 'ԭͼ'
        imshow(handles.yt);
    case '���ƴֶ�λͼ��'
        imshow(handles.Plate);
    case '���ƻҶ�ͼ��'
        imshow(handles.chepaihuidu);
    case '������б������ͼ��'
        imshow(handles.jiaozhenghou);
    case '���ƶ�ֵͼ��'
        imshow(handles.erzhihua);
    case '��һ����̬ѧ�����'
        imshow(handles.xingtaixue);
    case '���ƾ�ȷ��λͼ��'
        imshow(handles.diercijiancai);
    case '�ڶ�����̬ѧ�����'
        imshow(handles.dierciyichu);
end


%�����������ִ�еĺ���
function sound_Callback(hObject, eventdata, handles)
duchushengyin(handles.shibiejieguo);
