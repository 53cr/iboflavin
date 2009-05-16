require 'fastercsv'

def parse(file)
  FasterCSV.new(File.read(file),:col_sep=>'^',:quote_char=>'~').read
end
