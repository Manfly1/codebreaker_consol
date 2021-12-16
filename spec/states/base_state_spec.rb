# frozen_string_literal: true

RSpec.describe States::BaseState do
  subject(:command) { described_class.new }

  describe '#interact' do
    it 'raises NotImplementedError' do
      expect { command.interact }.to raise_error(NotImplementedError)
    end
  end
end
