Fabricator(:fast_result) do
  group
  text_file do
    Fabricate(
      :text_file,
      file: File.open(File.join(Rails.root, "spec", "fixtures", "good_fast", "output.out"))
    )
  end
end
