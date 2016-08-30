module Guidance
  class Report < ReportBase
    ALIGNMENT_FILENAME = "MSA.MAFFT.aln.With_Names".freeze
    SCORES_FILENAME = "MSA.MAFFT.Guidance2_res_pair_col.scr".freeze

    def tool_id
      @profile_report.tool_for_alignment.id
    end

    def run_successful?
      @run_successful ||=
        Dir.exist?(@run.path_to_output) &&
        FileTest.exist?(File.join(@run.path_to_output, ALIGNMENT_FILENAME)) &&
        FileTest.exist?(File.join(@run.path_to_output, SCORES_FILENAME)) &&
        FileTest.exist?(@v.path_to_stdout) &&
        FileTest.exist?(@v.path_to_stderr)
    end

    def save_tool_results
      save_original_output_files
      save_output_alignment
    end

    def save_original_output_files
      TextFile.create(file:         File.open(File.join(@run.path_to_output, ALIGNMENT_FILENAME)),
                      meta:         "original_guidance_alignment",
                      textifilable: @tool_report)
      TextFile.create(file:         File.open(File.join(@run.path_to_output, SCORES_FILENAME)),
                      meta:         "guidance_scores",
                      textifilable: @tool_report)
      @tool_report.decode_all_text_files
    end

    def save_output_alignment
      f = Tempfile.new(["guidance_filtered_alignment", ".fasta"])
      alignment = Guidance::FilterResidues.new(@run).run.alignment
      File.open(f, "w") {|f| f << alignment.output_fasta }
      TextFile.create(file:         f,
                      meta:         "output_alignment",
                      textifilable: @tool_report)
      filepath = @tool_report.get_file("output_alignment").file.path
      fasta_file = FastaFile.create(file: File.open(filepath), )
      alignment = Alignment.create(fasta_file: fasta_file)
      @profile_report.alignment = alignment
    end

  end
end
