function qingxiejiao=rando_bianhuan(I)
I=edge(I);
theta = 1:180;
[R,~] = radon(I,theta);
[~,J] = find(R>=max(max(R)));%J��¼����б��
qingxiejiao=90-J;
