function [min_dist output_img_index] = face_recognition(image_path, m, A, eigenfaces, pr_img)
    % se citeste matricea fetei
    R = double(rgb2gray(imread(image_path)));
    [n n] = size(R);
    
    % se reprezinta matricea ca un vector coloana
    v = zeros(n * n, 1);
    nr = 0;
    for i = 1 : n
       for j = 1 : n
          nr++;
          v(nr) = R(i, j);
       end
    end
    
    % se elimina din vectorul coloana fata comuna si i se face proiectia
    v = v - m;
    pr_test_img = (eigenfaces') * v;
    
    % se cauta cea mai apropiata imagine de matricea data
    min_dist = 1000000000000;
    output_img_index = 0;
    for i = 1 : 10
      if norm(pr_test_img - pr_img(:, i)) < min_dist
        min_dist = norm(pr_test_img - pr_img(:, i));
        output_img_index = i;
      end
    end
end