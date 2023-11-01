# frozen_string_literal: true

class TigerTeamStatus
  CONFLUENCE_URL = ENV['ATLASSIAN']
  TOKEN = ENV['TOKEN']

  def initialize(page, details)
    @page = page
    @details = details
  end

  def publish
    url = URI("#{ATLASSIAN_URL}/wiki/api/v2/pages/#{page}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Put.new(url)
    request["Accept"] = "application/json"
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Basic #{TOKEN}"
    request["Cookie"] = "atlassian.xsrf.token=896d576f67bdde7944eab26bfca691a740385389_lin"

    request.body = JSON.dump({
                               "id": "3006660629",
                               "status": "current",
                               "title": "Project Triage Page",
                               "body": {
                                 "value": "#{status_page}",
                                 "representation": "wiki"
                               },
                               "version": {
                                 "number": 38,
                                 "message": "List of tickets"
                               }
                             })

    response = https.request(request)
    puts response.read_body
  end

  private

  def current_page_version

  end
end
