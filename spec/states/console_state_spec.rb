# frozen_string_literal: true

RSpec.describe States::ConsoleState do
  subject(:console) { described_class.new }

  let(:state) { instance_double(States::GameState) }

  before do
    allow(state).to receive(:context=).with(console)
    allow(state).to receive(:interact)
  end

  describe '#change_state_to' do
    it 'moves game to another state' do
      console.change_state_to(state)
      expect(console.instance_variable_get(:@game_state)).to eql state
    end
  end

  describe '#start' do
    before do
      allow(States::MenuState).to receive(:new).and_return(state)
    end

    it 'moves game to menu state' do
      console.action
      expect(console.instance_variable_get(:@game_state)).to eql state
    end
  end
end
