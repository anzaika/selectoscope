Fabricator(:fast_result) do
end

Fabricator(:fast_result_good, from: :fast_result) do
  text_file { Fabricate(:good_fast_output) }
end
