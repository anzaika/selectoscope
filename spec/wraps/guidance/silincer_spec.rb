require "rails_helper"

alignment = %{>1a
---atgattacc---
>2a
---atgattacc---
>5a
---atgattactttc
>3a
atgtttattacc---
>6a
atgtttattacc---
>4a
atgatttttacc---
>7a
atgatttttacc---
}

scores = %{#COL_NUMBER     #RES_PAIR_COLUMN_SCORE
1       0.966667
2       0.966667
3       0.966667
4       0.830476
5       0.830476
6       0.830476
7       0.830476
8       0.830476
9       0.830476
10      0.830476
11      0.830476
12      0.830476
#END
}

output = %{>1a
---NNNNNNNNN---
>2a
---NNNNNNNNN---
>5a
---NNNNNNNNNTTC
>3a
ATGNNNNNNNNN---
>6a
ATGNNNNNNNNN---
>4a
ATGNNNNNNNNN---
>7a
ATGNNNNNNNNN---
}

RSpec.describe Guidance::Silencer do
  let(:v) { Vault.new }
  describe "execute" do

    context "given a Vault with alignment and scores files" do
      it "returns a FASTA string" do
        v
        FileUtils.mkdir(File.join(v.dir, Guidance::OUTPUT))

        v.write_to_file(alignment, Guidance::ALIGNMENT)
        v.write_to_file(scores, Guidance::SCORES)

        res = Guidance::Silencer.new({vault: v}).execute
        norm = Bio::Alignment::MultiFastaFormat.new(output).alignment.output_fasta
        expect(res).to eq(norm)
      end
    end
  end
end
