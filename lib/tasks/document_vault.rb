require 'net/http'

namespace :document_vault do
  domain = ENV['DOCUMENT_VAULT_URL'] || 'http://www.time3.dev/'
  url = URI.parse("#{domain}/admin")

  @session = ActionDispatch::Integration::Session.new(Rails.application)

  desc "TODO"
  task cache: :environment do
    # Get authenticity_token
    response = @session.get("/admin/sign_in")
    token = @session.response.body.match(/<[^<]+authenticity_token[^>]+value="([^"]+)"[^>]+>/)[1]

    # Login with authenticity_token and get cookie
    @session.post("/admin/sign_in", {
      "utf8" => "✓",
      "authenticity_token" => token,
      "administrator" => {
        "email"=>"remco@wirelab.nl",
        "password"=>"wirefresh",
        "remember_me"=>"0"
    }})
    cookie = @session.response.header['Set-Cookie']

    # TODO Cache views/admin/documents
    accounts = Account.ids
    accounts.each do |accountId|
      @session.get("/admin/accounts/#{accountId}/documents")
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
