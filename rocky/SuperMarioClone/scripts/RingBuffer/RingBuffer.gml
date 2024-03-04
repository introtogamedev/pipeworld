// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function ring_create(length){
	return {
		buf: array_create(length),
		len: length,
		idx: 0
	};
}
function ring_push(buf, item){
	if(buf.idx>=buf.len)
		buf.idx-=buf.len;
	array_set(buf.buf,buf.idx++,item);
}
function ring_pop(buf){
	if(buf.idx<=0)
		buf.idx=buf.len-1;
	return array_get(buf.buf,--buf.idx);
}
