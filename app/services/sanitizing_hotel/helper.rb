module SanitizingHotel
  module Helper
    CONCATENATE_WORDS = ['wifi']

    def fetch_request(url)
      response = ::RestClient::Request.execute(method: :get, url: url)
      JSON.parse(response.body)
    rescue StandardError => error
      message = 'Can not fetch data from Supplier'
      Rails.logger.error "#{message}  #{error}"
    end

    def downcase_concatenate_words(words)
      words = words.strip.split(' ').map do |word|
        if word.downcase.in?(CONCATENATE_WORDS)
          word.downcase
        else
          word
        end
      end
      words.join(' ').strip.underscore.gsub('_', ' ')
    end
  end
end
