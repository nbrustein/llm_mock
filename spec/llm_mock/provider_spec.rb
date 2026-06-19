# frozen_string_literal: true

RSpec.describe LlmMock::Provider do
  subject(:provider) { described_class.new }

  it "raises NotImplementedError for the methods a subclass must define" do
    expect { provider.build_client {} }.to raise_error(NotImplementedError)
    expect { provider.call_real(nil, :create, {}) }.to raise_error(NotImplementedError)
    expect { provider.serialize(:create, nil) }.to raise_error(NotImplementedError)
    expect { provider.deserialize(:create, {}) }.to raise_error(NotImplementedError)
    expect { provider.default_real_client }.to raise_error(NotImplementedError)
  end

  it "defaults prompt_for to nil" do
    expect(provider.prompt_for({})).to be_nil
  end
end
