module CurationConcern
  class SeniorThesisActor < CurationConcern::BaseActor

    def create!
      super
      create_thesis_file
      update_contained_generic_file_visibility
    end

    def update!
      super
      update_thesis_file
      update_contained_generic_file_visibility
    end

    protected
    def thesis_file
      return @thesis_file if defined?(@thesis_file)
      @thesis_file = attributes.delete(:thesis_file)
    end

    def create_thesis_file
      if thesis_file
        generic_file = GenericFile.new
        Sufia::GenericFile::Actions.create_metadata(
          generic_file, user, curation_concern.pid
        )
        attach_file(generic_file, thesis_file)
      end
    end

    def update_thesis_file
      if thesis_file
        generic_file = curation_concern.current_thesis_file
        attach_file(generic_file, thesis_file)
      end
    end

    def update_contained_generic_file_visibility
      if visibility_may_have_changed?
        curation_concern.generic_files.each do |f|
          f.set_visibility(visibility)
        end
      end
    end


  end
end