% Generate synthetic dataset
rng(42); 
t = (1:100)';
dates = datetime(2018, 1, 1) + calmonths(t-1);
sales = randi([100, 500], [100, 1]) + (t * 2);

% Calculate 3-month moving average
ma3 = movmean(sales, 3);

% Visualization
figure('Color', 'w');
scatter(dates, sales, 40, [0, 0.466, 0.714], 'filled', 'MarkerFaceAlpha', 0.6); hold on;
plot(dates, ma3, 'Color', [0.84, 0.157, 0.157], 'LineWidth', 2.5);

% Aesthetic styling
title('{\bf Monthly Sales Analysis}', 'FontSize', 16, 'Color', [0.2 0.2 0.2]);
xlabel('Date', 'FontSize', 12);
ylabel('Sales Volume', 'FontSize', 12);
grid off;
ax = gca;
ax.Box = 'off';
ax.TickDir = 'out';
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

legend('Monthly Sales', '3-Month Moving Average', 'Location', 'best', 'EdgeColor', 'none', 'Color', 'none');
hold off;
