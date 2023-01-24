classdef WellImageClass 
    properties
        ImageSize                       % m value for a m x m image 
        time                            % time value for the image
        numberOfBeads                   % number of beads in this image
        sigma           
        noiseAmpl     
        beadArray                      %creates an array of our beads
        Image                           % The image
    end
    methods
        function obj = WellImageClass(imgSz)
            obj.time = 0;
            obj.ImageSize = imgSz;
            obj.numberOfBeads = 0;
            numBeads= (randi([0 25]));   % instantiates anywhere from 0 to 100 beads in our well image
            display(numBeads);
            obj.numberOfBeads = numBeads;
            
            objArray= [BeadsClass(0,0,0,0,0.4470,0.4470,0),BeadsClass(imgSz/4,imgSz/4,0,0,0.4470,0.4470,0)]

            for i = 1:numBeads
                xcord = randi(imgSz)+0;
                ycord = randi(imgSz)+0;

                viable = randi(3);                    % random value between 0 and 1, 1 - dead, 0 - alive
                if viable ==3
                    viable =1;
                else 
                    viable = 0;
                end 
   
                freqW = randi(11.0001-0.0001)-1;        % the rate of change of the brightness can be anywhere from 0 10 for the brightness                   
                maxAmp = randi(10)+10;                               % note in matlab, green has a value between 10-20 for 0-255 scale
                PhaseO = randi(361)-1;              % random phase shift between 0 - 2π
                PhaseO = PhaseO*pi/180;

                % begin initalization of all beads in well
                
                newbead = BeadsClass(xcord,ycord,viable,freqW,0.4470,0.4470,PhaseO)
                objArray(end+1) = newbead;
           

            obj.beadArray = objArray;  

                pause(0.5);
            
            end

        end

        function g = get.numberOfBeads(obj)
            g = obj.numberOfBeads;
        end
        
        function r = imageAtTimet(obj, time, imgSz)    % creates image at desiganetd time with the beads at there designated brightness
                                                % call the Amplitude of
                                                % brightness function in
                                                 % bead class in order
                                                
            x0 = imgSz/2;
            y0 = imgSz/2;
            ampl =1;
            obj.noiseAmpl = randi(2);
            obj.sigma = randi(2);

            [x, y] = meshgrid(1:imgSz,1:imgSz); 
            img = ampl * exp(-((x-x0).^2 +(y-y0).^2)/2/obj.sigma^2); 
            obj.Image = obj.noiseAmpl * randn(size(img));   % Creates a noise image background the image of the well
            
            figure('Visible','on')
            imshow(obj.Image)

            for i = 1:obj.numberOfBeads
                hold on

                objArray = obj.beadArray;

                currentBead = objArray(i)
                xb = currentBead.xCord;
                yb = currentBead.yCord;

                w = currentBead.BeatFrequency;
                A = currentBead.MaxAmplitude;
                t = time; 
                p = currentBead.InitialPhase;
                s = A*cosd((w*t + p)*2/pi);


                greenValue =[0.0 s 0.0];

                plot(xb,yb,'Color',greenValue,'Marker','hexagram','MarkerSize',14,'LineWidth',15)    
           end
            
               
             
        end
    end
end








