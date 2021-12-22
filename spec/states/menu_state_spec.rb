# frozen_string_literal: true

RSpec.describe States::MenuState do
  subject(:state) { described_class.new }

  let(:context) { instance_double(States::ConsoleState) }

  before do
    allow(context).to receive(:change_state_to)
    state.context = context
  end

  describe '#interact' do
    let(:registration_state) { instance_double(States::RegistrationState) }

    it 'puts message to ConsoleState' do
      allow(state).to receive(:user_input).and_return('start')
      expect { state.interact }.to output(/#{I18n.t('menu_state.introduction')}/).to_stdout
    end

    it "moves to registration state if user has entered 'start'" do
      allow(state).to receive(:user_input).and_return('start')
      allow(state).to receive(:puts)
      allow(States::RegistrationState).to receive(:new).and_return(registration_state)
      state.interact
      expect(context).to have_received(:change_state_to).with(registration_state)
    end

    it 'put invalid command message if user has entered invalid command' do
      allow(state).to receive(:user_input).and_return('invalid_command')
      expect { state.interact }.to output(/#{I18n.t('base_state.wrong_command')}/).to_stdout
    end
  end
end
