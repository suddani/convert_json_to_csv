# frozen_string_literal: true

RSpec.describe ConvertJsonToCsv::LimitWrapper do
  let(:io) { double }
  let(:limit) { 0 }
  let(:header) { false }
  subject { described_class.new(io, limit, header) }

  it 'calls close on io object' do
    expect(io).to receive(:close)
    subject.close
  end

  it 'does not call puts if limit is 0' do
    expect(io).to_not receive(:puts)
    expect(subject).to receive(:should_exit!)
    subject.puts 'test'
  end

  context 'limit 1' do
    let(:limit) { 1 }

    it 'does calls puts' do
      expect(io).to receive(:puts)
      expect(subject).to receive(:should_exit!)
      subject.puts 'test'
    end

    it 'does calls puts once' do
      expect(io).to receive(:puts).once
      expect(subject).to receive(:should_exit!).exactly(3).times
      subject.puts 'test'
      subject.puts 'test'
      subject.puts 'test'
    end
  end
end
