
t = Tiff('imgstack.tif','r');
imageData = read(t);

imshow(imageData);
title('imgstck ')

%figure; 
%imagesc(montage(imgStack))

imgStack = fft(imageData, 101,3);
af = abs(imgStack);

figure
plot(squeeze(imgStack(1:101,3,:)))
xlabel('time / frame #'); ylabel('intensity')
title('I(x,y,t)'); legend('sup browski')

   Fs = 1;                   % samples per second
   N = 101;            % samples
   dF = Fs/N;                 % hertz per sample
   f = -Fs/2:dF:Fs/2-dF + (dF/2)*mod(N,2);      % hertz
   Y1_fft = fftshift(fft(imgStack,101,3))/N;
   Yd = mean(abs(Y1_fft));
   
   lambda = mean(abs(Yd),'all')
    
   %lambda = 200;
   Velocity = mean(abs(lambda*f))

   %figure;
   %plot(f,abs(imgStack));