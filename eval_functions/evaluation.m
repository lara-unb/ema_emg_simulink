n_expected = 0;
bb = 1; BB = ceil(b*L);
x = zeros(size(all_IPIs));
y = zeros(size(all_IPIs));

for i = 1:length(all_IPIs)-1
    bb = bb + EMGstatus_(2,i);
    dt = all_IPIs(i) - (BB - bb);
    x(i) = dt;  % # found
end

for i = 1:length(all_IPIs)
    if (FES_ch1_(2,i) || FES_ch2_(2,i)) %stim
        a = find(isnan(emgData.rawCh1(:,i)));
        
        if isempty(a)
            n_expected = n_expected + 1; % # expected
        
            if all_IPIs(i) ~= BB - L
                y(n_expected) = x(i);
            end
        end
    end
end

ind_delete = y == 0;
y(ind_delete) = [];

% false positives do not match the freq L
diff_IPIs = diff(y); 
sigma = 0.1;
ind_keep = (diff_IPIs <= L*(1+sigma))&(diff_IPIs >= L*(1-sigma));
z = y;
z(~ind_keep) = [];

disp('Expected pulses:');
disp(n_expected);
disp('True positives:');
disp(length(z));
disp('False positives:');
disp(n_expected-length(z));
disp('Right artifacts:');
disp(100*(1-(n_expected-length(z))/n_expected));