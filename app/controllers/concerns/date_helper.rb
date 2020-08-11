# frozen_string_literal: true

# Needed to format date
module DateHelper
  extend ActiveSupport::Concern

  class_methods do
    def format_to_ymd(date)
      date.present? && date.strftime('%B %e, %Y')
    end

    def time_ago(date)
      return false if date.blank?
      int_time = (Time.current-date).to_i

      case int_time
        when 0 then 'just now'
        when 1..59 then int_time.to_s+' sec'
        when 60..3540 then (int_time/60).to_i.to_s+' min'
        when 3541..7100 then '1 hour' # 3600 = 1 hour
        when 7101..82800 then ((int_time+99)/3600).to_i.to_s+' hours'
        when 82801..172000 then '1 day' # 86400 = 1 day
        when 172001..432000 then ((int_time+800)/(60*60*24)).to_i.to_s+' days'
        else format_to_ymd(date)
      end
    end
  end
end
