--
-- Author: Your Name
-- Date: 2016-03-14 10:10:37
--
module("Data3",package.seeall)

function setLock(num)
	shLock=num
end
function getLock()
	return shLock
end


LOCK={}

LOCK[1]={}
LOCK[1][1]={lock=1}
LOCK[1][2]={lock=1}
LOCK[1][3]={lock=1}
LOCK[1][4]={lock=1}
LOCK[1][5]={lock=1}
LOCK[1][6]={lock=1}

LOCK[2]={}
LOCK[2][1]={lock=1}
LOCK[2][2]={lock=1}
LOCK[2][3]={lock=1}
LOCK[2][4]={lock=1}
LOCK[2][5]={lock=1}
LOCK[2][6]={lock=1}

LOCK[3]={}
LOCK[3][1]={lock=1}
LOCK[3][2]={lock=1}
LOCK[3][3]={lock=1}
LOCK[3][4]={lock=1}
LOCK[3][5]={lock=1}
LOCK[3][6]={lock=1}