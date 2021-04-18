# frozen_string_literal: true

RSpec.describe JsonToCsv do
  let(:data) { [] }

  let(:input) { HashArrayReader.new(data) }
  let(:output) { instance_double(Printer) }

  context 'find_all_keys' do
    subject { described_class.find_all_keys(input, output) }
    context 'Wrong data format' do
      let(:input) { DirectReader.new(data) }
      let(:data) { ['something'] }
      it { expect { subject }.to raise_error(JSON::ParserError) }
    end

    context do
      before do
        allow(output).to receive(:puts)
        subject
      end

      context 'empty data' do
        it { expect(output).to_not have_received(:puts) }
      end

      context 'single entry' do
        let(:data) { [{ name: 'test' }] }
        it { expect(output).to have_received(:puts) }
        it { expect(output).to have_received(:puts).with('name') }
      end

      context 'multi entry' do
        let(:data) { [{ name: 'test', age: 18 }, { name: 'test', age: 18 }] }
        it { expect(output).to have_received(:puts).exactly(2).times }
        it 'prints all keys' do
          expect(output).to have_received(:puts).with('name')
          expect(output).to have_received(:puts).with('age')
        end
      end

      context 'missing entry' do
        let(:data) { [{ name: 'test', age: 18 }, { address: 'street' }, { name: 'test', age: 18 }] }
        it { expect(output).to have_received(:puts).exactly(3).times }
        it 'prints all keys' do
          expect(output).to have_received(:puts).with('name')
          expect(output).to have_received(:puts).with('age')
          expect(output).to have_received(:puts).with('address')
        end
      end
    end
  end
end
