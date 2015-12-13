class Report < OpenStruct
  def to_report
    {
      stdout:             stdout,
      stderr:             stderr,
      result:             text,
      start:              start,
      finish:             finish,
      directory_snapshot: directory_snapshot,
      jobid:              jobid,
      program:            program,
      version:            version,
      params:             params
    }
  end
end
