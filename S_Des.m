% Simplified DES (S_DES) Calculator
% With Encryption & Decryption
% Author: Kenneth Johnson

answer = questdlg('Would you like to Encrypt or Decrypt?', 'S-DES', 'Encryption','Decryption', 'Cancel'); % Create option dialog box
S_0 = [1 0 3 2 ; 3 2 1 0 ; 0 2 1 3 ; 3 1 3 2]; % S0 4x4 matrix
S_1 = [0 1 2 3 ; 2 0 1 3 ; 3 0 1 0 ; 2 1 0 3]; % S1 4x4 matrix
IP = [2 6 3 1 4 8 5 7]; % Initial permutation
IP_1 = [4 1 3 5 7 2 8 6]; % Final permutation
EP = [4 1 2 3 2 3 4 1]; % Expansion permutation
P4 = [2 4 3 1]; % Permutation

switch answer % Switch statement

    case 'Encryption' % Case 1       
        prompt = {'Enter 8-bit plaintext:','Enter 10-bit binary key:'}; % Request user input
        dlgtitle = 'S-DES Encryption Input'; % Dialog title
        dims = [1 50]; % Sets dimensions
        definput = {'10011011','1001000101'}; % Define user input 
        answer = inputdlg(prompt,dlgtitle,dims,definput); % specify default value of each field
                
        P = num2str(answer{1})-'0'; % convert plaintext string to array and set to P
        K = num2str(answer{2})-'0'; % convert ciphertext string to array and set to K
             
        [K1,K2]=generatekey(K); % Function to generate keys
        
        PIP = permutation(P,IP,8); % After applying initial permutation of IP
        
        % *********************** ROUND 1 OF S-DES *******************************************
        LS1_1 = PIP(1:4); % Round 1 Left side after split
        LS2_1 = PIP(5:8); % Round 1 Right side after split
        
        EPR = permutation(LS2_1,EP,8); % Applying permutation EP Round 1
        % disp(EPR); % Display after applying EP Round 1
        
        EPRK1 = xoroperation(EPR,K1, 8); % Applying XOR with K1 for encryption
        LS1_2 = EPRK1(1:4); % Left side after split XOR with Round Key 
        LS2_2 = EPRK1(5:8); % Right side split after XOR with Round Key
        
        result_1 = strcat(num2str(LS1_2(1, 1)),num2str(LS1_2(1, 4))); % Find matrices elements
        row = str2num(result_1); % Row 1st and 4th bit
        % disp(row); % displats the binary Number for row
        row = bin2dec(result_1); % Converts binary to decimal
        
        result_2 = strcat(num2str(LS1_2(1, 2)),num2str(LS1_2(1, 3))); % Find matrices elements
        column = str2num(result_2); % Column 2nd and 3rd bit
        % disp(column) % Displays the binary number for column
        column = bin2dec(result_2); % Converts binary to decimal
        
        
        L22 = S_0(row+1,column+1); % Set matrix elements
        % L22 = dec2bin(L22); delete#
        L22 = decimaltobinary(L22); % Convert Decimal to binary
        disp(L22); % Displays L22
        
        result_3 = strcat(num2str(LS2_2(1, 1)),num2str(LS2_2(1, 4))); % Find matrices elements
        row = str2num(result_3); % Row 1st and 4th bit
        % disp(row); % displats the binary Number for row
        row = bin2dec(result_3); % Converts binary to decimal
        
        
        result_4 = strcat(num2str(LS2_2(1, 2)),num2str(LS2_2(1, 3))); % Find matrices elements
        column = str2num(result_4); % Column 2nd and 3rd bit
        % disp(column); % Displays the binary number for column
        column = bin2dec(result_4); % Converts binary to decimal
        
        
        R22 = S_1(row+1,column+1); % Set matrix elements
        R22 = decimaltobinary(R22); % Convert decimal to binary
        disp(R22); % Display R22
        
        L22_R22 = [L22,R22]; % Create an array with L22 and R22
        % L22_2 = num2str(L22_2)-'0'; % Converts string into array
        % disp(L22_R22); % Displays array
        R3 = permutation(L22_R22, P4, 4); % solves using permutation of P4
        % disp(R3); % Displays after applying P4
        
        L3 = xoroperation(R3,LS1_1, 4); % XOR operation for R3 an LS1_1
        L5 = LS2_1; % Switch L5 with LS2_1
        R5 = L3; % Switch R5 with R3
        
        % ****************** ROUND 2 OF S-DES *************************************
        EPR2 = permutation(R5,EP,8); % Applying permutation of EP
        EPR2_2 = xoroperation(EPR2,K2,8); % XOR operation
        L6 = EPR2_2(1:4); % Left side after split
        R6 = EPR2_2(5:8); % Right side after split
        
        result_5 = strcat(num2str(L6(1, 1)),num2str(L6(1, 4))); % Find matrices elements
        row = str2num(result_5); % Row 1st and 4th bit
        % disp(row) % displats the binary Number for row
        row = bin2dec(result_5); % Converts binary to decimal
        
        result_6 = strcat(num2str(L6(1, 2)),num2str(L6(1, 3))); % Find matrices elements
        column = str2num(result_6); % Column 2nd and 3rd bit
        disp(column) % Displays the binary number for column
        column = bin2dec(result_6); % Converts binary to decimal
        
        L62 = S_0(row+1,column+1); % Set matricx elements
        L62 = decimaltobinary(L62); % Convert decimal to binary
        disp(L62); % Display L62
        
        result_7 = strcat(num2str(R6(1, 1)),num2str(R6(1, 4))); % Find matrices elements
        row = str2num(result_7); % Row 1st and 4th bit
        % disp(row); % displats the binary Number for row
        row = bin2dec(result_7); % Converts binary to decimal
        
        result_8 = strcat(num2str(R6(1, 2)),num2str(R6(1, 3)));
        column = str2num(result_8); % Column 2nd and 3rd bit
        % disp(column); % Displays the binary number for column
        column = bin2dec(result_8); % Converts binary to decimal
                
        R62 = S_1(row+1,column+1); % Set matrix elements
        R62 = decimaltobinary(R62); % Convert decimal to binary
        disp(R62); % Display R62
        
        R7 = [L62,R62]; % Create an array of L62 and R62
        R7 = permutation(R7,P4,4); % Applying permutation of P4
                
        L7 = xoroperation(R7,L5, 4); % XOR operation
        L7_2 = [L7,R5]; % Create array of L7 and R5
        C8 = permutation(L7_2,IP_1,8); % Applying permutaion of IP
        disp(C8); % Display C8
        h = msgbox(["The 8-bit ciphertext is:";num2str(C8)], "S-DES", "replace"); % Display message box with ciphertext
        set(h, 'position', [500 400 200 60]); % Set the position of the message box

    case 'Decryption'
        prompt = {'Enter 8-bit ciphertext:', 'Enter 10-bit binary key:'}; % Prompt user to input ciphertext and 10-bit binary key
        dlgtitle = 'S-DES Decryption Input'; % Dialog box title 
        dims = [1 55]; % Returns data as character array
        definput = {'01000101','1001000101'}; % Define user inputs
        answer = inputdlg(prompt,dlgtitle,dims,definput); % specify default value of each field
                       
        C8 = num2str(answer{1})-'0';  
        K = num2str(answer{2})-'0';

        [K1,K2]=generatekey(K); % Key generation function

        % *************** S-DES DECRYPTION **********************
        C9 = permutation(C8,IP,8); % Applying permutation of IP
        L9 = C9(1:4); % Left side after split
        R9 = C9(5:8); % Right side after split
        
        EPR3 = permutation(R9,EP,8); % Applying permutation of EP
        LA_RA = xoroperation(EPR3,K2,8); % XOR operation 
        LA = LA_RA(1:4); % Left side after split
        RA = LA_RA(5:8); % Right side after split
        
        result_9 = strcat(num2str(LA(1, 1)),num2str(LA(1, 4))); % Find matrices elements
        row = str2num(result_9); % Row 1st and 4th bit
        % disp(row) % displats the binary Number for row
        row = bin2dec(result_9); % Converts binary to decimal
        
        result_10 = strcat(num2str(LA(1, 2)),num2str(LA(1, 3))); % Find matrices elements
        column = str2num(result_10); % Column 2nd and 3rd bit
        % disp(column) % Displays the binary number for column
        column = bin2dec(result_10); % Converts binary to decimal
        
        LA2 = S_0(row+1,column+1); % set matrix elements
        
        LA2 = decimaltobinary(LA2); % Convert decimal to binary
        disp(LA2); % Display LA2
        
        
        result_11 = strcat(num2str(RA(1, 1)),num2str(RA(1, 4))); % Find matrices elements
        row = str2num(result_11); % Row 1st and 4th bit
        % disp(row) % displats the binary Number for row
        row = bin2dec(result_11); % Converts binary to decimal
        
        result_12 = strcat(num2str(RA(1, 2)),num2str(RA(1, 3))); % Find matrices elements
        column = str2num(result_12); % Column 2nd and 3rd bit
        % disp(column) % Displays the binary number for column
        column = bin2dec(result_12); % Converts binary to decimal
        
        RA2 = S_1(row+1,column+1); % Set matrix elements in specified variable
        RA2 = decimaltobinary(RA2); % Convert decimal to binary
        disp(RA2); % Display RA2
        
        LA2_RA2 = [LA2,RA2]; % Create an array of LA2 and RA2
        disp(LA2_RA2) % Displays array
        
        RB = permutation(LA2_RA2,P4,4); % Applying permutation of P4 
        LB = xoroperation(RB,L9,4); % XOR operation
        LC = R9; % Switch LC and R9
        RC = LB; % Switch RC and LB
        LC_RC = [LC,RC]; % Display an array of LC and RC 

       % Start Round 2 Decryption
        EPR4 = permutation(RC,EP,8); % Expansion permutation Round 2
        LD_RD = xoroperation(EPR4,K1,8); % Applying XOR with K1 decryption key
        LD = LD_RD(1:4); % Left side after split
        RD = LD_RD(5:8); % Right side after split 
        
        result_13 = strcat(num2str(LD(1, 1)),num2str(LD(1, 4))); % Find matrices elements
        row = str2num(result_13); % Row 1st and 4th bit
        % disp(row) % displats the binary Number for row
        row = bin2dec(result_13); % Converts binary to decimal
        
        
        result_14 = strcat(num2str(LD(1, 2)),num2str(LD(1, 3))); % Find matrices elements
        column = str2num(result_14); % Column 2nd and 3rd bit
        % disp(column) % Displays the binary number for column
        column = bin2dec(result_14); % Converts binary to decimal
        
        
        LE2 = S_0(row+1,column+1); % Set matrix elements in specified variable
        LE2 = decimaltobinary(LE2);
        disp(LE2); % Display LE2 
        
        result_15 = strcat(num2str(RD(1, 1)),num2str(RD(1, 4))); % Find matrices elements
        row = str2num(result_15); % Row 1st and 4th bit
        % disp(row) % displats the binary Number for row
        row = bin2dec(result_15); % Converts binary to decimal
        
        result_16 = strcat(num2str(RD(1, 2)),num2str(RD(1, 3))); % Find matrices elements
        column = str2num(result_16); % Column 2nd and 3rd bit
        % disp(column) % Displays the binary number for column
        column = bin2dec(result_16); % Converts binary to decimal
        
        RE2 = S_1(row+1,column+1);% Set matrices elements in specified variable
        RE2 = decimaltobinary(RE2); % Convert decimal to binary
        disp(RE2); % Display RE2
        
        LE2_RE2 = [LE2,RE2]; % Create an arrray of LE2 and RE2
        disp(LE2_RE2) % Displays array
        
        RF = permutation(LE2_RE2,P4,4); % Applying permutation of P4
        LF = xoroperation(LC,RF,4); % XOR operation
        
        LF_RC = [LF,RC]; % Display an array of LF and RC
        P8 = permutation(LF_RC,IP_1,8); % Converts back to plaintext
        disp(P8); % Display P8 plaintext
        h = msgbox(["The 8-bit plaintext is:";num2str(P8)], "S-DES", "modal"); % Display message box with plaintext solution
        set(h, 'position', [500 400 200 60]); % Set the position of the message box

