local temptbl = {}

local function MergeSort(tbl, iLow, iHigh, bReverse)
	if (iLow < iHigh) then
		local iMiddle = math.floor(iLow + (iHigh - iLow) / 2)
		MergeSort(tbl, iLow, iMiddle, bReverse)
		MergeSort(tbl, iMiddle + 1, iHigh, bReverse)
		
		for i = iLow, iHigh do
			temptbl[i] = tbl[i]
		end
		
		local i = iLow
		local j = iMiddle + 1
		local k = iLow
		
		while (i <= iMiddle and j <= iHigh) do
			if (temptbl[i] <= temptbl[j]) then
				if (bReverse) then
					tbl[k] = temptbl[j]
					j = j + 1
				else
					tbl[k] = temptbl[i]
					i = i + 1
				end
			else
				if (bReverse) then
					tbl[k] = temptbl[i]
					i = i + 1
				else
					tbl[k] = temptbl[j]
					j = j + 1
				end
			end
			
			k = k + 1
		end
		
		while (i <= iMiddle) do
			tbl[k] = temptbl[i]
			k = k + 1
			i = i + 1
		end
	end
end

local function MergeSortMember(tbl, iLow, iHigh, bReverse, sMember)
	if (iLow < iHigh) then
		local iMiddle = math.floor(iLow + (iHigh - iLow) / 2)
		MergeSortMember(tbl, iLow, iMiddle, bReverse, sMember)
		MergeSortMember(tbl, iMiddle + 1, iHigh, bReverse, sMember)
		
		for i = iLow, iHigh do
			temptbl[i] = tbl[i][sMember]
		end
		
		local i = iLow
		local j = iMiddle + 1
		local k = iLow
		
		while (i <= iMiddle and j <= iHigh) do
			if (temptbl[i] <= temptbl[j]) then
				tbl[k][sMember] = temptbl[i]
				i = i + 1
			else
				tbl[k][sMember] = temptbl[j]
				j = j + 1
			end
			
			k = k + 1
		end
		
		while (i <= iMiddle) do
			tbl[k][sMember] = temptbl[i]
			k = k + 1
			i = i + 1
		end
	end
end

function table.MergeSort(tbl, bReverse, sMember)
	if (sMember) then
		MergeSortMember(tbl, 1, #tbl, bReverse, sMember)
	else
		MergeSort(tbl, 1, #tbl, bReverse)
	end
	
	return tbl
end

function table.InheritNoBaseClass(tbl, tBase)
	for k, v in pairs(tBase) do
		if (tbl[k] == nil) then
			tbl[k] = v
		elseif (istable(tbl[k]) && istable(v)) then
			table.InheritNoBaseClass(tbl[k], v)
		end
	end
end

function table.DeepCopy(tbl)
	local tCopy = {}
	setmetatable(tCopy, debug.getmetatable(tbl))
	
	for k, v in pairs(tbl) do
		if (istable(v)) then
			tCopy[k] = table.DeepCopy(v)
		elseif (isvector(v)) then
			tCopy[k] = Vector(v)
		elseif (isangle(v)) then
			tCopy[k] = Angle(v)
		--[[elseif (ismatrix(v)) then
			tCopy[k] = Matrix(v)]]
		else
			tCopy[k] = v
		end
	end
	
	return tCopy
end
