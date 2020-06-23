class OverallQuizRespService
  def initialize response, lo
    @response = response
    @lo = lo
  end

  def call
    final_resp_json
  end

  def final_resp_json
    {
      final_message: final_message,
      sub_heading: sub_heading,
      assement_scheme: assement_scheme
    }
  end

  def final_message
    score, out_of = get_score
    "You have scored #{score} points out of #{out_of}"
    "Your correct answers are 3 out of 5"
    "You have scored #{score}%"
  end

  def sub_heading
    "#{correct_count}/#{total_count} answers are correct!"
  end

  def assement_scheme

  end

  def total_points
    response.sum(&:points_earned)
  end

  def correct_count
    response.count(&:is_correct)
  end

  def total_count
    response.size
  end

  # def incorrect_count
  #   response.count { |i| !i.is_correct }
  # end

  def get_score

  end
end
