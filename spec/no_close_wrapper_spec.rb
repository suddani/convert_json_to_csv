# frozen_string_literal: true

RSpec.describe ConvertJsonToCsv::NoCloseWrapper do
  let(:io) { double }
  subject { described_class.new(io) }

  it 'does not call close on io object' do
    expect(io).to_not receive(:close)
    subject.close
  end

  it 'does not call puts if limit is 0' do
    expect(io).to receive(:puts)
    subject.puts 'test'
  end

  it 'does calls puts once' do
    expect(io).to receive(:puts).exactly(3).times
    subject.puts 'test'
    subject.puts 'test'
    subject.puts 'test'
  end
end
