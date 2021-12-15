# frozen_string_literal: true

RSpec.describe States::ConsoleState do
  subject(:state) { described_class.new(console) }

  let(:console) { instance_double('Console') }

  before do
    allow(console).to receive(:change_state_to)
  end

  describe '#interact' do
    let(:registration_state) { instance_double(States::RegistrationState) }
    
    it 'puts message to console' do
      expect { console.interact }.to output(/#{I18n.t(:hello)}/).to_stdout
    end

    it "moves to registration state if user has entered '#{described_class::COMMANDS[:start]}'" do
      allow(state).to receive(:handle_exit_or_unexpected).and_return(described_class::COMMANDS[:start])
      allow(console).to receive(:puts)
      allow(States::RegistrationState).to receive(:new).and_return(registration_state)
      console.interact
      expect(console).to have_received(:change_state_to).with(registration_state)
    end

    it "puts rules if user has entered '#{described_class::COMMANDS[:rules]}'" do
      allow(state).to receive(:handle_exit_or_unexpected).and_return(described_class::COMMANDS[:rules])
      expect { console.interact }.to output(/Game Rules/).to_stdout
    end

    it 'put invalid command message if user has entered invalid command' do
      allow(state).to receive(:handle_exit_or_unexpected).and_return('invalid_command')
      expect { console.interact }.to output(/#{I18n.t(:wrong_command_message)}/).to_stdout
    end
  end
end
