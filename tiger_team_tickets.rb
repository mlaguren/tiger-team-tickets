# frozen_string_literal: true
require 'dotenv'
Dotenv.load

require "uri"
require "net/http"
require "json"
require 'base64'
require_relative 'lib/tiger_team_tickets'
require_relative 'lib/categorizer'

issues = TigerTeamTickets.new("TTTB").list_all
sorted_data = Categorizer.new(issues).by_status
puts sorted_data