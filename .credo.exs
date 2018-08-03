%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/"],
        excluded: []
      },
      checks: [
        {Credo.Check.Design.TagTODO, false},
        {Credo.Check.Readability.MaxLineLength, max_length: 120},
      ]
    }
  ]
}
