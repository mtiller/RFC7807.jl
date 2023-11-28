using RFC7807
using JSON
using Test

# {
#     "type": "https://example.com/probs/out-of-credit",
#     "title": "You do not have enough credit.",
#     "detail": "Your current balance is 30, but that costs 50.",
#     "instance": "/account/12345/msgs/abc",
#     "balance": 30,
#     "accounts": ["/account/12345",
#                  "/account/67890"]
# }

pt = ProblemType(
    type="https://example.com/probs/out-of-credit",
    title="You do not have enough credit."
)

pd1 = instance(pt)
@test pd1 == ProblemDetail(
    type="https://example.com/probs/out-of-credit",
    title="You do not have enough credit.",
    detail="",
    instance="",
)

pd2 = instance(pt, "/account/12345/msgs/abc", "Your current balance is 30, but that costs 50."; balance=25)
@test pd2 == ProblemDetail(
    type="https://example.com/probs/out-of-credit",
    title="You do not have enough credit.",
    detail="Your current balance is 30, but that costs 50.",
    instance="/account/12345/msgs/abc",
    extensions=Dict{Symbol,Any}(:balance=>25)
)

@test json(pd2)=="""{"type":"https://example.com/probs/out-of-credit","instance":"/account/12345/msgs/abc","title":"You do not have enough credit.","detail":"Your current balance is 30, but that costs 50.","balance":25}"""
