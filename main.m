clc;
%ģ��ʳ��60min
clear; 
%����ͼƬ
[pic,map,m,n]=LoadPic();
originalmap=map;
savedpic=pic;
%����һ����
peoplelist=zeros(8,1900);
peoplelist=intpeople(peoplelist,map);
% imshow(pic,'InitialMagnification','fit');
% pause(0.01);
% clf;
% data=zeros(size(map,1),size(map,2));

for t=1:5500%1������Ϊ1��
    clf;
    [pic,map,peoplelist]=move(pic,map,peoplelist,t,originalmap);
    %����ʵʱͼ��
    imshow(pic,'InitialMagnification','fit');hold on;
    title('ѧ��ʳ��');hold on;
    p=sprintf('%d',t);
    text(0,-1,p);hold on;
    pause(0.01);%����ͼ��100ms
%     imwrite(pic,strcat('pic-',num2str(t),'.png')); %�ؼ������

    pic=savedpic;
end