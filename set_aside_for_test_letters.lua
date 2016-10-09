math.randomseed(os.time())
train_dir=arg[1]
test_dir=arg[2]

exclude_precent=0.8
exclude_letters={}
for i=1488,1514 do
	if math.random(1,10000)>10000*exclude_precent then
                table.insert(exclude_letters,i)
		print('excluded letter '..i)
        end
end
print('\n')
print(exclude_letters)

local total_num_of_letters=1514-1488+1
print('excluded '..#exclude_letters/total_num_of_letters)




--local total_count=1
--l=1488
--fonts={}
--for f in io.popen("ls  "..train_dir..l.."*"):lines() do
--	total_count=total_count+1
--	f1=string.match(f, ".-([^/]-[^%.]+)$")
--	f1=string.sub(f1,5)
--	print(f1)
--	table.insert(fonts,f1)
--end

for key,l in pairs(exclude_letters) do
	io.popen("mv "..train_dir..l.."_*.png".." "..test_dir)
	print('moving '..l)
end


