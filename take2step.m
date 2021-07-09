function [savedmap,peoplelisti]=take2step(map,peoplelisti,originalmap)
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
        if map(i,j)~=0&&map(i,j)~=8&&map(i,j)~=9%&&map(i,j)~=13%&&map(i,j)~=15
            map(i,j)=2;%��ȥ���ˡ��յأ�����Ϊ�ϰ�
        end
        if map(i,j)==8&&i~=peoplelisti(5)&&j~=peoplelisti(6)%����Ŀ����λ
            map(i,j)=2;%������Ϊ�ϰ�
        end
    end
end
map(peoplelisti(2),peoplelisti(3)) = 5; % ��ʼ��
map(peoplelisti(5),peoplelisti(6))=6;
%% ������ͼ
nrows = size(map,1); 
ncols = size(map,2); 
start_node = sub2ind(size(map), peoplelisti(2),peoplelisti(3)); 
dest_node = sub2ind(size(map), peoplelisti(5),peoplelisti(6)); 
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
                   (neighbor(:,2)<1) + (neighbor(:,2)>ncols ); %�ж���һ�������������Ƿ񳬳����ơ�
    locate = find(outRangetest>0); %���س��޵��������
    neighbor(locate,:)=[]; %����һ������������ȥ�����޵㡣
    neighborIndex = sub2ind(size(map),neighbor(:,1),neighbor(:,2)); %�����´���������������š�
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
    % ��̬��ʾ��·��
    
    map(route(2))=7;
    [xx,yy]=find(map==7);
    if (savedmap(xx,yy)==13)||(savedmap(xx,yy)==15)%����ǰһ�����ڴ򷹵��˻������Ŷӵ��˻�������������
        savedmap(route(1))=13;%ʲôҲ����
    else%ǰ��û���˵�
        if savedmap(xx,yy)==8
            peoplelisti(1)=14;
            peoplelisti(7)=0;%��ʱ
            savedmap(route(1))=0;
            savedmap(route(2))=14;
            peoplelisti(2)=xx;
            peoplelisti(3)=yy;
        else
            savedmap(route(1))=originalmap(route(1));
            savedmap(route(2))=13;
            peoplelisti(2)=xx;
            peoplelisti(3)=yy;
        end
    end
end
end