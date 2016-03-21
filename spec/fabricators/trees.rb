Fabricator(:tree) do
end

Fabricator(:tree_for_aligned_complicated_fasta, from: :tree) do
  newick "(Burkholderia_ambifaria_AMMD:0.64007858,Burkholderia_ambifaria_MC40-6:0.41030636,(Burkholderia_cenocepacia_AU_1054:0.52257743,(Burkholderia_cenocepacia_HI2424:0.53231903,(Burkholderia_cenocepacia_J2315:0.29381534,(Burkholderia_cenocepacia_MC0-3:0.51591989,Burkholderia_sp._383:0.41896907)0.927500:0.06881164)0.999291:0.09328626)0.960441:0.07769778)0.903333:0.07189468);"
end
