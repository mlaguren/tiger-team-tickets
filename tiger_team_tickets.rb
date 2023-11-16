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

project = ENV['PROJECT']
page = ENV['PAGE']

issues = TigerTeamTickets.new(project).list_all
sorted_data = Categorizer.new(issues, project).by_status

TigerTeamStatus.new(page, sorted_data).publish

