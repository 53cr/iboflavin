module Enumerable
  def includes_all?(*args)
    results = []
    args.each do |arg|
      if arg.kind_of? Enumerable
        arg.each {|a| results << self.includes_all?(a)}
      else
        results << self.include?(arg)
      end
    end
    results.all? 
  end
end