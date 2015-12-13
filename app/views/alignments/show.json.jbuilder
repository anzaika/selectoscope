json.id @alignment.id
json.fasta Identifier.tr(@alignment.fasta)
json.meta @alignment.meta
json.sequences @alignment.alignment.to_hash.each do |name, seq|
  json.name Identifier.find_by(codename: name).name
  json.seq seq
end
