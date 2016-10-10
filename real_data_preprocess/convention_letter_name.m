function convention_letter_name(a)
if a==1
	dir_path='~/CURRENT_fonts/Letters/4Q250'
end
if a==2
	dir_path='~/CURRENT_fonts/Letters/4Q324'
end
if a==3
	dir_path='~/CURRENT_fonts/Letters/se'
end
if a==4
	dir_path='~/CURRENT_fonts/Letters/Midrash Moshe'
end

global names
names={'alef','bet','gimel','dalet','he','vav','zain','khet','tet','yod','kaf','lamed','mem','nun','samekh','ayin','pe','tsade','qof','resh','shin','tav'
};

res_dir='results/results_scaled_preserve_ratio';
old_dir=cd([dir_path,'/',res_dir]);
files=dir('*.png');

prev_letter=-1;
prev_x='';
for file= files'
	name=file.name;
        C = strsplit(name,'.');
	letter=C{1};
	if ~size(strfind(letter,'('),1)==0
	%if ~isempty(strfind(name,'('))
		C=strsplit(letter,'(');
		letter=C{1};
	end
	letter
	OK = any(ismember(names,letter));
	if ~OK	
		if strcmp(letter,prev_letter)
			x=prev_x	
		else		
			x=0;
			x1=1;
			while x~=x1
				print_letters()
				x = input(['choose for  ',name,':']);
				disp(names{x})
				x1=input(['choose again  ',name,':']);
			end		
		end
		new_name=strrep(name, letter, names{x})
		movefile(name,new_name)
		prev_letter=letter
		prev_x=x
	end
end	
cd(old_dir)
	

function print_letters()
	for n = 1:length(names)
	    disp(strcat(names{n},' :',num2str(n)))
	end
end


end
%B=imread('alef.593-1.5.png');
%A=imread('alef.240-1.2.png');
%B_gray=rgb2gray(B);
%B_bin=im2bw(B_gray, graythresh(B_gray));
%A=im2bw(B_gray, graythresh(A));

%TODO call this on all data
%TODO now resize with preserve ratio







