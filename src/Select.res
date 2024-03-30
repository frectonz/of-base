@react.component
let make = (
  ~name: string,
  ~options: array<string>,
  ~value: Encoding.t,
  ~on_select: Encoding.t => unit,
) => {
  let onChange = e => Encoding.from_string((e->ReactEvent.Form.target)["value"])->on_select

  <div className="w-full grid grid-cols-1">
    <label> {React.string(name)} </label>
    <select name className="px-4 py-2" value={Encoding.to_string(value)} onChange>
      {options->Array.map(x => <option key={x}> {React.string(x)} </option>)->React.array}
    </select>
  </div>
}
