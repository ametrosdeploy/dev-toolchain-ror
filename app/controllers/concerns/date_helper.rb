module DateHelper
  extend ActiveSupport::Concern

  class_methods do
    def format_to_ymd(date)
      date.present? && date.strftime('%B %e, %Y')
    end
  end
end
