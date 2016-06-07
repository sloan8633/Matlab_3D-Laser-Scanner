%Les parametres doit initial//��Ҫ���õĲ���--------------
definition = 3; %chaque combien de pixel retirer une point//�ֱ��ʣ�ÿ�������ȡһ��������
degreestep = 0.2; %dans le cas fixe pas mode,c'est un pas degree//�̶�������ʱ����ת�ĽǶ�
angle = 0.663225; %la angle entre camera et laser//����ͼ���ļн�

%initial les donner dans program//���ݳ�ʼ��------------
degree = 0;
temp = 1;

x = 0;
y = 0;
z = 0;
    
dataX = [];
dataY = [];
dataZ = [];

calcul = 1;

%Lire les photos//��ȡ�ļ�Ŀ¼�е�ͼƬ--------
dirs = dir ('D:\images\*.png');
dircell = struct2cell(dirs);
filenames = dircell(:);
path = strcat('D:\images','\',dirs().name)
num = size(dirs,1)

%circulation une fois trentement une image//ÿѭ��һ�δ���һ��ͼƬ������
for ii = 1:num  
    %lire les photo//ͼ��˳���ȡ
    filepath{ii} = strcat('D:\images','\',dirs(ii).name);
    
    Im = imread(filepath{ii});
    
    %trentement imaege//����ͼ��-----------------------------------------------
    Imgray = rgb2gray(Im);
    Impre= medfilt2(Imgray);
    %Impre= ordfilt2(Imgray,4,ones(3,3));
    %Imwiener = wiener2(Imgray,[3 3]); %��ά����Ӧά���˲�//2d wiener filtre
    %Thresh = graythresh(Impre);     %��ֵ����ֵ
    Thresh = 0.9;
    Imagebinaire = im2bw(Impre,Thresh); %bipolarisation//��ֵ��
    %X = imbinarize(I);
    
    %'imhight' est haute du image//ͼƬ�߶ȣ�'imwide' est longeur du image//ͼƬ���
    [imhight,imwide] = size(Imagebinaire);
    
    imbottom = [];
    imtop = [];
    midwide = imwide/2;
    imcenter = midwide;
    %trouver le sommet point du image//���ͼƬ�Ķ�������
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
    
    %trouver le base point du image//���ͼƬ��͵�
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

    %scanner la linge dans image//ɨ������
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
                %z = i;%sens du model contre la sens du image//ģ����ͼƬ�����෴
                z = imhight - i; %sens du model a la meme du image//ģ����ͼƬ����һ��

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
    
    %fixe degree mode//�̶��Ƕ�ģʽ�µ�degree
    %degree = degree + degreestep 
end

namexls = {'X','Y','Z'};

% xlswrite('C:\360Downloads\data.xls',namexls, 1, 'A1:D1');
% xlswrite('C:\360Downloads\data.xls',dataX', 1, 'A2');
% xlswrite('C:\360Downloads\data.xls',dataY', 1, 'B2');
% xlswrite('C:\360Downloads\data.xls',dataZ', 1, 'C2');






