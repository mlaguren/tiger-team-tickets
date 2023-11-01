# frozen_string_literal: true
require 'dotenv'
Dotenv.load

require "uri"
require "net/http"
require "json"
require_relative 'lib/tiger_team_tickets'
require_relative 'lib/categorizer'

issues = TigerTeamTickets.new("HTT").list_all
sorted_data = Categorizer.new(issues).by_status
TigerTeamStatus.new(2997846053, sorted_data).publish