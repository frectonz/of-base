@react.component
let make = () => {
  let (from, setFrom) = React.useState(_ => Encoding.Decimal)
  let (to, setTo) = React.useState(_ => Encoding.Binary)

  let from_options = Encoding.options->Array.filter(x => x != to)->Encoding.to_strings
  let to_options = Encoding.options->Array.filter(x => x != from)->Encoding.to_strings

  let title = `${Encoding.to_string(from)} to ${Encoding.to_string(to)} Converter`

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
      <div className="flex w-full">
        <input className="px-4 py-2 border border-black flex-1" />
        <span className="bg-black text-white px-2 h-full flex justify-center items-center text-xs">
          {from->Encoding.to_symbol->React.string}
        </span>
      </div>
      <div className="flex gap-2">
        <button className="px-4 py-2 bg-black text-white"> {React.string("Convert")} </button>
        <button className="px-4 py-2 border border-black"> {React.string("Reset")} </button>
        <button className="px-4 py-2 border border-black"> {React.string("Swap")} </button>
      </div>
    </div>
    <Display encoding={to} value={""} />
  </div>
}
