--
-- Author: Your Name
-- Date: 2016-03-07 14:28:23
--
module("ShData",package.seeall)

shNumber=1
selectjlTD=1
selectszTD=1
selectbsTD=1
shLock=0
function setShNum(num)
	shNumber=num
end
function getShNum()
	return shNumber
end

function setjlTDnumber(num)
    selectjlTD=num
end
function getjlTDnumber()
    return selectjlTD
end

function setszTDnumber(num)
    selectszTD=num
end
function getszTDnumber()
    return selectszTD
end

function setbsTDnumber(num)
    selectbsTD=num
end
function getbsTDnumber()
    return selectbsTD
end


--写入沙盒
function writeToDoc(str)
	local docpath = cc.FileUtils:getInstance():getWritablePath().."data3.txt"
    local f = assert(io.open(docpath, 'w'))
    f:write(str)
    f:close()
end
--读取沙盒
function readToDoc()
	local docpath = cc.FileUtils:getInstance():getWritablePath().."data3.txt"
 	local str = cc.FileUtils:getInstance():getStringFromFile(docpath)
 	return str
end

