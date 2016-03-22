class TextFile::AsCodemlOutput < ActiveType::Record[TextFile]

  after_create :process

  def process
    textifilable.process_output
  end

end
