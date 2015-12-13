json.id @group.id
json.sequences @group.alignment.alignment.to_hash.each do |name, seq|
  json.name name
  json.seq seq
end
