function to_grayscale(a)
if a==1
	dir_path='~/CURRENT_fonts/Letters/4Q250'
	color=true
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
old_dir=cd(dir_path)
files=dir('*.png');
res_dir='results'
mkdir(res_dir)
for file= files'
	
	im=imread(file.name);
	[rows, columns, numberOfColorChannels] = size(im);
	if numberOfColorChannels > 1 
		im=rgb2gray(im);
	end
	%im_bin=im2bw(im, graythresh(im));
	im_bin=im;
	imwrite(im_bin,[res_dir,'/',file.name]);	
end
cd(old_dir)
	






%B=imread('alef.593-1.5.png');
%A=imread('alef.240-1.2.png');
%B_gray=rgb2gray(B);
%B_bin=im2bw(B_gray, graythresh(B_gray));
%A=im2bw(B_gray, graythresh(A));

%TODO call this on all data
%TODO now resize with preserve ratio







