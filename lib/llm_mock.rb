# frozen_string_literal: true

require "llm_mock/version"
require "llm_mock/provider"

# llm_mock is the shared foundation for a family of gems that fabricate LLM SDK
# response objects in tests — `llm_mock_anthropic`, and more providers to come.
#
# You don't usually depend on this gem directly; you pick a provider gem. This
# gem only defines the common contract (LlmMock::Provider) those providers
# implement, so tools like `deja` can drive any provider the same way.
module LlmMock
end
