module PersonCommon
  extend ActiveSupport::Concern

  DIFF_FIELDS = %i(prefecture_id name name_kana nickname gender url wikipedia_url
                   twitter_username birthday blood_type height)
  PUBLISH_FIELDS = DIFF_FIELDS

  included do
    enumerize :blood_type, in: [:a, :b, :ab, :o]
    enumerize :gender, in: [:male, :female]

    validates :name, presence: true
    validates :url, url: { allow_blank: true }
    validates :wikipedia_url, url: { allow_blank: true }

    def attributes=(params)
      super
      self.birthday = Date.parse(params[:birthday])
    end

    def to_diffable_hash
      data = self.class::DIFF_FIELDS.inject({}) do |hash, field|
        hash[field] = case field
        when :media
          send(field).to_s
        else
          send(field)
        end

        hash
      end

      data.delete_if { |_, v| v.blank? }
    end
  end
end
