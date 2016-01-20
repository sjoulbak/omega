class Requester
  include HTTParty
  debug_output

  def initialize
    base_uri = ENV['CACHE_URL'] || 'http://www.time3.dev'
    @email = ENV['CACHE_EMAIL']
    @password = ENV['CACHE_PASSWORD']
  end

  def login
    login_with_token(get_authenticity_token)
  end

  def cache_document_vaults(accountIds)
    accountIds.each do |accountId|
      self.class.get("/admin/accounts/#{accountId}/documents", headers: { 'Cookie' => @cookie })
    end
  end

  private

  def get_authenticity_token
    response = self.class.get("/admin/sign_in")
    set_cookie(response)
    response.body.match(/<[^<]+authenticity_token[^>]+value="([^"]+)"[^>]+>/)[1]
  end

  def login_with_token(token)
    response = self.class.post("/admin/sign_in", {
      body: {
        "utf8" => "✓",
        "authenticity_token" => token,
        "administrator" => {
          "email" => @email,
          "password" => @password
        }
      },
      headers: { 'Cookie' => @cookie }
    })
    set_cookie(response)
  end

  def set_cookie(response)
    @cookie = response.header['Set-Cookie']
  end
end

namespace :cache do
  desc "Cache all document vaults"
  task document_vaults: :environment do
    requester = Requester.new
    requester.login
    requester.cache_document_vaults(Account.ids)
  end
end
