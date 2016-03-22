json.id @alignment.id
json.fasta @alignment.to_fasta_string
json.meta @alignment.meta
json.sequences @alignment.to_hash.each do |name, seq|
  json.name name
  json.seq seq
end
