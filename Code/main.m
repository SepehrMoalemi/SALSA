%% Purpose:Image De-blurring and De-noising
clc; clear; close all;

%% Parameters
spicy = false;  %Spicy activates the "./+salsa/+spicy" sub package of easter eggs 

%% Testing setting default input values
test_set_def_input = false;
if test_set_def_input
    i.maxiter = 69;
    i.tcp = 12;
    i = salsa.aux.default_input_param_completion(i);
end

%% Testing Image preprocessing
test_img_prepr = false;
if test_img_prepr
    dir_name   = "./test_images/";
    file_names = ["mcgill.jpg", "cameraman.jpg", "manWithHat.tiff"];
    
    % Load Image
    file_path = dir_name + file_names(2);
    show_raw = true;
    I = img.load(file_path, show_raw);
    
    % Apply Preprocessing
    to_grayscale = true; 
    resize       = true;
    show_preproc = false;
    I = img.pre_process(I, to_grayscale, resize, show_preproc);

    % Blur Image
    [kernel, b] = img.add_blur(I, "motion", "circular");

    % Add Noise
    J = img.add_noise(b, "salt & pepper");
end

%% Testing boxProx
test_box_prox = false;
if test_box_prox
    % random matrix size mxn in interval (a,b)
    m = 5; n = 1;
    a = -2; b = 4;
    x = a + (b-a).*rand(m, n)

    % Get boxProx 
    l = 0; u = 1;
    prox_x = salsa.aux.boxProx(x, l, u)
    
    % Find min sol using matlab
    x = x(:);
    prox = @(y) norm(x - y);
    lb = l*ones(m,n); ub = u*ones(m,n);
    x_opt = fmincon(prox,x,[],[],[],[],lb,ub);
    x_opt = reshape(x_opt, m, [])
end

%% Testing l1Prox
test_l1_prox = false;
if test_l1_prox
    % random matrix size mxn in interval (a,b)
    m = 5; n = 4;
    a = -2; b = 4;
    x = a + (b-a).*rand(m, n);
    

    % Get l1 prox
    lambda = 2;
    prox_x = salsa.aux.l1Prox(x, lambda)
    
    % Find min sol using matlab
    x = x(:);
    f = @(x) norm(x,1);
    prox = @(y) (1/2)*norm(x - y)^2 + lambda*f(y);
    x_opt = fmincon(prox,x);
    x_opt = reshape(x_opt, m, [])
end

%% Testing l2Prox
test_l2_prox = true;
if test_l2_prox
    % random matrix size mxn in interval (a,b)
    m = 5; n = 2;
    a = -2; b = 4;
    x = a + (b-a).*rand(m, n);
    

    % Get l1 prox
    lambda = 2;
    prox_x = salsa.aux.l2Prox(x, lambda)
    
    % Find min sol using matlab
    x_opt = zeros(m,n);
    f = @(x) norm(x,2);
    for i=1:n
        xi = x(:,i);
        prox = @(y) (1/2)*norm(xi - y)^2 + lambda*f(y);
        x_opt(:,i) = fmincon(prox,xi);
    end
    x_opt
end


%% TODO
%{
    +salsa/+defaults/get_input_param_def : Choose which defualt values to pick
%}

%% Spicy Command List
%{
    salsa.spicy.disp_salsa_bottle()
    salsa.spicy.disp_salsa_error()
    salsa.spicy.spill_the_beans()
%}