@react.component
let make = (~encoding: Encoding.t, ~value: string) => {
  <div className="w-full grid grid-cols-[90%_10%]">
    <textarea
      value
      rows={5}
      disabled={true}
      className="px-4 py-2 border border-black flex-1 disabled:bg-gray-100 w-full"
    />
    <span className="bg-black text-white p-2 h-full flex justify-center items-center">
      {encoding->Encoding.to_symbol->React.string}
    </span>
  </div>
}
