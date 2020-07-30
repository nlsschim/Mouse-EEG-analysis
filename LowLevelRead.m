fileName = 'TRIAL3.mat';
fileNameOut = [fileName(1:end-4),'_copy.mat'];

fid = fopen('TRIAL3.mat');

fseek(fid,0,'eof');
fileSize = ftell(fid);
fseek(fid,0,'bof');

currPos = ftell(fid);

firstVar = 1;
while currPos<fileSize
    
    s1 = fread(fid,5,'long');
    M = floor(rem(s1(1)/10000,1)*10);
    O = floor(rem(s1(1)/1000,1)*10);
    P = floor(rem(s1(1)/100,1)*10);
    T = floor(rem(s1(1)/10,1)*10);
    
    s2 = fread(fid,s1(end),'char');
    s2 = char(s2(1:end-1)');
    disp(sprintf('reading ''%s''',s2));
    
    switch T
        case 0
            switch P
                case 0
                    d = fread(fid,s1(2)*s1(3),'double');
                case 1
                    d = fread(fid,s1(2)*s1(3),'float');
                case 2
                    d = fread(fid,s1(2)*s1(3),'int');
                case 3
                    d = fread(fid,s1(2)*s1(3),'short');
                case 4
                    d = fread(fid,s1(2)*s1(3),'ushort');
                case 5
                    d = fread(fid,s1(2)*s1(3),'char');
            end
            d = reshape(d,s1(2),s1(3));

        case 1
            d = fread(fid,s1(2)*s1(3),'double');
            d = reshape(char(d),s1(2),s1(3));
    end
    eval(sprintf('%s = d;',s2))
    currPos = ftell(fid);
    if firstVar == 1
        save(fileNameOut,s2);
        firstVar = 0;
    else
        save(fileNameOut,s2,'-append');
    end
end

clear d s1 s2 fileSize currPos M O P T
fclose(fid);

