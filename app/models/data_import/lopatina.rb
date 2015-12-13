module DataImport
  class Lopatina

    DEFAULT_PATH =
      File.join(Rails.root, 'data/2014_07_11', 'idStrainSeqAll.csv.gz')
    PATTERNS =
      File.join(Rails.root, 'data/2014_07_11', 'idPatternsort.csv.gz')

    def read_patterns
      Zlib::GzipReader.open(PATTERNS) do |gz|
        @patterns_raw = gz.readlines
      end
    end

    def read_data(path = DEFAULT_PATH)
      Zlib::GzipReader.open(path) do |gz|
        @data = gz.readlines
      end
      puts 'Success'
    end

    def import
      read_data
      load_orgs
      load_groups
      load_genes
      puts 'Success'
    end

    def load_orgs
      @data.map{|l| line_to_org(l)}
           .uniq
           .each{|org| Organism.create(name: org)}
    end

    def load_groups
      @data.map{|l| line_to_group(l)}
           .uniq
           .each{|id| Group.create(lopatina_id: id)}
    end

    def load_genes
      @data.each_slice(8000) do |slice|
        Parallel.each(slice, :in_processes => 8) do |l|
          Gene.create(
            organism: Organism.find_by(name: line_to_org(l)),
            group:    Group.find_by(lopatina_id: line_to_group(l)),
            sequence: line_to_gene(l)
          )
        end
      end
    end

    def line_to_org(line)
      line.split(',')[1].chomp.split(' ').join('_')
    end

    def line_to_group(line)
      line.split(',')[0].to_i
    end

    def line_to_gene(line)
      line.split(',')[2].chomp
    end

    def generate_patterns_table
      read_patterns
      Dir.mkdir("tmp/export")
      Dir.chdir("tmp/export")
      @patterns_raw.map{ |l| l.split.last }.uniq.each do |pattern|
        Dir.mkdir(pattern)
      end
      @patterns = @patterns_raw.map{ |l| l.split }.to_h
    end

    def group_by_group_id
      generate_patterns_table
      result = Hash.new("")
      read_data
      @data.each do |line|
        result[line_to_group(line).to_s] += ">#{line_to_org(line)}\n#{line_to_gene(line)}\n"
      end
      puts result.keys.count
      result.each do |key, value|
        File.open("#{@patterns[key]}/" + key + ".fasta", "w"){ |f| f << value}
      end
      puts 'Success'
    end

  end
end