end


function [K1,K2]=generatekey(K)
    P10 = [3,5,2,7,4,10,1,9,8,6]; % Permutation
    P8=[6,3,7,4,8,5,10,9]; % Permutation
    KP10= permutation(K, P10,10); % Apply permutation of P10
%   disp(KP10); %displays after applying P10
    LS1=KP10(1:5); % Left side after split
    LS2=KP10(6:10); % Right side after split
    LS11=circularleftshit(LS1,5,1); % Left side (after left shift of 1)
%   disp(LS11); % display left shift
    LS21=circularleftshit(LS2,5,1); % Right side (after left shift 1)
%   disp(LS21);
    LS=[LS11,LS21]; % Combination of left and right side?
    K1=permutation(LS,P8,8); % Solve by permutation P8 (First subkey)
%   disp(K1) % Display after applying permutation of P8

    LS12=circularleftshit(LS11,5,2);% Left side (after Left shift of 2)
%   disp(LS12);
    LS22=circularleftshit(LS21,5,2);% Right side (after left shitfs of 2)
%   disp(LS22);
    LS=[LS12,LS22]; % Combination of left and right side?
    K2= permutation(LS,P8,8); % Solve by permutation P8 (Second Key)
%   disp(K2);

end

function output = decimaltobinary(number) % Decimal to binary function
    output=[0,0];
    if(number == 0) % if number is equal to 0
        output =[0,0]; % output is equal to 0 0
    elseif (number == 1) % else if number is equal to 1
        output = [0,1]; % output is equal to 0 1
    elseif (number == 2) % else if number is equal to 2
        output = [1,0]; % output is equal to 1 0
    elseif (number == 3) % else if number is equal to 3
        output = [1,1]; % output is equal to 1 1
            
    end % end if statement
end % end function
    
function [row, column] = findrowcolumn(R) % find row and column function
    row=R(1)*2+R(4)*1 +1; % Row compute
    column = R(2)*2+R(3)*1+1; % Column compute
end % end function

function output = xoroperation(K1,K2, n) % XOR operation function
    output =K1; % Output equals K1
    for i=1:n % For loop for iterations 1 to n
        output(i) = xor(K1(i), K2(i)); % Output equals xor compute
    end % End for loop
end % End function

function output = permutation(K,P,n) % Permutation function
    output =P; % Output equals p
    for i=1:n % For loop for iterations 1 to n
        output(i) = K(P(i)); % Output equals
    end % End for loop
end % End function

function output = circularleftshit(K,n,s) % Circular left shift function
    output =K; % Output is equal to k
    index=1; % Index equals 1
    for i=1:n % For loop for iterations 1 to n
        if(i<=n-s) % If statemetn if iteration is less than or equal to n-s
            output(i) = K(i+s); % Output is equal to K(i+s)
        else % else condition
           output(i) = K(index); % output equals K(index)
           index = index + 1; % index equals index+1
        end % End if statement
    end % End for statement
end % End function


