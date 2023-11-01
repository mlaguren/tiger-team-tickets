require 'spec_helper'
require 'require_all'
require_all 'lib'

describe Categorizer do
  let(:new_issue) { [{:link=>"https://gazelle.atlassian.net/browse/HTT-2", :summary=>"Web Error", :priority=>"P2", :status=>"To Do"}] }

  it 'should place a new ticket in the new section' do
    new_section = Categorizer.new(new_issue).by_status
    expect(new_section[:new].size).to eq 1
  end

  let(:new_closed) { [{:link=>"https://gazelle.atlassian.net/browse/HTT-2", :summary=>"Web Error", :priority=>"P2", :status=>"Won't Fix"}] }

  it 'should place a new ticket in the closed section' do
    new_section = Categorizer.new(new_closed).by_status
    expect(new_section[:closed].size).to eq 1
  end

  let(:assigned) { [{:link=>"https://gazelle.atlassian.net/browse/API-1", :summary=>"Web Error", :priority=>"P2", :status=>"To Do"}] }

  it 'should place an assigned ticket in the assigned section' do
    assigned_section = Categorizer.new(assigned).by_status
    expect(assigned_section[:assigned].size).to eq 1
  end

  let(:resolved) { [{:link=>"https://gazelle.atlassian.net/browse/API-1", :summary=>"Web Error", :priority=>"P2", :status=>"Closed"}] }

  it 'should place a resolved ticket in the resolved section' do
    resolved_section = Categorizer.new(resolved).by_status
    puts resolved_section
    expect(resolved_section[:resolved].size).to eq 1
  end

  let(:wontfix) { [{:link=>"https://gazelle.atlassian.net/browse/API-1", :summary=>"Web Error", :priority=>"P2", :status=>"Won't Fix"}] }

  it 'should place a resolved ticket in the resolved section' do
    closed_assigned = Categorizer.new(wontfix).by_status
    expect(closed_assigned[:closed].size).to eq 1
  end
end