module Guidance
  class Report < ReportBase
    ALIGNMENT_FILENAME = "MSA.MAFFT.aln.With_Names".freeze
    SCORES_FILENAME = "MSA.MAFFT.Guidance2_res_pair_col.scr".freeze

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
                      textifilable: @tool_run_report)
      TextFile.create(file:         File.open(File.join(@run.path_to_output, SCORES_FILENAME)),
                      meta:         "guidance_scores",
                      textifilable: @tool_run_report)
    end

    def save_output_alignment
      f = Tempfile.new(["guidance_filtered_alignment", ".fasta"])
      alignment = Guidance::FilterResidues.new(@run).run.alignment
      File.open(f, "w") {|f| f << alignment.output_fasta }
      # FastaFile.create(file: File.open(f.path))
      TextFile.create(file:         f,
                      meta:         "output_alignment",
                      textifilable: @tool_run_report)
    ensure
      f.close
      f.unlink
    end
  end
end
