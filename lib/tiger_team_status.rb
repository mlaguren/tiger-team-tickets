class TigerTeamStatus
  include Base64
  CONFLUENCE_URL = ENV['ATLASSIAN']
  ATLASSIAN_AUTH = Base64.encode64("#{ENV['ATLASSIAN_EMAIL']}:#{ENV['ATLASSIAN_TOKEN']}").gsub(/\n/, '')

  def initialize(page, details)
    @page = page
    @details = details
    @url = URI("#{CONFLUENCE_URL}/wiki/api/v2/pages/#{page}")
  end
  def current_page_version

    https = Net::HTTP.new(@url.host, @url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(@url)
    request["Authorization"] = "Basic #{ATLASSIAN_AUTH}"

    response = https.request(request)
    json = JSON.parse response.read_body
    return json['version']['number']

  end

  def create_page

    new_section = "h1. New Issues\n||Project||Issue||Priority||Status||\n"

    @details[:new].each do | issue |
      new_section <<"|#{issue[:link][/.*browse\/(.*)-/,1]}|[#{issue[:summary]}|#{issue[:link]}]|#{issue[:priority]}|#{issue[:status]}|\n"
    end

    assigned_section = "h1. Assigned Issues\n||Project||Issue||Priority||Status||\n"

    @details[:assigned].each do | issue |
      assigned_section <<"|#{issue[:link][/.*browse\/(.*)-/,1]}|[#{issue[:summary]}|#{issue[:link]}]|#{issue[:priority]}|#{issue[:status]}|\n"
    end

    resolved_section = "h1. Resolved\n||Project||Issue||Priority||Status||\n"

    @details[:resolved].each do | issue |
      resolved_section << "|#{issue[:link][/.*browse\/(.*)-/,1]}|[#{issue[:summary]}|#{issue[:link]}]|#{issue[:priority]}|#{issue[:status]}|\n"
    end

    closed_section = "h1. Closed\n||Project||Issue||Priority||Status||\n"

    @details[:closed].each do | issue |
      closed_section << "|#{issue[:link][/.*browse\/(.*)-/,1]}|[#{issue[:summary]}|#{issue[:link]}]|#{issue[:priority]}|#{issue[:status]}|\n"
    end

    new_section+assigned_section+resolved_section+closed_section
  end
  def publish
    version = self.current_page_version
    page_details = JSON.dump({ id: @page,
        status: "current",
        title: "#{ENV['PAGE_TITLE']}",
        body: {
          "value": self.create_page,
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
       request["Authorization"] = "Basic #{ATLASSIAN_AUTH}"

       request.body = page_details

       response = https.request(request)
       return response.read_body
    end
end
