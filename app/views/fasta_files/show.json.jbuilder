json.id @fasta_file.id
json.fasta @fasta_file.to_fasta_string
json.sequences @fasta_file.to_hash.each do |name, seq|
  json.name name
  json.seq seq
end
