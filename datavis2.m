close all; clear; clc; 
n = 2;
%{
for n = 1:4
    if n == 1
        filename = strcat('BoozeBuddyCsvConverter/watchdata_drinkpour1.txt');
    elseif n == 2
        filename = strcat('BoozeBuddyCsvConverter/watchdata_normdrink1.txt');
    elseif n == 3
        filename = strcat('BoozeBuddyCsvConverter/watchdata_seq1.txt');
    elseif n == 4
        filename = strcat('BoozeBuddyCsvConverter/watchdata_3edge3_1.txt');
    end
%}  
    filename = strcat('guess.csv')
    data = load(filename);

    time = 1:numel(data(:,1));
    xrot = data(:,2);
    yrot = data(:,3);
    zrot = data(:,4);
    deanGuess = data(:,9);

    myDrink = zeros(1,numel(time));
    myDrink(xrot > yrot) = 1;

    deanDrink = zeros(1,numel(deanGuess));
    deanDrink(deanGuess' > 0.5) = 1;
    
    th = 50; % streak threshhold
    
    figure('Position', [0, 200, 3000, 500]);
    hold on
    c = 2;
    while c < numel(deanDrink)-2
        while deanDrink(c)
            d = c;
            while deanDrink(d) && d < numel(deanDrink)-1
                d = d + 1;
                %xline(d);
            end
            %
            if d-c > 1
                lim = 40;
                a = area([c,d],[lim,lim], -1*lim ,'LineStyle', ':');
                a.FaceColor = [0,0,0];
                
            end
            %}
            c = d;
        end
        c = c + 1;
    end
    %{
    c = 1;
    while c < numel(time)
        if myDrink(c)
            d = c;
            while myDrink(d) && d < numel(time)-1
                d = d + 1;
            end
            if d - c >= th
                c2 = c + floor(th/2);
                d2 = d - floor(th/2);
                xline(c2, 'r');
                xline(d2, 'r');
                zpass = false;
                for i = c2:d2
                    if yrot(i) > zrot(i)
                        zpass = true;
                    end
                end
                if (max(xrot(c2:d2)) - min(xrot(c2:d2))) < 0.5 && ...
                        (max(yrot(c2:d2)) - min(yrot(c2:d2))) < 0.5 %&& ...
                        %zpass
                    
                    lim = 4;
                    a = area([c,d],[lim,lim], -1*lim,'LineStyle', ':');
                    a.FaceColor = [0,1,0];
                end
                %lim = 10;
                %a = area([c,d],[lim,lim], -1*lim,'LineStyle', ':');
                %a.FaceColor = [1,1,0];
            end
            c = d;
        end
        c = c + 1;
    end
    %}
    axis tight
    plot(time, xrot, 'r-')
    plot(time, yrot, 'g-')
    plot(time, zrot, 'b-')
    %legend('xrot', 'yrot', 'zrot', 'Location', 'eastoutside')
    title(filename)

    hold off
%end