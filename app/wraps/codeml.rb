class Codeml < Wrapper
  PROGRAM = "PAML-codeml".freeze
  EXECUTABLE = "cdmw.py".freeze
  INPUT_ALIGNMENT = "aligned.fasta".freeze
  INPUT_TREE = "tree.nwk".freeze
  OUTPUT = "output.out".freeze
end
