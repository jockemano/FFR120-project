clear all
clc
% addpath('classes/bug-model')
% addpath('classes/house-model')
AREA_SIZE = 50;

numberOfBugs = 1;
time = 1;
TIME_LIMIT = 40;

initialPosition = randi(AREA_SIZE,1,2);
X = [];
Y = [];

bug(1) = Bug(initialPosition(1), initialPosition(1), AREA_SIZE);
X = [X;bug(1).row];
Y = [Y;bug(1).col];

numberOfLivingBugs = zeros(TIME_LIMIT,1);

figure(1)
hold on
plot(X,Y,'.')
axis([0,AREA_SIZE,0,AREA_SIZE])
axis equal square
box on
title(['Simulation step = ' num2str(time)])
xlabel('X')
ylabel('Y')


while (time <= TIME_LIMIT)

    validStandard = 1;    
    numberOfBugs = numel(bug);

    for nBug = 1:numberOfBugs
        numberOfBugs = numel(bug);
        %validStandard = input('Whether the place is valid or not? ');
        bug(nBug) = bug(nBug).move(validStandard);
        X(nBug) = bug(nBug).row;
        Y(nBug) = bug(nBug).col;
        bug(nBug) = bug(nBug).grow();
        if (bug(nBug).age == 3)
            bug(nBug) = bug(nBug).reproduce;
            for iEgg = 1:bug(nBug).egg
                bug(numberOfBugs+iEgg) = Bug(bug(numberOfBugs).row,bug(numberOfBugs).col,AREA_SIZE);
                X = [X;bug(numberOfBugs+iEgg).row];
                Y = [Y;bug(numberOfBugs+iEgg).col];
            end
        end
        
        if (bug(nBug).age >= 10)
            bug(nBug) = bug(nBug).die;
        end
    end   
         
    % Plot
    if rem(time,1)==0
        cla
        plot(X,Y,'o','MarkerFaceColor','r')
        title(['Simulation step = ' num2str(time)])
        axis([0,AREA_SIZE,0,AREA_SIZE])
        drawnow update
    end
    
    numberOfLivingBugs(time) = length(find(~isnan(X)));
    
    time = time + 1;
    
end
