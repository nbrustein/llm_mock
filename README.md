# llm_mock

When you test code that calls an LLM API, one robust approach is to **stub the
client and hand back a canned response object** — no network, no flakiness, no
cost. But every provider's SDK returns differently-shaped objects (messages,
content blocks, tool calls, streams), and constructing those by hand is fiddly.
The `llm_mock` family solves that per provider: `llm_mock_anthropic`,
`llm_mock_gemini`, and so on, each giving you ergonomic builders for that SDK's
response objects.

**`llm_mock` itself is just the shared foundation.** You almost never depend on
it directly — you pick a provider gem. This gem exists so that:

- every provider mock implements the **same contract**, and
- tools that orchestrate testing (like [`deja`](https://github.com/nbrustein/deja),
  which records and replays real LLM calls) can drive **any** provider through
  one interface instead of special-casing each SDK.

## Who depends on this

```
your test ──► llm_mock_anthropic ──► llm_mock   (the contract)
deja ─────────► llm_mock_anthropic ──► llm_mock
```

You want **`llm_mock_anthropic`** (or another provider gem). It pulls in
`llm_mock` for you.

## The contract

A provider gem subclasses `LlmMock::Provider` and implements the parts it
supports:

| Method | Purpose |
| --- | --- |
| `build_client(&responder)` | Return a stub client; each SDK method calls `responder.call(method, kwargs)`. |
| `call_real(client, method, kwargs)` | Invoke the real SDK method on a live client. |
| `serialize(method, response)` | SDK response object → plain Hash (for caching). |
| `deserialize(method, data)` | Plain Hash → an object shaped like the SDK response. |
| `prompt_for(kwargs)` | Optional readable prompt string for audit logs. |
| `default_real_client` | Optional `-> { ... }` that builds a live SDK client. |

That's the whole gem: a namespace and one abstract class. The interesting code
lives in the provider gems.

## License

MIT — see [LICENSE](LICENSE).
