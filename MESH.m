%Les parametres doit initial//需要配置的参数--------------
definition = 3; %chaque combien de pixel retirer une point//分辨率，每五个像素取一个特征点
degreestep = 0.2; %dans le cas fixe pas mode,c'est un pas degree//固定步长的时候旋转的角度
angle = 0.663225; %la angle entre camera et laser//相机和激光的夹角

%initial les donner dans program//数据初始化------------
degree = 0;
temp = 1;

x = 0;
y = 0;
z = 0;
    
dataX = [];
dataY = [];
dataZ = [];

calcul = 1;

%Lire les photos//读取文件目录中的图片--------
dirs = dir ('D:\images\*.png');
dircell = struct2cell(dirs);
filenames = dircell(:);
path = strcat('D:\images','\',dirs().name)
num = size(dirs,1)

%circulation une fois trentement une image//每循环一次处理一张图片的数据
for ii = 1:num  
    %lire les photo//图像顺序读取
    filepath{ii} = strcat('D:\images','\',dirs(ii).name);
    
    Im = imread(filepath{ii});
    
    %trentement imaege//处理图像-----------------------------------------------
    Imgray = rgb2gray(Im);
    Impre= medfilt2(Imgray);
    %Impre= ordfilt2(Imgray,4,ones(3,3));
    %Imwiener = wiener2(Imgray,[3 3]); %二维自适应维纳滤波//2d wiener filtre
    %Thresh = graythresh(Impre);     %二值化插值
    Thresh = 0.9;
    Imagebinaire = im2bw(Impre,Thresh); %bipolarisation//二值化
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
                %z = i;%sens du model contre la sens du image//模型与图片方向相反
                z = imhight - i; %sens du model a la meme du image//模型与图片方向一致

                dataX(calcul) = x;
                dataY(calcul) = y;
                dataZ(calcul) = z;
                calcul = calcul + 1;
                
                axis([-imcenter imcenter -imcenter imcenter 0 imhight])
                plot3(x,y,z,'b.');
                
                %drawnow;
                hold on
                break;
            end
        end
    end
    
    degree = degree + (2*pi)/num
    
    %fixe degree mode//固定角度模式下的degree
    %degree = degree + degreestep 
end

namexls = {'X','Y','Z'};

% xlswrite('C:\360Downloads\data.xls',namexls, 1, 'A1:D1');
% xlswrite('C:\360Downloads\data.xls',dataX', 1, 'A2');
% xlswrite('C:\360Downloads\data.xls',dataY', 1, 'B2');
% xlswrite('C:\360Downloads\data.xls',dataZ', 1, 'C2');






