function [savedmap,peoplelist]=take1step(map,peoplelist,m,originalmap)
savedmap=map;
%% % set up color map for display 
% 1 - white - �յ�
% 2 - black - �ϰ� 
% 3 - red - ���������ĵط�
% 4 - blue - �´�������ѡ���� 
% 5 - green - ��ʼ��
% 6 - yellow -  ��Ŀ����·��
% �������ϰ�

for i=1:size(map,1)
    for j=1:size(map,2)
        if map(i,j)~=0&&map(i,j)~=11&&map(i,j)~=12&&map(i,j)~=13&&map(i,j)~=15
            map(i,j)=2;%��ȥ���ˡ��յأ�����Ϊ�ϰ�
        end
        if (map(i,j)==13||map(i,j)==15)&&originalmap(i,j)==9
            map(i,j)=2;%Ϊ�ϰ�
        end
    end
end
map(peoplelist(2,m),peoplelist(3,m)) = 5; %��ʼ��
map(peoplelist(5,m),peoplelist(6,m)) = 6; %��ʼ��

% if savedmap(peoplelist(5,m)+1,peoplelist(6,m))==12
%     map(peoplelist(5,m)+1,peoplelist(6,m))=1;%ʹ���㷨���Դ�͸�ȷ����˵���Ŀ��
% end
% for i=1:m
%     if peoplelist(1,i)==11&&i<m&&peoplelist(4,i)==peoplelist(4,m)%˵��ǰ������ͬ�Ϳڵ��˻�δ���
%         map(peoplelist(2,i),peoplelist(3,i))=6; %��ǰ������ΪĿ���
%         break;
%     end
%     if i==m
%         map(peoplelist(5,m),peoplelist(6,m)) = 6; %Ŀ���
%     end
% end
% [destx,desty]=find(map==6);
%% ������ͼ
nrows = size(map,1); 
ncols = size(map,2); 
start_node = sub2ind(size(map), peoplelist(2,m),peoplelist(3,m)); 
dest_node = sub2ind(size(map), peoplelist(5,m),peoplelist(6,m)); 
% ���������ʼ��
distanceFromStart = Inf(nrows,ncols); 
distanceFromStart(start_node) = 0; 
% ����ÿ������Ԫ��������鱣���丸�ڵ�������� 
parent = zeros(nrows,ncols); 

% ��ѭ��!!!!!!!!!!!!!!
while true 
    % �ҵ�������ʼ������Ľڵ�
    [min_dist, current] = min(distanceFromStart(:)); %���ص�ǰ�����������Сֵ��������
    if ((current == dest_node) || isinf(min_dist)) %������Ŀ������ȫ�������꣬����ѭ����
        break; 
    end; 

    map(current) = 3; %����ǰ��ɫ��Ϊ��ɫ��
    distanceFromStart(current) = Inf;  %��ǰ�����ھ�������������Ϊ�����ʾ��������
    [i, j] = ind2sub(size(distanceFromStart), current); %���ص�ǰλ�õ�����
    neighbor = [i-1,j;... 
            i+1,j;... 
            i,j+1;... 
            i,j-1]; %ȷ����ǰλ�õ�������������
    outRangetest = (neighbor(:,1)<1) + (neighbor(:,1)>nrows) +...
                   (neighbor(:,2)<1) + (neighbor(:,2)>ncols );%�ж���һ�������������Ƿ񳬳����ơ�
    locate = find(outRangetest>0); %���س��޵��������
    neighbor(locate,:)=[];%����һ������������ȥ�����޵㡣
    neighborIndex = sub2ind(size(map),neighbor(:,1),neighbor(:,2));%�����´���������������š�
    for i=1:length(neighborIndex) 
        if (map(neighborIndex(i))~=2) && (map(neighborIndex(i))~=3 && map(neighborIndex(i))~= 5) 
            map(neighborIndex(i)) = 4; %����´������ĵ㲻���ϰ���������㣬û���������ͱ�Ϊ��ɫ��
            if distanceFromStart(neighborIndex(i))> min_dist + 1      
                distanceFromStart(neighborIndex(i)) = min_dist+1; 
                parent(neighborIndex(i)) = current; %����ھ����������
            end 
        end 
    end 
end
%%
if (isinf(distanceFromStart(dest_node)))
    route = [];
else
    %��ȡ·������
    route = [dest_node];
    while (parent(route(1))~=0)
        route=[parent(route(1)), route];
    end
    % �ƶ�
    
    map(route(2))=7;
    [xx,yy]=find(map==7);
    
    if (savedmap(xx,yy)==12&&savedmap(xx-1,yy)==peoplelist(4,m))||(savedmap(xx,yy)==11)||(savedmap(xx,yy)==13)||(savedmap(xx,yy)==15)%����ǰһ�����ڴ򷹵��˻������Ŷӵ��˻�������������
        savedmap(route(1))=11;%ʲôҲ����
    else%ǰ��û�д򷹵�
        if xx-1==peoplelist(5,m)&&yy==peoplelist(6,m)%ǰ��û�д򷹵ģ�����Ŀ��ǰһ��
            peoplelist(2,m)=xx;
            peoplelist(3,m)=yy;
            peoplelist(1,m)=12;
            peoplelist(7,m)=0;
            savedmap(xx,yy)=12;
            savedmap(route(1))=0;
        else%ʲôҲû��
            peoplelist(2,m)=xx;
            peoplelist(3,m)=yy;
            savedmap(route(1))=0;
            savedmap(route(2))=11;
        end
    end
end