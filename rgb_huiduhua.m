function huidu = rgb_huiduhua(rgb)
[y,x,~] = size(rgb);
for a=1:y
    for b=1:x
        huidu(a,b) = 0.299*rgb(a,b,1)+0.587*rgb(a,b,2)+0.114*rgb(a,b,3);
    end
end