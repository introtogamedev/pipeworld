// -- lifetime --
/// create a new ring buffer
/// - arguments:
///   * length: the maximum number of items in the buffer
/// - returns: a new ring buffer of the length
function ring_create(_length) {
	return {
		buf: array_create(_length),
		idx: 0,
	};
}

// -- commands --
/// add an item to the head of ring buffer
/// - arguments:
///   * ring: a ring buffer made with `ring_create`
///   * item: a new item to add to the buffer
function ring_push(_ring, _item) {
	var _i = _ring_index(_ring, 1);
	_ring.idx = _i;
	array_set(_ring.buf, _i, _item);
}

/// pop the current head of the ring buffer, removing it.
/// - arguments:
///   * ring: a ring buffer made with `ring_create`
function ring_pop(_ring) {
	var _i = _ring_index(_ring, -1);
	_ring.idx = _i;
}

/// replace the current head of the ring buffer
/// - arguments:
///   * ring: a ring buffer made with `ring_create`
///   * item: an item to replace the current head item with
function ring_replace(_ring, _item) {
	var _i = _ring_index(_ring, 0);
	array_set(_ring.buf, _i, _item);
}

// -- queries --
/// get the head of the ring buffer
/// - arguments:
///   * ring: a ring buffer made with `ring_create`
/// - returns: the current head item in the buffer
function ring_head(_ring) {
	var _i = _ring_index(_ring, 0);
	return array_get(_ring.buf, _i);
}

/// get the flat index for the ring offset
function _ring_index(_ring, _offset) {
	var _n = array_length(_ring.buf);
	return ((_ring.idx + _offset) + _n) % _n;
}