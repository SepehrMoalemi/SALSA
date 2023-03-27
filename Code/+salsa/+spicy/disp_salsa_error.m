%% Purpose: Display tipped salsa bottle for error message
function disp_salsa_error()
    msg = sprintf("Oh no looks like you spilled something:\n" + ...
        "     _______________________             \n" + ...
        "    / /***|| S ||****       \\            \n" + ...
        "   | |****|| A ||*******   [ ]           \n" + ...
        "   | |****|| L ||********* [ ]           \n" + ...
        "   | |****|| S ||**********[*]** *       \n" + ...
        "   | |****|| A ||**********[*]*******    \n" + ...
        "    \\_\\___________________ /*************\n");
    fprintf(2,'%s',msg)
end