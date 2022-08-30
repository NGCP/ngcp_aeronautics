% Find all unique airoils
airfoil_list = [];
n_airfoils = 0;
non_unique = false;
counter = ones(1,11);
for i = 1:length(prop)
    aero = prop(i).aero;
    for j = 1:length(aero)
        airfoil_name_c = aero(j).aifoil_name;
        if n_airfoils == 0
            n_airfoils = n_airfoils +1;
            airfoil_list = [airfoil_list airfoil_name_c];
            counter(1) = 1;
        end
        non_unique = false;
        for k = 1:length(airfoil_list)
            if airfoil_name_c == airfoil_list(k)
                non_unique = true;
                counter(k) = counter(k) + 1;
            end
        end
        if ~non_unique
            airfoil_list = [airfoil_list airfoil_name_c];
            n_airfoils = n_airfoils+1;
        end
    end
end