%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai

% read the targeted image
IM_Edge = imread('C:\Users\user\OneDrive\바탕 화면\2019 특별, 4학년\4학년 2학기\로봇비전\Homeworks\hw7\Edge.png');
[H,theta,rho] = hough(IM_Edge);
figure, imshow(H, [], 'XData',theta, 'YData',rho,'InitialMagnification','fit')
axis on, axis normal
xlabel('\theta'), ylabel('\rho')

[r, c] = houghpeaks(H, 10);
hold on
plot(theta(c), rho(r), 'linestyle', 'none', 'marker', 's', 'color', 'w')

lines = houghlines(IM_Edge, theta, rho, r, c);
figure, imshow(IM_Edge), hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,2), xy(:,1), 'lineWidth', 4, 'Color', [.6 .6 .6]);
end

r1 = [];
c1 = [];

for i = 1:length(c)
    if theta(c(i)) <= 10 && theta(c(i)) >= -10
        r1(end+1) = r(i);
        c1(end+1) = c(i);
    end
end

figure, imshow(H, [], 'XData',theta, 'YData',rho,'InitialMagnification','fit')
axis on, axis normal
xlabel('\theta'), ylabel('\rho')

hold on
plot(theta(c1), rho(r1), 'linestyle', 'none', 'marker', 's', 'color', 'w')

lines1 = houghlines(IM_Edge, theta, rho, r1, c1);
figure, imshow(IM_Edge), hold on
for j = 1:length(lines1)
    xy1 = [lines1(j).point1; lines1(j).point2];
    plot(xy1(:,2), xy1(:,1), 'lineWidth', 4, 'Color', [.6 .6 .6]);
end