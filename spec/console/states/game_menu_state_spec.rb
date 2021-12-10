# frozen_string_literal: true

RSpec.describe GameMenuState do
  subject(:menu_state) { described_class.new(console) }

  let(:console) { Console.new }

  describe '#interact' do
    let(:message) { I18n.t('menu.introduction') }
    let(:commands) { ConsoleState::COMMANDS }
    let(:incorrect_input) { 'incorrect' }

    context 'success' do
      it 'when starting interraction' do
        allow(menu_state).to receive(:choose_from_menu)
        expect { menu_state.interact }.to output(message).to_stdout
      end
    end

    context 'false' do
      it { expect { menu_state.menu(ConsoleState::COMMANDS[:exit]) }.to raise_error }
    end
  end

  describe '#choose_from_menu' do
    after { menu_state.interact }
    it { expect(menu_state).to receive(:choose_from_menu) }
  end
end
