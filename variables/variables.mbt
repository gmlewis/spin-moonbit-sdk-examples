// Generated by `wit-bindgen` 0.29.0.

///|
/// `handle` handles a `GET /variables/:key` request, gets the value
/// in Spin variables associated with `:key` and returns the value or `404 Not Found`.
pub fn handle(
  request : @types.IncomingRequest,
  response_out : @types.ResponseOutparam
) -> Unit {
  let response = (match @util.split_path(request) {
      (@types.Get, ["variables", key]) => handle_get(key)
      _ => return @util.respond_404(response_out)
    })
    |> Ok
  response_out.set(response)
}

///|
fn handle_get(key : String) -> @types.OutgoingResponse {
  match @variables.get(key) {
    Ok(value) => @util.make_response(@base64.str2bytes(value))
    _ => @util.make_404_response()
  }
}
