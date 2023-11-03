# frozen_string_literal: true

require 'spec_helper'
require 'require_all'
require_all 'lib'

describe TigerTeamStatus do
  it 'should return a page version number' do
    version = TigerTeamStatus.new(1640431617,"test").current_page_version
    expect(version).not_to eq 0
  end

  let(:issues) { {:new=>[{:link=>"https://gazelle.atlassian.net/browse/HTT-2", :summary=>"Web Error", :priority=>"P2", :status=>"To Do"}], :assigned=>[{:link=>"https://gazelle.atlassian.net/browse/API-749", :summary=>"API Bug - JIRA Test From Melvin", :priority=>"P2", :status=>"To Do"}], :resolved=>[], :closed=>[]} }

  it 'should generate a wiki page' do
    page_details = TigerTeamStatus.new(3006660629, issues).create_page
    expect(page_details).to eq "h1. New Issues
||Project||Issue||Priority||Status||
|HTT|[Web Error|https://gazelle.atlassian.net/browse/HTT-2]|P2|To Do|
h1. Assigned Issues
||Project||Issue||Priority||Status||
|API|[API Bug - JIRA Test From Melvin|https://gazelle.atlassian.net/browse/API-749]|P2|To Do|
h1. Resolved
||Project||Issue||Priority||Status||
h1. Closed
||Project||Issue||Priority||Status||
"
  end

  let(:details) { {:new=>[{:link=>"https://gazelle.atlassian.net/browse/HTT-2", :summary=>"Web Error", :priority=>"P2", :status=>"To Do"}], :assigned=>[{:link=>"https://gazelle.atlassian.net/browse/API-749", :summary=>"API Bug - JIRA Test From Melvin", :priority=>"P2", :status=>"To Do"}], :resolved=>[], :closed=>[]} }
  it 'should publish a page' do
    page = TigerTeamStatus.new(1640431617,details).publish
  end

end
