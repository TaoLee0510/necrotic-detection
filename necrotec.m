picture=imread('/Users/taolee/Desktop/Hela_paper/in vivo/alive_area/K_8_all.bmp');
%picture1=double(picture);
%image(picture)
grayimage=rgb2gray(picture);
% caculated by grayNormalize1
J3 = grayNormalize1(grayimage, 100, 255);  % 设变换后图像的均值为100，方差为255
% caculated by grayNormalize2
J2 = grayNormalize2(J3); 
bwpic1=mat2gray(J2);
bwpic2=mapminmax(bwpic1, 0, 1);
bwpic=im2uint8(bwpic2);
C=histeq(bwpic);
D=imadjust(C,[0.1 0.7],[]);
E=imadjust(picture,[0.1 0.7],[]);
J1=medfilt2(D,[1,1]); %5???????
%J1=uint8(J1);
%imshow(bwpic)
[a,b]=size(J1);
newbwpic=zeros(a,b);
newbwpic=uint8(newbwpic);
lower=100;%%90
upper=250;%%250
for i=1:1:a
    for j=1:1:b
        if J1(i,j)<=lower
            newbwpic(i,j)=J1(i,j);
        else
            newbwpic(i,j)=255;
        end
    end
end
newbwpic_d=zeros(a,b);
newbwpic_d=uint8(newbwpic_d);
for i=1:1:a
    for j=1:1:b
        if J1(i,j)>lower
            newbwpic_d(i,j)=J1(i,j);
        else
            newbwpic_d(i,j)=255;
        end
    end
end
newbwpic1=zeros(a,b);
newbwpic1=uint8(newbwpic1);
for i=1:1:a
    for j=1:1:b
        if J1(i,j)<=upper
            newbwpic1(i,j)=0;
        else
            newbwpic1(i,j)=255;
        end
    end
end
newbwpic_color=zeros(a,b,3);
newbwpic_color=uint8(newbwpic_color);
for i=1:1:a
    for j=1:1:b
        if newbwpic(i,j)~=255
            newbwpic_color(i,j,1)=picture(i,j,1);
            newbwpic_color(i,j,2)=picture(i,j,2);
            newbwpic_color(i,j,3)=picture(i,j,3);
        else
            newbwpic_color(i,j,1)=255;
            newbwpic_color(i,j,2)=255;
            newbwpic_color(i,j,3)=255;
        end
    end
end

newbwpic_d_color=zeros(a,b,3);
newbwpic_d_color=uint8(newbwpic_d_color);
for i=1:1:a
    for j=1:1:b
        if newbwpic_d(i,j)~=255
            newbwpic_d_color(i,j,1)=picture(i,j,1);
            newbwpic_d_color(i,j,2)=picture(i,j,2);
            newbwpic_d_color(i,j,3)=picture(i,j,3);
        else
            newbwpic_d_color(i,j,1)=255;
            newbwpic_d_color(i,j,2)=255;
            newbwpic_d_color(i,j,3)=255;
        end
    end
end

merge=zeros(a,b,3);
merge=uint8(merge);
for i=1:1:a
    for j=1:1:b
        if  newbwpic_d_color(i,j,1)==255 &&  newbwpic_color(i,j,1)==255
            merge(i,j,1)=255;
        else
            merge(i,j,1)=E(i,j,1);
        end
        if  newbwpic_d_color(i,j,2)==255 &&  newbwpic_color(i,j,2)==255
            merge(i,j,2)=255;
        else
            merge(i,j,2)=E(i,j,2);
        end
        if  newbwpic_d_color(i,j,3)==255 &&  newbwpic_color(i,j,3)==255
            merge(i,j,3)=255;
        else
            merge(i,j,3)=E(i,j,3);
        end
    end
end



subplot(221);
imshow(picture);
title('H&E Staining')
subplot(222);
imshow(merge);
title('Tissue Area')
subplot(223);
imshow(newbwpic_color);
title('Non-necrotic Area')
subplot(224);
imshow(newbwpic_d_color);
title('Necrotic Area')
saveas(1,['/Users/taolee/Desktop/Hela_paper/in vivo/alive_area/', 'K_8_color','.png'])


newbwpic_1=double(newbwpic);
newbwpic1_1=double(newbwpic1);
alive=zeros(a,b);
for i=1:1:a
    for j=1:1:b
        if newbwpic_1(i,j)==255
            alive(i,j)=0;
        else
            alive(i,j)=1;
        end
    end
end
total=zeros(a,b);
for i=1:1:a
    for j=1:1:b
        if newbwpic1_1(i,j)==255
            total(i,j)=0;
        else
            total(i,j)=1;
        end
    end
end
alive_area=sum(sum(alive));
total_area=sum(sum(total));
alive_ratio=alive_area/total_area;


