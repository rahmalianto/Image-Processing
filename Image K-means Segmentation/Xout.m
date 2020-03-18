function Xout = cluster(k, X)
   % This method is called k-means. Given the hypothesis that there are k
   % different clusters to be found, the algorithm itertively search for the
   % best centroid of each clusters.
   %
   % Various improvement can be performed : k-means++ and fast distance
   % calculation
 
   MAXITER = 200;
   m = length(X);
   % Choose a random k-plet points
   s = RandStream.create('mt19937ar','Seed',100);
   index = randi(s,m,k,1);
   center = X(index,:);
   Xout = zeros(m,3);
   
   for i=1:MAXITER
      tabIndex = zeros(m/k,k); %tableau contenant l'indice des points X les plus proches de chaque k centre
      iterTab = ones(k,1); %tableau pour savoir combien on a de point plus proche par centre
      for j=1:m
         %compute the distance from each centroid
         temp = center-repmat(X(j,:),k,1);
         dist = sqrt(diag(temp*temp'));
         %keep min distance
         [c,idx] = min(dist);
         tabIndex(iterTab(idx),idx) = j;
         iterTab(idx) = iterTab(idx) + 1;
      end
      for j = 1:k
         [a,b,idx] = find(tabIndex(:,j));
         Xtemp = X(idx,:);
         %temporary new centroid
         centerTemp = mean(Xtemp);
         %nearest data point
         temp = repmat(centerTemp,length(Xtemp),1)-Xtemp;
         dist = sqrt(diag(temp*temp'));
         [c,idx] = min(dist);
         center(j,:) = Xtemp(idx,:);
      end
   end
   % Last iteration center evaluation : not a sample
   tempLength = 0;
   for j = 1:k
      [a,b,idx] = find(tabIndex(:,j));
      Xtemp = X(idx,:);
      previousLength = tempLength + 1;
      tempLength = tempLength + length(idx);
      Xout(previousLength:tempLength,:) = [Xtemp, j * ones(length(idx),1)];
      %baricentre des points
      center(j,:) = mean(Xtemp);
   end
   % Plot the computed center
   h=findobj('Name','Result center');
   if isempty(h)
      error('Can''t find figure object');
    else
      figure(h);
   end
   hold on
   plot(center(:,1),center(:,2),'kp',...
   'MarkerEdgeColor','k',...
   'MarkerFaceColor','g',...
   'MarkerSize',15)
end