# frozen_string_literal: true

class Categorizer
  def initialize(issues, project)
    @issues = issues
    @project = project
  end

  def by_status

    sections = {
      "new": [],
      "assigned": [],
      "resolved": [],
      "closed": []
    }

    @issues.each do | issue |
      if issue[:link].include? @project
        if issue[:status] == "To Do"
          sections[:new] << issue
        else
          sections[:closed] << issue
        end
      else
        case issue[:status]
        when "To Do"
          sections[:assigned] << issue
        when "Closed"
          sections[:resolved] << issue
        when "Won't Fix"
          sections[:closed] << issue
        end
      end
    end
    sections
  end
end
