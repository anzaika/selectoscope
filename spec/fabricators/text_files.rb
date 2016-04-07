Fabricator(:text_file) do
end

Fabricator(:good_fast_output, from: :text_file) do
  meta 'fast_result'
  file do
    File.open(File.join(Rails.root,
                        'spec',
                        'fixtures',
                        'good_fast',
                        'output.out'))
  end
  textifilable { Fabricate(:fast_result) }
end
