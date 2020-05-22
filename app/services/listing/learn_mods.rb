# frozen_string_literal: true

module Listing
  # Needed to filter characters
  class LearnMods < Listing::Base
    def initialize(args)
      super
    end

    def data
      @learn_mods = @learn_mods.order("#{sort_column} #{sort_order}")
      @learn_mods = @learn_mods.paginate(page: params[:page],
                                         per_page: LearnMod::PER_PAGE)
      serialize_rec(@learn_mods).merge!(pagination_hsh(@learn_mods, LearnMod))
    end

    def base_record
      @learn_mods = LearnMod.joins(:world)
                            .includes(:lead_designer, :sme, :intro_video,
                                      :learn_mod_skills, :global_skills,
                                      :learn_mod_organizations,
                                      :learn_mod_intro_docs, :global_resources)
      return unless params[:search].present?

      @learn_mods = @learn_mods.search(params[:search])
    end

    def serializer
      LearnModSerializer
    end

    def sort_array
      %w[learn_mods.name created_at time_to_complete learning_objects_count]
    end

    def default_col
      'id'
    end
  end
end
