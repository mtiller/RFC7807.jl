module RFC7807

using JSON

Base.@kwdef struct ProblemType 
    type::String="about:blank"
    title::String=""
    status::Union{Int64,Nothing}=nothing
end

export ProblemType

Base.@kwdef struct ProblemDetail
    type::String="about:blank"
    title::String=""
    status::Union{Int64,Nothing}=nothing
    detail::String=""
    instance::String=""
    extensions::Dict{Symbol,Any}=Dict{Symbol,Any}()
end

function Base.:(==)(a::ProblemDetail, b::ProblemDetail)
    a.type == b.type && a.title == b.title && a.status == b.status && 
    a.detail == b.detail && a.instance == b.instance && a.extensions == b.extensions
end

export ProblemDetail

function instance(t::ProblemType, instance::String="", detail::String=""; kwargs...)
    ProblemDetail(type=t.type, title=t.title, status=t.status, detail=detail, instance=instance, extensions=Dict{Symbol, Any}(kwargs...))
end

export instance

function JSON.print(stream::IO, value::ProblemDetail)
    ret = copy(value.extensions)
    ret[:type] = value.type 
    ret[:title] = value.title
    ret[:instance] = value.instance
    ret[:detail] = value.detail
    JSON.print(stream, ret)
end

end # module RFC7807
