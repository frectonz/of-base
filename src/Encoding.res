type t = Binary | Decimal | Octal | Hex

let options = [Binary, Decimal, Octal, Hex]

let to_string = t =>
  switch t {
  | Binary => "Binary"
  | Decimal => "Decimal"
  | Octal => "Octal"
  | Hex => "Hex"
  }

let from_string = t =>
  switch t {
  | "Binary" => Binary
  | "Decimal" => Decimal
  | "Octal" => Octal
  | "Hex" => Hex
  | _ => failwith("unknown encoding")
  }

let to_strings = ts => ts->Array.map(to_string)

let to_symbol = t =>
  switch t {
  | Binary => "2"
  | Decimal => "10"
  | Octal => "8"
  | Hex => "16"
  }
