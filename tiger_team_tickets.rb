# frozen_string_literal: true
require 'dotenv'
Dotenv.load

require "uri"
require "net/http"
require "json"
require 'base64'
require_relative 'lib/tiger_team_tickets'
require_relative 'lib/categorizer'
require_relative 'lib/tiger_team_status'
issues = TigerTeamTickets.new("TTTB").list_all
sorted_data = Categorizer.new(issues).by_status


puts TigerTeamStatus.new(1640431617, sorted_data).publish

