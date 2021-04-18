# frozen_string_literal: true

RSpec.describe ConvertJsonToCsv do
  let(:data) { [] }

  let(:input) { HashArrayReader.new(data) }
  let(:output) { instance_double(Printer) }
  let(:keys) { nil }
  let(:filter) { nil }
  let(:header) { true }

  context 'convert_to_csv' do
    subject do
      described_class.convert_to_csv(
        input, output,
        keys: keys,
        filter: filter,
        header: header
      )
    end
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
        let(:data) { [{ name: 'test', age: 18 }] }
        it { expect(output).to have_received(:puts).twice }
        it do
          expect(output).to have_received(:puts).with("name,age\n")
          expect(output).to have_received(:puts).with("test,18\n")
        end
        context 'no header' do
          let(:header) { false }
          it { expect(output).to have_received(:puts).once }
          it do
            expect(output).to have_received(:puts).with("test,18\n")
          end
        end
      end

      context 'multi entry' do
        let(:data) { [{ name: 'test', age: 18 }, { name: 'other', age: 21 }] }
        it { expect(output).to have_received(:puts).exactly(3).times }
        it do
          expect(output).to have_received(:puts).with("name,age\n")
          expect(output).to have_received(:puts).with("test,18\n")
          expect(output).to have_received(:puts).with("other,21\n")
        end

        context 'no header' do
          let(:header) { false }
          it { expect(output).to have_received(:puts).twice }
          it do
            expect(output).to have_received(:puts).with("test,18\n")
            expect(output).to have_received(:puts).with("other,21\n")
          end
        end

        context 'filter' do
          let(:data) { [{ name: 'test', age: 18 }, { name: 'middle', age: 21 }, { name: 'other', age: 31 }] }
          let(:filter) { ['age', ['21']] }
          it { expect(output).to have_received(:puts).twice }
          it do
            expect(output).to have_received(:puts).with("name,age\n")
            expect(output).to have_received(:puts).with("middle,21\n")
          end

          context 'no header' do
            let(:header) { false }
            it { expect(output).to have_received(:puts).once }
            it do
              expect(output).to have_received(:puts).with("middle,21\n")
            end
          end
        end
      end

      context 'multi entry missing keys' do
        let(:data) { [{ name: 'test', age: 18 }, { name: 'other', age: 21, missing: 'not shown' }] }
        it { expect(output).to have_received(:puts).exactly(3).times }
        it do
          expect(output).to have_received(:puts).with("name,age\n")
          expect(output).to have_received(:puts).with("test,18\n")
          expect(output).to have_received(:puts).with("other,21\n")
        end
        context 'no header' do
          let(:header) { false }
          it { expect(output).to have_received(:puts).twice }
          it do
            expect(output).to have_received(:puts).with("test,18\n")
            expect(output).to have_received(:puts).with("other,21\n")
          end
        end

        context 'given keys 1' do
          let(:keys) { ['name'] }
          it { expect(output).to have_received(:puts).exactly(3).times }
          it do
            expect(output).to have_received(:puts).with("name\n")
            expect(output).to have_received(:puts).with("test\n")
            expect(output).to have_received(:puts).with("other\n")
          end
          context 'no header' do
            let(:header) { false }
            it { expect(output).to have_received(:puts).twice }
            it do
              expect(output).to have_received(:puts).with("test\n")
              expect(output).to have_received(:puts).with("other\n")
            end
          end
        end

        context 'given keys 3' do
          let(:keys) { %w[name missing age] }
          it { expect(output).to have_received(:puts).exactly(3).times }
          it do
            expect(output).to have_received(:puts).with("name,missing,age\n")
            expect(output).to have_received(:puts).with("test,,18\n")
            expect(output).to have_received(:puts).with("other,not shown,21\n")
          end

          context 'no header' do
            let(:header) { false }
            it { expect(output).to have_received(:puts).twice }
            it do
              expect(output).to have_received(:puts).with("test,,18\n")
              expect(output).to have_received(:puts).with("other,not shown,21\n")
            end
          end
        end
      end
    end
  end
end
