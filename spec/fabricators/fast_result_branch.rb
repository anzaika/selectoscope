Fabricator(:fast_result_branch) do
  fast_result
  number { sequence(:fast_result_branch_number) }
  l0 { Faker::Number.decimal(12, 8) }
  l1 { Faker::Number.decimal(12, 8) }
end
