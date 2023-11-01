# frozen_string_literal: true

require 'spec_helper'
require 'require_all'
require_all 'lib'

describe TigerTeamStatus do
  it 'should return a page version number' do
    version = TigerTeamStatus.new(2997846053,"test").current_page_version
    expect(version).not_to eq 0
  end

  it 'should publish a page' do
    details = TigerTeamStatus.new(2997846053,"test").publish
    puts details
  end
end
