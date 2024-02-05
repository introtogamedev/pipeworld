// -- lifetime --
/// create a new ring buffer
function ring_create(_length) {
	return {
		buf: array_create(_length),
		idx: 0,
	};
}

// -- commands --
/// add an item to the head of ring buffer
function ring_push(_ring, _item) {
	var _i = _ring_index(_ring, 1);
	_ring.idx = _i;
	array_set(_ring.buf, _i, _item);
}

/// pop the current head of the ring buffer
function ring_pop(_ring) {
	var _i = _ring_index(_ring, -1);
	_ring.idx = _i;
}

/// replace the current head of the ring buffer
function ring_replace(_ring, _item) {
	var _i = _ring_index(_ring, 0);
	array_set(_ring.buf, _i, _item);
}

// -- queries --
/// get the head of the ring buffer
function ring_head(_ring) {
	var _i = _ring_index(_ring, 0);
	return array_get(_ring.buf, _i);
}

/// get the flat index for the ring offset
function _ring_index(_ring, _offset) {
	var _n = array_length(_ring.buf);
	return ((_ring.idx + _offset) + _n) % _n;
}