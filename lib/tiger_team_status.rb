# frozen_string_literal: true

class TigerTeamStatus
  CONFLUENCE_URL = ENV['ATLASSIAN']
  TOKEN = ENV['TOKEN']

  def initialize(page, details)
    @page = page
    @details = details
    @url = URI("#{CONFLUENCE_URL}/wiki/api/v2/pages/#{page}")
  end

  def publish

    version = self.current_page_version
    page_details = JSON.dump({ id: @page,
        status: "current",
        title: "Project Triage Page",
        body: {
          "value": "#{@details}",
          "representation": "wiki"
        },
        version: {
          "number": "#{version+1}",
          "message": "List of tickets"
        }
      }
    )

    https = Net::HTTP.new(@url.host, @url.port)
    https.use_ssl = true

    request = Net::HTTP::Put.new(@url)
    request["Accept"] = "application/json"
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Basic #{TOKEN}"
    request["Cookie"] = "atlassian.xsrf.token=896d576f67bdde7944eab26bfca691a740385389_lin"

    request.body = page_details

    response = https.request(request)
    return response.read_body
  end

  def current_page_version

    https = Net::HTTP.new(@url.host, @url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(@url)
    request["Authorization"] = "Basic bWVsdmluLmxhZ3VyZW5AZWNvYXRtLmNvbTpBVEFUVDN4RmZHRjBXVWYyN1dNREVqek5ybmp3d2FWOFlHTldrc2R3aE5KZEZDa0F5VnViQTlrZE5IQlpZX1NfLUtUUDFzUGtzYlM4NlNEUXpydFZrcko4dlFiYkQyUWdTRGlXUmVtU3pFaTJsRm5WbW02RVFNSV9MVzZKcGZPUmJEeTB5UXo5VW04YUFHNkdBVjhaZ2NQQWVuTEhaTGEtWks2YW1pUDBfODVJZkJwN2t2REJOMUU9MzJCRjY1N0E="

    response = https.request(request)
    json = JSON.parse response.read_body
    return json['version']['number']

  end
end
