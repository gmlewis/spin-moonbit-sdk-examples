///|
pub fn cabi_realloc(
  src_offset : Int32,
  src_size : Int32,
  _dst_alignment : Int32,
  dst_size : Int32,
) -> Int32 {
  @gen.cabi_realloc(src_offset, src_size, _dst_alignment, dst_size)
}

///|
pub fn wasmExportHandle(p0 : Int32, p1 : Int32) -> Unit {
  handle(
    @types.IncomingRequest::IncomingRequest(p0),
    @types.ResponseOutparam::ResponseOutparam(p1),
  )
}
