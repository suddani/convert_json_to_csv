# frozen_string_literal: true

RSpec.describe JsonToCsv::MultiWrapper do
  let(:io) { [double, double] }
  subject { described_class.new(io) }

  it 'does not call close on io object' do
    io.each do |i|
      expect(i).to receive(:close)
    end
    subject.close
  end

  it 'does not call puts if limit is 0' do
    io.each do |i|
      expect(i).to receive(:puts)
    end
    subject.puts 'test'
  end

  it 'does calls puts once' do
    io.each do |i|
      expect(i).to receive(:puts).exactly(3).times
    end
    subject.puts 'test'
    subject.puts 'test'
    subject.puts 'test'
  end
end
