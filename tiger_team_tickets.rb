# frozen_string_literal: true
require 'dotenv'
Dotenv.load

require "uri"
require "net/http"
require "json"
require_relative 'lib/tiger_team_tickets'

issues = TigerTeamTickets.new("HTT").list_all