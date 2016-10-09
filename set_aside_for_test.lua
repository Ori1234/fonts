train_dir=arg[1]
test_dir=arg[2]

local total_count=1
l=1488
fonts={}
for f in io.popen("ls  "..train_dir..l.."*"):lines() do
	total_count=total_count+1
	f1=string.match(f, ".-([^/]-[^%.]+)$")
	f1=string.sub(f1,5)
	print(f1)
	table.insert(fonts,f1)
end

local count=0
exclude_precent=0.2
for s,f in pairs(fonts) do
	if math.random(100)<100*exclude_precent then
		count=count+1
		f1=string.gsub(f," ","\\ ")
		io.popen("mv "..train_dir.."*"..f1.." "..test_dir)
		print('moving '..f1)
	end

end

print(count/total_count)
