 --
-- Author: Your Name
-- Date: 2016-03-07 16:03:21
--
module("Data2",package.seeall)

function getSpData(num)
    local spData=SPDATA[num]
    return spData
end

function getSZData(num)
    local SZData=SZDATA[num]
    return SZData
end

function getBSData(num)
    local BSData=BSDATA[num]
    return BSData
end


SCENE2={}
SCENE2[1]={number=999,money=1000}
SCENE2[2]={number=999,money=1000}
SCENE2[3]={number=999,money=1000}

SPDATA={}
SPDATA[1]={pic="gjs.png",pic2="gjs.png"}
SPDATA[2]={pic="moonTD.png",pic2="moonTD.png"}
SPDATA[3]={pic="bigTree.png",pic2="bigTree.png"}
SPDATA[4]={pic="fzTree.png",pic2="fzTree.png"}
SPDATA[5]={pic="Oldtree.png",pic2="Oldtree.png"}
SPDATA[6]={pic="yilidanTD.png",pic2="yilidanTD.png"}

SZDATA={}
SZDATA[1]={pic="szTD.png",pic2="szTD.png"}
SZDATA[2]={pic="sl.png",pic2="sl.png"}
SZDATA[3]={pic="tsc.png",pic2="tsc.png"}
SZDATA[4]={pic="fl.png",pic2="fl.png"}
SZDATA[5]={pic="niu.png",pic2="niu.png"}
SZDATA[6]={pic="yy.png",pic2="yy.png"}

BSDATA={}
BSDATA[1] = {pic="tlt.png",pic2="tlt.png"}
BSDATA[2] = {pic="maigudiTD.png",pic2="maigudiTD.png"}
BSDATA[3] = {pic="bigTD.png",pic2="bigTD.png"}
BSDATA[4] = {pic="tzc.png",pic2="tzc.png"}
BSDATA[5] = {pic="bsTD.png",pic2="bsTD.png"}
BSDATA[6] = {pic="wyw.png",pic2="wyw.png"}
