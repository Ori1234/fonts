function scale1_real_images(a)%preserve image aspect ratio (Add padding)
	input_dir='~/CURRENT_fonts/Letters'
	if a==1
		input_dir=[input_dir,'/4Q250/results',]
	end
	if a==2
		input_dir=[input_dir,'/4Q324/results']
	end
	if a==3
		input_dir=[input_dir,'/se/results']
	end
	if a==4
		input_dir=[input_dir,'/Midrash Moshe/results']		
	end


	res_directory='results_scaled_preserve_ratio';
	old_dir=cd(input_dir)
	
	mkdir(res_directory)
	files = dir('*.png');
	i=1;
	sizes=zeros(2,length(files));
	for file = files'
		img=imread(file.name,'png');
		im_size=size(img);
		if im_size(1)>im_size(2)
			scale_size=[64 NaN];
		else
			scale_size=[NaN 64];
		end

		i=i+1;


		img = imresize(img,scale_size);

		sizes(:,i)=size(img);
		imwrite(img,[res_directory,'/',file.name]) %MEYUTAR? TODO
	end
	sizes

	max_sizes=max(sizes,[],2)
	p=max_sizes(1)
	q=max_sizes(2)
	if ~exist(res_directory)
		mkdir(res_directory)
	end
	cd(res_directory)
	for file=files'
		K=imread(file.name,'png');
		[m n] = size(K);
%		if n>32
%			K_pad=K(:,[ceil((n-q)/2)+1:n-floor((n-q)/2)])
%		else
		K_pad = padarray(K, [floor((p-m)/2) floor((q-n)/2)], 'replicate','post');
		K_pad = padarray(K_pad, [ceil((p-m)/2) ceil((q-n)/2)],'replicate','pre');
%		end
		imwrite(K_pad,file.name)
		im_size=size(K_pad)
		file.name
	end

	cd(old_dir)

end
