function [m A eigenfaces pr_img] = eigenface_core(database_path)
  % imaginile din fisierul de intrare sunt 200 x 200
   n = 200;
   T = zeros(n * n, 10);
   for i = 1 : 10
     % se realizeaza calea de acces catre fiecare imagine de la 1 la 10
     image_path = strcat(database_path, '/', num2str(i), '.jpg');
     R = double(rgb2gray(imread(image_path)));
     nr = 0;
     
     % se retine matricea citita ca un vector coloana in matricea T
     for j = 1 : n
       for k = 1 : n
          nr++;
          T(nr, i) = R(j, k);
       end
     end 
   end
   
   % se face media pe fiecare linie (se obtine fata comuna)
   m = zeros(n * n, 1);
   for i = 1 : n * n
     for j = 1 : 10
       m(i) = m(i) + T(i, j);
     end
     m(i) = m(i) / 10;
   end
   
   % se scade media fiecarei linii din aceasta
   A = T - m;
   [V D] = eig((A') * A);
   
   % se marcheaza cu 0 vectorii coloana corespunzatori valorilor proprii < 1
   for i = 1 : 10
     if D(i, i) < 1
       for j = 1 : 10
         V(j, i) = 0;
       end
     end
   end
   
   % se sterg coloanele numai cu 0-uri din matricea V
   V( :, ~any(V,1) ) = [];
   
   % se calculeaza matricea cu toate fetele si proiectia acesteia
   eigenfaces = A * V;
   pr_img = (eigenfaces') * A;
end