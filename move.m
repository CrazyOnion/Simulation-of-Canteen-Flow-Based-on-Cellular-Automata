function [pic,map,peoplelist]=move(pic,map,peoplelist,t,originalmap)
for i=1:size(peoplelist,2)%��peoplelist����
    if peoplelist(1,i)==0&&peoplelist(8,i)==t
        peoplelist(1,i)=11;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if peoplelist(1,i)==11%�����ҲͿ�&�Ŷӣ�����
        [map,peoplelist]=take1step(map,peoplelist,i,originalmap);
        continue;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if peoplelist(1,i)==12%���ڴ�ͣ���ʱ������
        peoplelist(7,i)=peoplelist(7,i)+1;
        if peoplelist(7,i)>=20%��ʱ��Ϊ15s
            peoplelist(1,i)=13;
        end
        continue;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if peoplelist(1,i)==13%��������λ������
        peoplelist(4,i)=8;
        d=999999999999;
        for m=1:size(map,1)%Ѱ�����������λ
            for n=1:size(map,2)
                if map(m,n)==8&&sqrt((m-peoplelist(2,i))^2+(n-peoplelist(3,i))^2)<d
                    aimx=m;
                    aimy=n;
                    d=sqrt((m-peoplelist(2,i))^2 + (n-peoplelist(3,i))^2);
                end
            end
        end
        if d==999999999999%��ʱû�ҵ���λ
            peoplelist(1,i)=15;
            map(peoplelist(2,i),peoplelist(3,i))=15;
            peoplelist(5,i)=46;%�������
            peoplelist(6,i)=59+round(2*rand());%�������
            [map,peoplelist(:,i)]=take3step(map,peoplelist(:,i),originalmap);
            if peoplelist(1,i)==15%��û���뿪ʳ��
                peoplelist(1,i)=13;%�ٽ�״̬�л�����
                map(peoplelist(2,i),peoplelist(3,i))=13;
            end
        else%�ҵ���λ��
            peoplelist(5,i)=aimx;
            peoplelist(6,i)=aimy;
            [map,peoplelist(:,i)]=take2step(map,peoplelist(:,i),originalmap);
        end
        continue;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if peoplelist(1,i)==14%���ڳԷ���������
        peoplelist(7,i)=peoplelist(7,i)+1;
        if peoplelist(7,i)>=720+300*rand()%�Է�ʱ��
            peoplelist(1,i)=15;
            peoplelist(4,i)=10;
            peoplelist(7,i)=0;
            peoplelist(5,i)=46;
            peoplelist(6,i)=59+round(2*rand());
        end
        continue;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if peoplelist(1,i)==15%���뿪����
        [map,peoplelist(:,i)]=take3step(map,peoplelist(:,i),originalmap);
        continue;
    end
end

%���˻���ͼ����
for i=1:size(peoplelist,2)
    if peoplelist(1,i)>=11&&peoplelist(1,i)<=16
       pic(peoplelist(2,i),peoplelist(3,i),1)=255;
       pic(peoplelist(2,i),peoplelist(3,i),2)=255*(mod(255*i/size(peoplelist,2),3)/3);
       pic(peoplelist(2,i),peoplelist(3,i),3)=0;
    end
end

% %�����ȶ�ͼ
% for i=1:size(map,1)
%     for j=1:size(map,2)
%         if map(i,j)==11||map(i,j)==13||map(i,j)==15
%             data(i,j)=data(i,j)+1;
%         end
%     end
% end
    

end