# frozen_string_literal: true

module LlmMock
  # The contract every provider mock implements (llm_mock_anthropic, and more to
  # come), so a consumer like the `deja` gem can drive any provider uniformly.
  #
  # A provider encapsulates one LLM SDK's *shape* for tests:
  #   - how to build a stub client whose methods route through a responder,
  #   - how to invoke the real SDK (when something isn't cached),
  #   - how to serialize/deserialize that SDK's response objects to/from the plain
  #     hashes a cache stores.
  #
  # Subclasses raise NotImplementedError for anything they don't provide.
  class Provider
    # Build a stub object shaped like the real SDK client. Every SDK method it
    # exposes must call `responder.call(method_name, kwargs)` and return the
    # result. The responder is supplied by the consumer (e.g. deja's cache layer),
    # so the provider stays ignorant of caching.
    def build_client(&responder)
      raise NotImplementedError, "#{self.class} must implement #build_client"
    end

    # Invoke the real SDK method on a live client — used to make the actual call
    # when there's no cached response. `method` is the symbol the stub captured.
    def call_real(client, method, kwargs)
      raise NotImplementedError, "#{self.class} must implement #call_real"
    end

    # Provider response object -> plain Hash (must round-trip through #deserialize).
    def serialize(method, response)
      raise NotImplementedError, "#{self.class} must implement #serialize"
    end

    # Plain Hash -> an object shaped like the SDK's response.
    def deserialize(method, data)
      raise NotImplementedError, "#{self.class} must implement #deserialize"
    end

    # A human-readable prompt string stored alongside cached calls for auditing.
    # Optional — defaults to nil.
    def prompt_for(_kwargs)
      nil
    end

    # A callable (-> { ... }) that builds a live SDK client. Optional — consumers
    # may supply their own instead.
    def default_real_client
      raise NotImplementedError, "#{self.class} must implement #default_real_client"
    end
  end
end
