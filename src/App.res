@react.component
let make = () => {
  let (from, setFrom) = React.useState(_ => Encoding.Decimal)
  let (to, setTo) = React.useState(_ => Encoding.Binary)

  let from_options = Encoding.options->Array.filter(x => x != to)->Encoding.to_strings
  let to_options = Encoding.options->Array.filter(x => x != from)->Encoding.to_strings

  let title = `${Encoding.to_string(from)} to ${Encoding.to_string(to)} Converter`

  let module(InputBase) = Base.from_encoding(from)
  module Input = Base.MakeInput(InputBase)

  let module(OutputBase) = Base.from_encoding(to)
  module Output = Base.MakeOutput(OutputBase)

  let (input, setInput): (
    option<InputBase.t>,
    (option<InputBase.t> => option<InputBase.t>) => unit,
  ) = React.useState(_ => None)

  <div className="p-6 max-w-[800px]">
    <h1 className="text-3xl font-semibold"> {React.string(title)} </h1>
    <div className="my-4 grid grid-cols-2 gap-4">
      <Select name="From" options={from_options} value={from} on_select={f => setFrom(_ => f)} />
      <Select name="To" options={to_options} value={to} on_select={t => setTo(_ => t)} />
    </div>
    <div className="my-4 grid gap-2 grid-cols-1">
      <label>
        {React.string(`Enter a ${from->Encoding.to_string->String.toLowerCase} number`)}
      </label>
      <Input value={input} on_change={i => setInput(_ => i)} />
      <div className="flex gap-2">
        <button className="px-4 py-2 bg-black text-white"> {React.string("Convert")} </button>
        <button className="px-4 py-2 border border-black"> {React.string("Reset")} </button>
        <button className="px-4 py-2 border border-black"> {React.string("Swap")} </button>
      </div>
    </div>
    <Output value={input->Option.map(InputBase.to_decimal)} />
  </div>
}
