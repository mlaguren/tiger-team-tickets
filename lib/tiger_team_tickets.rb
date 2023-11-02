# frozen_string_literal: true

class TigerTeamTickets

  JIRA_URL = ENV['ATLASSIAN']
  TOKEN = ENV['TOKEN']

  def initialize (project)
    @project = project
  end

  def list_all
    issue_details = []
    id = 1
    code = 1

    until code == "404" do
      url = URI("#{JIRA_URL}/rest/api/3/issue/#{@project}-#{id}")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Basic #{TOKEN}"
      response = https.request(request)

      if response.code != "404"
        json = JSON.parse response.read_body
        issue_details << {:link => "#{JIRA_URL}/browse/#{json['key']}", :summary => json['fields']['summary'], :priority => json['fields']['priority']['name'], :status => json['fields']['status']['name'] }
      else
        code = "404"
      end
      id += 1
    end
    return issue_details
  end

end
