namespace :document_vault do
  domain = ENV['DOCUMENT_VAULT_URL'] || 'http://www.time3.dev'


  @session = ActionDispatch::Integration::Session.new(Rails.application)

  desc "TODO"
  task cache: :environment do
    # Get authenticity_token
    response = HTTParty.get("#{domain}/admin/sign_in")
    token = response.body.match(/<[^<]+authenticity_token[^>]+value="([^"]+)"[^>]+>/)[1]

    pp response.body.match(/<[^<]+authenticity_token[^>]+value="([^"]+)"[^>]+>/)

    # Login with authenticity_token and get cookie
    response = HTTParty.post("#{domain}/admin/sign_in", {
      :query => {
        "utf8" => "✓",
        "authenticity_token" => token,
        "administrator" => {
          "email"=>"remco@wirelab.nl",
          "password"=>"wirefresh",
          "remember_me"=>"0"
        }
      }
    })
    cookie = response.header['Set-Cookie']

    # TODO Cache views/admin/documents
    accounts = Account.ids
    accounts.each do |accountId|
      HTTParty.get("#{domain}/admin/accounts/#{accountId}/documents")
    end
  end
end

# require 'net/http'
#
# url = URI.parse('http://www.example.com/index.html')
# req = Net::HTTP::Get.new(url.to_s)
# res = Net::HTTP.start(url.host, url.port) {|http|
#   http.request(req)
# }
# puts res.body
