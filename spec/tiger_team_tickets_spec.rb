# frozen_string_literal: true

require 'spec_helper'
require 'require_all'
require_all 'lib'

describe TigerTeamTickets do
  it 'should return an array of tickets' do
    list = TigerTeamTickets.new("HTT").list_all
    expect(list.size).to be > 0
  end

  it 'should have an element with the correct keys' do
    list = TigerTeamTickets.new("HTT").list_all
    element_keys = list[0].keys
    expect(element_keys).to eq [:link, :summary, :priority, :status]
  end
end
