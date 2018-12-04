function titlestring= build_title_1Q1Q(operation,Tpos,T_vector)
switch operation
    case 'realpart'
        titlestring=['Real Part @ T = ' num2str(T_vector(Tpos)) ' fs'];
    case 'imagpart'
        titlestring=['Imaginary Part @ T = ' num2str(T_vector(Tpos)) ' fs'];
    case 'absolute'
        titlestring=['Absolute Signal @ T = ' num2str(T_vector(Tpos)) ' fs'];
    case 'absorptive'
        titlestring=['Absorptive Signal @ T = ' num2str(T_vector(Tpos)) ' fs'];
end