using WackyOptions
using Documenter

makedocs(;
    modules=[WackyOptions],
    authors="tester",
    repo="https://github.com/tester/WackyOptions.jl/blob/{commit}{path}#L{line}",
    sitename="WackyOptions.jl",
    format=Documenter.HTML(;
        canonical="http://example.com",
        assets=[
            "assets/static.txt",
        ],
    ),
    pages=[
        "Home" => "index.md",
    ],
    bar="baz",
    foo="bar",
)
