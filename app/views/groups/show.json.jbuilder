json.id @group.id
json.sequences @group.alignment.to_hash.each do |name, seq|
  json.name name
  json.seq seq
end
