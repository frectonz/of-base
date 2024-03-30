module type Base = {
  type t

  let from_string: string => option<t>
  let to_string: t => string

  let from_decimal: int => t
  let to_decimal: t => int

  let encoding: Encoding.t
}

module Decimal = {
  type t = int

  let from_string = n => Int.fromString(n)
  let to_string = n => Int.toString(n)

  let from_decimal = n => n
  let to_decimal = n => n

  let encoding = Encoding.Decimal
}

let from_encoding: Encoding.t => module(Base) = t =>
  switch t {
  | Encoding.Decimal => module(Decimal)
  | Encoding.Binary => failwith("no binary")
  | Encoding.Octal => failwith("no octal")
  | Encoding.Hex => failwith("no hex")
  }

module MakeInput = (B: Base) => {
  @react.component
  let make = (~value: option<B.t>, ~on_change: option<B.t> => unit) => {
    let onChange = e => B.from_string((e->ReactEvent.Form.target)["value"])->on_change
    let value = value->Option.map(B.to_string)->Option.getOr("")

    <div className="flex w-full">
      <input className="px-4 py-2 border border-black flex-1" value onChange />
      <span className="bg-black text-white px-2 h-full flex justify-center items-center text-xs">
        {B.encoding->Encoding.to_symbol->React.string}
      </span>
    </div>
  }
}

module MakeOutput = (B: Base) => {
  @react.component
  let make = (~value: option<int>) => {
    let value =
      value
      ->Option.map(B.from_decimal)
      ->Option.map(B.to_string)
      ->Option.getOr("")

    <div className="w-full grid grid-cols-[90%_10%]">
      <textarea
        value
        rows={5}
        disabled={true}
        className="px-4 py-2 border border-black flex-1 disabled:bg-gray-100 w-full"
      />
      <span className="bg-black text-white p-2 h-full flex justify-center items-center">
        {B.encoding->Encoding.to_symbol->React.string}
      </span>
    </div>
  }
}
