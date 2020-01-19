close all; clear; clc;

maxdif = 0;
minf = 7;
maxf = 8;
for c = minf:maxf
    filename = strcat('BoozeBuddyCsvConverter/test', int2str(c), '.csv')
    %filename = strcat('guess.csv')
    data = load(filename);

    %data(:,10) = (data(:,8) ~= 0 | data(:,9) ~= 0);
    drinking = data(:,10);
    
    h = 100;
    figure('Position', [0, h*(c-minf) + 50, 3000, h])
    %figure(1)
    
    %time = data(:,1);
    time = 1:numel(data(:,1));
    xpos = data(:,2);
    ypos = data(:,3);
    zpos = data(:,4);
    xacc = data(:,5)*15;
    yacc = data(:,6)*15;
    zacc = data(:,7)*15;

    myDrink = zeros(1,numel(drinking));
    myDrink(ypos > xpos) = 1;
    
    
    % remove small streaks (<10)
    threshhold = 10;
    i = 1;
    while i < numel(myDrink)
        if myDrink(i) == 1
            % find end of streak
            j = i;
            while myDrink(j) == 1
                j = j + 1;
            end
            % delete if len < 10
            if j - i < threshhold
                myDrink(i:j) = 0;
            end
            i = j;
        end
        i = i + 1;
    end
    
    % remove some false positives?
    i = 1;
    while i < numel(myDrink)
        % find streak start
        while myDrink(i) == 0 && i < numel(myDrink)-2
            i = i + 1;
        end
        j = i;
        while myDrink(j) == 1 && j < numel(myDrink)-1
            j = j + 1;
        end
        % truncated range in streak
        try
            l1 = xacc;
            l2 = yacc;
                    
            it = i + floor(threshhold/2);
            jt = j - floor(threshhold/2);
            
            for k = it:jt
                if l1(k) >= 0
                    l1(k) = l1(k+1);
                end
                if l2(k) <= 0
                    l2(k) = l2(k+1);
                end
            end
            
            if (max(l1(it:jt)) - min(l1(it:jt))) > 10 || ...
               (max(l2(it:jt)) - min(l2(it:jt))) > 10
                myDrink(i:j) = 0;
            end
            xacc = l1;
            yacc = l2;
        catch err
        end
        
        i = j + 1;
    end
    %}
    hold on
    
    %legend('xacc', 'yacc', 'zacc', 'Location', 'eastoutside')
    
    % draw drinking times
    limits = 50;
    i = 1;
    while i < numel(myDrink)
        if myDrink(i) && drinking(i)
            j = i;
            while myDrink(j) && drinking(j)
                j = j + 1;
            end
            a = area([i,j],[limits,limits], -1*limits, 'LineStyle', ':');
            a.FaceColor = [1,1,0];
            j = i;
        elseif myDrink(i)
            j = i;
            while myDrink(j)
                j = j + 1;
            end
            a = area([i,j],[limits,limits], -1*limits, 'LineStyle', ':');
            a.FaceColor = [0,1,0];
            j = i;
        elseif drinking(i)
            j = i;
            while drinking(j)
                j = j + 1;
            end
            a = area([i,j],[limits,limits], -1*limits, 'LineStyle', ':');
            a.FaceColor = [0,0,0];
            j = i;
        end
        i = i + 1;
	end
    plot(time, xpos, 'r-')
    plot(time, ypos, 'g-')
    plot(time, zpos, 'b-')
    %plot(time, xacc, 'r--')
    %plot(time, yacc, 'g--')
    %plot(time, zacc, 'b--')
    
    %}
    legend('x', 'y', 'z', 'xacc', 'yacc', 'zacc', 'Location', 'eastoutside')
    title(filename)
    
    hold off
end
