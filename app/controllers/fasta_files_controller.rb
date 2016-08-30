class FastaFilesController < ApplicationController
  def show
    @fasta_file = FastaFile.find(params[:id])
  end
end
