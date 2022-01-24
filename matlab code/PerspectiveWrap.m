function [outputWrap] = PerspectiveWrap(I,papertype)
    hpaper=2970; %default A4
    wpaper=2100;
    if (strcmp(papertype,'StdPaper'))
        hpaper=2970;
        wpaper=2100;
        [h,w]=size(I);
        if h<w
            I=rot90(I,3);
        end
    end

    if (strcmp(papertype,'Passport'))
        hpaper=880*2;
        wpaper=1250*2;
    end

    if (strcmp(papertype,'Card'))
        hpaper=1080;
        wpaper=1712;
    end



    figure;
    imshow(I);

    pTemp=ginput(4);
    pI=pTemp;
    mind=100000;
    maxd=1;
    for i=1:4
        d2=pTemp(i,1)^2+pTemp(i,2)^2;
        if d2<mind
            mind=d2;
            pI(1,1)=pTemp(i,1);
            pI(1,2)=pTemp(i,2);
        end
    end
    for i=1:4
        d2=pTemp(i,1)^2+pTemp(i,2)^2;
        if d2>maxd
            maxd=d2;
            pI(4,1)=pTemp(i,1);
            pI(4,2)=pTemp(i,2);
        end
    end
    for i=1:4
        d2=pTemp(i,1)^2+pTemp(i,2)^2;
        if mind<d2&&d2<maxd&&pTemp(i,1)<pTemp(i,2)  
            pI(2,1)=pTemp(i,1);
            pI(2,2)=pTemp(i,2);
        end
    end
    for i=1:4
        d2=pTemp(i,1)^2+pTemp(i,2)^2;
        if mind<d2&&d2<maxd&&pTemp(i,1)>pTemp(i,2)  
            pI(3,1)=pTemp(i,1);
            pI(3,2)=pTemp(i,2);
        end
    end
    close;

    figure;
    t=tiledlayout(1,3);
    t.TileSpacing = 'compact';
    t.Padding = 'compact';
    nexttile;imshow(I);title('Original');

    I=uint16(I);
    I(uint16(pI(1,2)),uint16(pI(1,1)))=9999;%mark
    %I(uint16(pI(1,2)-1),uint16(pI(1,1))-1)=9999;%mark
    %I(uint16(pI(1,2)+1),uint16(pI(1,1))+1)=9999;%mark
    I(uint16(pI(4,2)),uint16(pI(4,1)))=9999;%mark
    %I(uint16(pI(4,2)-1),uint16(pI(4,1))-1)=9999;%mark
    %I(uint16(pI(4,2)+1),uint16(pI(4,1))+1)=9999;%mark
    pP=[1,1;1,hpaper;wpaper,1;wpaper,hpaper];



    tform= fitgeotrans(pI,pP,'projective');
    outputWrap=imwarp(I,tform,'linear');
    %outputWrap=uint8(zeros(hpaper,wpaper));

    %outputWrap=imcrop(outputWrap);
    [htemp,wtemp]=size(outputWrap);


    flag1=0;
    for x=1:htemp
        for y=1:wtemp
            if outputWrap(x,y)>255
                lucut1=x
                lucut2=y
                flag1=1;
            end
        end
        if flag1==1
            break
        end
    end

    flag2=0;
    for x=1:htemp
        for y=1:wtemp
            if outputWrap(htemp-x+1,wtemp-y+1)>255
                rdcut1=htemp-x+1
                rdcut2=wtemp-y+1
                flag2=1;
            end
        end
        if flag2==1
            break
        end
    end



    outputWrap=uint8(outputWrap);
    nexttile;imshow(outputWrap);title('Wraped');
    hold on;
    plot(lucut2,lucut1,'r.');
    plot(rdcut2,rdcut1,'r.');
    rect = [lucut2, lucut1, rdcut2-lucut2, rdcut1-lucut1];
    outputWrap=imcrop(outputWrap,rect);

    nexttile;imshow(outputWrap);title('Cropped');
    
    

end

