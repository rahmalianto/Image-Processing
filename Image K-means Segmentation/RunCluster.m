function RunCluster()
   clc;
   % Number of clusters to simulate
   k = 3;
   % Number of samples per cluster
   m = 100;
   % Compute the samples
   s = RandStream.create('mt19937ar','Seed',100);
   moy = [10 10; 3 7; 5 1];
   stdev = [3 3; 3 3; 3 3];
   X = [];
   for i = 1:k
      x = repmat(moy(i,:),m,1) + repmat(stdev(i,:),m,1) .* randn(s,m,2);
      X = [X;x];
   end
   % Plot the samples
   h1 = findobj('Name','Result center');
   if isempty(h1)
      figure('Name','Result center')
   else
      figure(h1);
      clf;
   end
   hold on
   x1 = X(1:m,:);
   x2 = X(m+1:2*m,:);
   x3 = X(2*m+1:3*m,:);
   plot(x1(:,1),x1(:,2),'yo',...
   x2(:,1),x2(:,2),'b+',...
   x3(:,1),x3(:,2),'r^');
   plot(moy(:,1),moy(:,2),'kp',...
   'MarkerEdgeColor','k',...
   'MarkerFaceColor','k',...
   'MarkerSize',10)
   hold off
   % Randomize samples
   p = randperm(k*m);
   X = X(p,:);
   
   % Compute the k-means clustering
   data = cluster(k,X);
   
   % Normalize the result
   X = data(:, [1, 2]); y = data(:, 3);
   Xmean = mean(X);
   Xstd = std(X);
   X = (X-repmat(Xmean,3*m,1))./repmat(Xstd,3*m,1);
   
   h2 = findobj('Name','Result frontier');
   if isempty(h2)
      figure('Name','Result frontier')
   else
      figure(h2);
      clf;
   end
   x1 = X(find(y==1),:);
   x2 = X(find(y==2),:);
   x3 = X(find(y==3),:);
   plot(x1(:,1),x1(:,2),'yo',...
   x2(:,1),x2(:,2),'r^',...
   x3(:,1),x3(:,2),'b+');
   
   % Compute the boundaries by logistic regression
   for var = 1:k
      % Reassign y values
      yt = (y ~= var);
      % Add Polynomial Features
      Xt = polynomialCombinaisons(X(:,1), X(:,2));
      % Initialize fitting parameters
      initial_theta = zeros(size(Xt, 2), 1);
      % Set regularization parameter lambda to 1 (you should vary this)
      lambda = 0.001;
      % Set Options
      options = optimset('GradObj', 'on', 'MaxIter', 100);
      % Optimize
      [theta] = fmincg (@(t)(costFunctionReg(t, Xt, yt, lambda)), ...
      initial_theta, options);
      % Plot Boundary
      plotDecisionBoundary(theta, Xt, yt, findobj('Name','Result center'), Xmean, Xstd);
      plotDecisionBoundary(theta, Xt, yt, findobj('Name','Result frontier'), [0 0], [1 1]);
   end
end