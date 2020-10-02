function qingxiejiao=rando_bianhuan(I)
I=edge(I);
theta = 1:180;
[R,~] = radon(I,theta);
[~,J] = find(R>=max(max(R)));%J¼ÇÂ¼ÁËÇãĞ±½Ç
qingxiejiao=90-J;
