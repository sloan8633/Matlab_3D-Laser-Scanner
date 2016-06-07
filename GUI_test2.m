function varargout = GUI_test2(varargin)
% GUI_TEST2 MATLAB code for GUI_test2.fig
%      GUI_TEST2, by itself, creates a new GUI_TEST2 or raises the existing
%      singleton*.
%
%      H = GUI_TEST2 returns the handle to a new GUI_TEST2 or the handle to
%      the existing singleton*.
%
%      GUI_TEST2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TEST2.M with the given input arguments.
%
%      GUI_TEST2('Property','Value',...) creates a new GUI_TEST2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_test2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_test2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_test2

% Last Modified by GUIDE v2.5 23-May-2016 16:55:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_test2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_test2_OutputFcn, ...
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
% End initialization code - DO NOT EDIT

% --- Executes just before GUI_test2 is made visible.
function GUI_test2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_test2 (see VARARGIN)

% Choose default command line output for GUI_test2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_test2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_test2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function definition_Callback(hObject, eventdata, handles)
% hObject    handle to definition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of definition as text
%        str2double(get(hObject,'String')) returns contents of definition as a double
defini = str2double(get(hObject, 'String'));
if isnan(defini)
    set(hObject, 'String', 0);
    errordlg('Definition should be a number','Error');
end

% Save the new density value
handles.metricdata.definition = defini;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function definition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to definition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in leave.
function leave_Callback(hObject, eventdata, handles)
% hObject    handle to leave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reset_number(gcbf, handles, true);

function reset_number(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.

handles.metricdata.angle = 0.663225;
handles.metricdata.definition  = 5;

set(handles.angle, 'String', handles.metricdata.angle);
set(handles.definition,  'String', handles.metricdata.definition);

% Update handles structure
guidata(handles.figure1, handles);
% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

function angle_Callback(hObject, eventdata, handles)
% hObject    handle to angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angle as text
%        str2double(get(hObject,'String')) returns contents of angle as a double
ang = str2double(get(hObject, 'String'));
if isnan(ang)
    set(hObject, 'String', 1);
    errordlg('Angle should be a number','Error');
end

% Save the new angle value
handles.metricdata.angle = ang;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when selected object is changed in languagegroup.
function languagegroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in languagegroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (hObject == handles.chinese)
    set(handles.text3, 'String', '激光和相机夹角');
    set(handles.text2, 'String', '建模分辨率');
    set(handles.start, 'String', '计算');
    set(handles.leave, 'String', '重置');
    set(handles.numphoto, 'String', '图片数：');    
else
    set(handles.text3, 'String', 'Angle entre camera et laser');
    set(handles.text2, 'String', 'Definition');
    set(handles.start, 'String', 'Calcule');
    set(handles.leave, 'String', 'Reset');
    set(handles.numphoto, 'String', 'Numbre du photo:');
    
end
% --- Executes on button press in chinese.

function chinese_Callback(hObject, eventdata, handles)
% hObject    handle to chinese (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chinese


% --- Executes on button press in french.
function french_Callback(hObject, eventdata, handles)
% hObject    handle to french (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of french

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Les parametres doit initial//需要配置的参数--------------
definition = handles.metricdata.definition%chaque combien de pixel retirer une point//分辨率，每五个像素取一个特征点
angle = handles.metricdata.angle %la angle entre camera et laser//相机和激光的夹角

set(handles.languagegroup, 'SelectedObject', handles.chinese);%initial la langue du chinoise//初始化界面语言为中文

%initial les donner dans program//数据初始化--------------
degree = 0;
temp = 1;

x = 0;
y = 0;
z = 0;
    
dataX = [];
dataY = [];
dataZ = [];

calcul = 1;

%Lire les photos//读取文件目录中的图片----------------------
dirs = dir ('D:\images\*.png');
dircell = struct2cell(dirs);
filenames = dircell(:);
path = strcat('D:\images','\',dirs().name)
num = size(dirs,1)

text8 = num;
set(handles.text8, 'String', text8);


figure('numbertitle','off','name','Model');

%circulation une fois trentement une image//每循环一次处理一张图片的数据
for ii = 1:num  
    %lire les photo//图像顺序读取
    filepath{ii} = strcat('D:\images','\',dirs(ii).name);
    
    Im = imread(filepath{ii});
    
    %trentement imaege//处理图像-----------------------------
    Imgray = rgb2gray(Im);
    Impre= medfilt2(Imgray);
    %Impre = Imgray;
    %Impre= ordfilt2(Imgray,4,ones(3,3));
    %Imwiener = wiener2(Imgray,[3 3]); %二维自适应维纳滤波//2d wiener filtre
    %Thresh = graythresh(Impre);     %二值化插值
    Thresh = 0.9;
    Imagebinaire = im2bw(Impre,Thresh); %二值化
    %X = imbinarize(I);
    
    %'imhight' est haute du image//图片高度，'imwide' est longeur du image//图片宽度
    [imhight,imwide] = size(Imagebinaire);
    
    imbottom = [];
    imtop = [];
    midwide = imwide/2;
    imcenter = midwide;
    %trouver le sommet point du image//检测图片的顶端坐标
    temp = 1;
    for j=1:imwide
        for i=1:imhight
            if Imagebinaire(i,j)==1
                imtop(temp)=i;
                temp=temp+1;
                break;
            end
        end
    end
    highthdec=min(imtop);
    
    %trouver le base point du image//检测图片最低点
    temp = 1;
    for j = 1:imwide
        for i = imhight:-1:1;
            if Imagebinaire(i,j)==1
                imbottom(temp) = i;
                temp = temp +1;
                break;
            end
        end
    end
    hightbase = max(imbottom);

    %scanner la linge dans image//扫描坐标
    for i = highthdec:definition:hightbase
        for j = 1:imwide
            if Imagebinaire(i,j)==1
                if(j<imcenter)
                    rad = imcenter - j;
                    radius = rad/sin(angle);
                    x = radius * cos(degree);
                    y = radius * sin(degree);
                else
                    rad = j - imcenter;
                    radius = rad/sin(angle);
                    x = radius * cos(degree + pi);
                    y = radius * sin(degree + pi);
                    
                end
                z = i;%sens du model contre la sens du image//模型与图片方向相反
                %z = imhight - i; %sens du model a la meme du image//模型与图片方向一致

                dataX(calcul) = x;
                dataY(calcul) = y;
                dataZ(calcul) = z;
                calcul = calcul + 1;
                
                axis([-imcenter imcenter -imcenter imcenter 0 imhight])
                plot3(x,y,z,'b.');
                
                drawnow;
                                
                hold on
                break;
            end
        end
    end
    
    degree = degree + (2*pi)/num
    
    %fixe degree mode//固定角度模式下的degree
    %degree = degree + degreestep 
end

%namexls = {'X','Y','Z'};
% xlswrite('C:\360Downloads\data.xls',namexls, 1, 'A1:D1');
% xlswrite('C:\360Downloads\data.xls',dataX', 1, 'A2');
% xlswrite('C:\360Downloads\data.xls',dataY', 1, 'B2');
% xlswrite('C:\360Downloads\data.xls',dataZ', 1, 'C2');
