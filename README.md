# PkgTemplates

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://invenia.github.io/PkgTemplates.jl/stable)
[![Latest](https://img.shields.io/badge/docs-latest-blue.svg)](https://invenia.github.io/PkgTemplates.jl/latest)
[![Build Status](https://travis-ci.org/invenia/PkgTemplates.jl.svg?branch=master)](https://travis-ci.org/invenia/PkgTemplates.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/invenia/PkgTemplates.jl?svg=true)](https://ci.appveyor.com/project/invenia/PkgTemplates-jl)
[![CodeCov](https://codecov.io/gh/invenia/PkgTemplates.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/invenia/PkgTemplates.jl)

**PkgTemplates is a Julia package for creating new Julia packages in an easy,
repeatable, and customizable way.**

## Installation

`PkgTemplates` is registered in
[`METADATA.jl`](https://github.com/JuliaLang/METADATA.jl), so run
`Pkg.add("PkgTemplates")` for the latest release, or
`Pkg.clone("PkgTemplates")` for the development version.

## Usage

The simplest template only requires your GitHub username.

```julia
julia> using PkgTemplates

julia> t = Template(; user="invenia")

julia> generate("MyPkg", t; force=true)
INFO: Initialized git repo at /tmp/tmpvaHVki/MyPkg
INFO: Made initial empty commit
INFO: Set remote origin to https://github.com/invenia/MyPkg.jl
INFO: Staged 5 files/directories: src/, test/, REQUIRE, .gitignore, README.md
INFO: Committed files generated by PkgTemplates
INFO: Copying temporary package directory into /home/degraafc/.julia/v0.6/
INFO: Finished

julia> run(`ls -R $(Pkg.dir("MyPkg"))`)
/home/degraafc/.julia/v0.6/MyPkg:
README.md  REQUIRE  src  test

/home/degraafc/.julia/v0.6/MyPkg/src:
MyPkg.jl

/home/degraafc/.julia/v0.6/MyPkg/test:
runtests.jl
```
However, we can also configure a number of keyword arguments to `Template` and
`generate`:

```julia
julia> t = Template(;
           user="invenia",
           license="MIT",
           authors=["Chris de Graaf", "Invenia Technical Computing Corporation"],
           years="2016-2017",
           dir=joinpath(ENV["HOME"], "code"),
           julia_version=v"0.5.2",
           git_config=Dict("diff.renames" => true),
           plugins=[
               TravisCI(),
               CodeCov(; config_file=nothing),
               AppVeyor(),
               GitHubPages(; assets=[joinpath(ENV["HOME"], "invenia.css")]),
           ],
       )

julia> generate("MyPkg", t; force=true, ssh=true)
INFO: Initialized git repo at /tmp/tmpe0dWY5/MyPkg
INFO: Applying git configuration
INFO: Made initial empty commit
INFO: Set remote origin to git@github.com:invenia/MyPkg.jl.git
INFO: Created empty gh-pages branch
INFO: Staged 9 files/directories: src/, test/, REQUIRE, README.md, .gitignore, LICENSE, .travis.yml, .appveyor.yml, docs/
INFO: Committed files generated by PkgTemplates
INFO: Copying temporary package directory into /home/degraafc/code/
INFO: Finished
WARNING: Remember to push all created branches to your remote: git push --all
```

Information on each keyword as well as plugin types can be found in the
[documentation](https://invenia.github.io/PkgTemplates.jl/stable).

## Comparison to [PkgDev](https://github.com/JuliaLang/PkgDev.jl)

`PkgTemplates` is similar in functionality to `PkgDev`'s `generate` function.
However, `PkgTemplates` offers more customizability in templates and more
extensibility via plugins. For the package registration and release management
features that `PkgTemplates` lacks, you are encouraged to use
[AttoBot](https://github.com/apps/attobot) instead.