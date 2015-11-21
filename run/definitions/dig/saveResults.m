if ~isstr(results)
    error('Please specify the name of the variable where you want the results to be saved');
end

eval([results '= struct([]);']);

%Create and save help variables for report
blag  =[bo b(1:1001)']'; 
dclag = [dco dc(1:1001)']';
dlag = [ do d(1:1001)']';
rextlag = [rstar+nu rext(1:1001)']'; 
rextglag = [rstar+nug rextg(1:1001)']'; 
rlag =[ro r(1:1001)']';
bstarlag  =[bstaro bstar(1:1001)']'; 

% cad = d-dlag+dc-dclag+bstar-bstarlag-(r_d-g).*dlag./(1+g)-(rextglag-g).*dclag./(1+g)-(rextlag-g).*bstarlag./(1+g)- eta/2.*(bstar-bstaro).^2;
cad = d + dc + bstar - (dlag + dclag + bstarlag)./(1+g);
pfd = p.*(b-blag)+d-dlag+dc-dclag-(r_d-g).*dlag./(1+g)-(rextglag-g).*dclag./(1+g)-(rlag-g).*p.*blag/(1+g);
publicriskpremium = rextg - rstar;

y = qx+qn;
k = kx+kn;
wr = w./p;

eval([results '(1).cad = 100*cad./ynom;']);

%Save all parameters and endogenous variables in the model
for i=1:length(M_.endo_names)
    eval([results '.' M_.endo_names(i,:) '=' mat2str(oo_.endo_simul(i,:)') ';'])
end

for i=1:length(M_.param_names)
    eval([results '.' M_.param_names(i,:) '=' num2str(M_.params(i,:)) ';']);
end

%Add also exogenous path for variables not beginning by "shock" (otherwise
%not saved, such as price of imported machinery).
for i=1:length(M_.exo_names)
    if ~strncmp('shock',M_.exo_names(i,:),5)
    eval([results '.' M_.exo_names(i,:) '=' mat2str(oo_.exo_simul(:,i)') ';'])
end
end



eval([results '.pfd = pfd;']);
eval([results '.c = (e+eh)./p;']);
eval([results '.co = (e_ini+eh_ini)./P_ini;']);
eval([results '.ixo = i_x_ini;']);
eval([results '.ino = i_n_ini;']);
eval([results '.kxo = k_x_ini;']);
eval([results '.kno = k_n_ini;']);
eval([results '.grantso = grantso;']);
eval([results '.ixno =' results '.ixo+' results '.ino;']);
eval([results '.ixn = ix + in;']);
eval([results '.y  = y;']);
eval([results '.qxo = q_x_ini;']);
eval([results '.qno = q_n_ini;']);
eval([results '.wr = w./p;']);
eval([results '.dc = 100*dc./ynom;']);
eval([results '.ddc = 100*(d+dc)./ynom;']);
eval([results '.b = 100.*p.*b./ynom;']);
eval([results '.totaldebt =' results '.b+' results '.ddc;']);

eval(['save ' results '.mat ' results ';']);

eval([results '= 0;']);