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
test_img_prepr = true;
if test_img_prepr
    dir_name   = "./test_images/";
    file_names = ["mcgill.jpg", "cameraman.jpg", "manWithHat.tiff"];
    
    % Load Image
    file_path = dir_name + file_names(1);
    show_raw = false;
    I = img.load(file_path, show_raw);
    
    % Apply Preprocessing
    to_grayscale = true; 
    resize       = true;
    show_preproc = false;
    I = img.pre_process(I, to_grayscale, resize, show_preproc);

    % Blur Image
    [kernel, b] = img.add_blur(I, "disk", "circular");

    % Add Noise
    J = img.add_noise(b, "salt & pepper");
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