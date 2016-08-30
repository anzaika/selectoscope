Fabricator(:text_file) do
  transient :content
  textifilable { Fabricate(:tool_run_report) }
  file do |attrs|
    f = Tempfile.new(Faker::Lorem.word)
    content = attrs[:content] || Faker::Lorem.paragraphs(5).join("\n")
    f.write(content)
    f.rewind
    File.open(f.path)
  end
end
