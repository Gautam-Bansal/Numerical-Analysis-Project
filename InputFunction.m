% Gautam Bansal - 2020MCB1235

%clearing memory and command line
clc;
clearvars;
clear all;

n=input("Number of equations = "); %number of equations/variables
tol=input("Input tolerence: "); % tolerance 
x=input("Enter initial approximation as row matrix = "); % initial approximation, avoid 'zeros' 
                                                         % as inital approximation to avoid 
                                                         % division by zero at some point
itrMax=input("Enter maximum number of iterations = "); %maximum number of iterations to prevent looping

A=sym("x",[1,n]); %create symbol x1,x2,.....xn as row matrix


%equation store
E=cell(n,1); % stores functions only 
F=cell(n,1); % stores functions as well as the variables

% define variables
disp("Variables are : ");
S="x1";
for i=2:n
    v=num2str(i); %converts number to character array
    y=strcat("x",v); %Horizontally adding 2 strings
    S=strcat(S, ",",y); % For printing [x1,x2,x3,x4,...xn]
end
disp(S);

% Assign values to E and F 
for i=1:n
    s=input("Enter the equations = ","s" );  %returns the entered text,
                                            % without evaluating the input as an expression
    E{i,1}=str2sym(s); %Evaluate string representing symbolic expression.
    str=sprintf("@(%s)(%s)",S,s); % Write formatted data to string or character vector
    f=str2func(str);
    F{i}=f;
end

count_itr=0; %variable to store number of iterations
error = 1; %initializing variable that will store error

fprintf('\n # of iterations\t');

for i = 1:n
    fprintf('x%d\t', i);
end

while(abs(error) > tol && count_itr < itrMax) %main function
    count_itr = count_itr + 1; 
    xold = x; % storing the old X, will be used in calculation relative error

    for i = 1:n % substituting X in F to find X'
        x(1,i) = subs(E{i,1}, A, xold); % X' = F(X)
    end

    error = norm(x - xold)/norm(x); %error = || X' - X || / || X' ||

    fprintf('\n\t%d\t\t', count_itr);

    for i = 1:n
       fprintf('%f\t', x(1,i));
    end
end

if (count_itr >= itrMax) %does not converge in maximum iteration limit
    disp(' ')
    disp(['Failed to converge in ',num2str(itrMax),' iterations!'])
    disp(' ')
    disp('--------------------------------------------')
    disp(' ')
    answer = NaN;
else %converges within the given tolerance
    disp(' ')
    disp(['Solution has been found in ',num2str(count_itr),' iterations.'])
    for i = 1:n
        fprintf('\tx%d\t\t',i);
    end
    
    fprintf('\n');
    for i = 1:n
        fprintf('\t%f',x(i));
    end

    disp(' ')
    disp('--------------------------------------------')
    disp(' ')
    answer = x;
end