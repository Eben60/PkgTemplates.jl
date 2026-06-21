module ExtractCiActionsVersions
using YAML

function collect_uses!(node::Dict, results::Vector{String})
    for (k, v) in node
        if k == "uses" && v isa AbstractString && occursin("@", v)
            push!(results, v)
        end
        collect_uses!(v, results)
    end
    return results
end

function collect_uses!(node::AbstractVector, results::Vector{String})
    for item in node
        collect_uses!(item, results)
    end
    return results
end

function collect_uses!(node, results::Vector{String})
    return results
end

split_versions(results) = Dict{String, String}(split(r, "@", limit=2)[1] => r for r in results)

function extract_ci_actions_versions()
    ci_file = joinpath(dirname(@__DIR__), ".github", "workflows", "CI.yml")
    dict = YAML.load_file(ci_file)
    results = String[]
    collect_uses!(dict, results)
    unique!(results)
    return split_versions(results)
end

end # module

const CI_ACTIONS = ExtractCiActionsVersions.extract_ci_actions_versions()

