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

project = "HTT"

issues = TigerTeamTickets.new(project).list_all
sorted_data = Categorizer.new(issues, project).by_status

TigerTeamStatus.new(3006660629, sorted_data).publish

