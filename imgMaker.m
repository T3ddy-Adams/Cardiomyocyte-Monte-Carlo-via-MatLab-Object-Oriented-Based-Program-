


imSize = 1600;
x=1600;
y=1600;

%default - dead center 
x0 = 800;
y0 = 800;
%generate a monte carlo frequecency for the amplitude
v0 = 20 % moving at pixels per second
%ac = 1

for t = 0:100

%medium sized dot 
ampl = 500;
sigma = 12;
noiseAmpl = 2;

%randomizer example, produces random number between 50 to 1000
%a = 50;
%b = 950;
%r = randi(b)+a;
div10 = mod(t,10);
    if div10 ==0;
        %ac = ac*-1;
        v0 = -v0;
    
    end;
   % if x0 <= 800
    %    %ac = ac*-1;
     %   v0=-v0;
    %end;
%lets randomize these parameters and make some crazy suckers
    %for x0 and y0
       % a = 400;
       % b = 800;
       time = 1; % a second
       dx = v0 * time;
       x0 = x0 + dx ;
       % y0 = randi(b)+a;

    %for ampl
       %x = v0 * t + 0.5*a*t^2;
       %ampl = ampl + x;

    %for sigma and noiseAmpl
        a = 1;
        b = 2;
        sigma = randi(b)+a;
        noiseAmpl = randi(b)+a;

%modeling image of a single bead as 2-dimensional guassian centered at x0
%and y0
[x y] = meshgrid(1:imSize,1:imSize); 
img = ampl * exp(-((x-x0).^2 +(y-y0).^2)/2/sigma^2); 

%Gaussian noise implemented using MATLAB randn
img2 = img + noiseAmpl * randn(size(img)); 

samplefilenames = "sample" + t + ".png"
directory = "Thomas_FFT/MonteCarloImages/" + samplefilenames
imwrite(img2, directory)
end;

numOfImages = 100;
output_filename = 'imgstack.tif';
for k=0:numOfImages
    samplefilenames = "sample" + k + ".png"
    directory = "Thomas_FFT/MonteCarloImages/" + samplefilenames
    loaded_image = imread(sprintf('%s',directory));
    imwrite(loaded_image, output_filename, 'WriteMode','append','Compression','none');
end;




